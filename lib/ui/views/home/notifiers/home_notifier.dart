import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:powerhouse/app/_app.dart';
import 'package:powerhouse/core/constants/_constants.dart';
import 'package:powerhouse/core/enums/_enums.dart';
import 'package:powerhouse/core/mixins/_mixins.dart';
import 'package:powerhouse/core/models/_models.dart';
import 'package:powerhouse/services/_services.dart';
import 'package:powerhouse/ui/constants/_constants.dart';
import 'package:powerhouse/ui/dialogs/_dialogs.dart';

import '../states/home_view_state.dart';

typedef State = HomeViewState;

class HomeNotifier extends StateNotifier<State>
    with DialogAndSheetMixin, ToastMixin {
  final IAuthenticationService authenticationService;
  final KeyValueStorageService storageService;
  final INavigationService navigationService;
  final IMediaService mediaService;
  final IFitnessService fitnessService;

  HomeNotifier({
    required this.authenticationService,
    required this.storageService,
    required this.navigationService,
    required this.mediaService,
    required this.fitnessService,
  }) : super(HomeViewState(user: authenticationService.currentUser!)) {
    state = state.copyWith(showEmotions: showEmotion).loading();
    _watchFailure();
  }

  final _logger = Logger();
  static const emotions = [
    Emotion(
      name: "Excited",
      icon: AppAssets.excitedFaceSvg,
    ),
    Emotion(
      name: "Frustrated",
      icon: AppAssets.frustratedFaceSvg,
    ),
    Emotion(
      name: "Sad",
      icon: AppAssets.sadFaceSvg,
    ),
  ];

  void init() {
    getQuoteOfTheDay();
    getWeeklyProgress();
    getMotivation();
  }

  void _watchFailure() {
    addListener((state) {
      if (state.hasError) {
        _logger.e(state.error!.message);
        showFailureToast(state.error!.message);
      }
    });
  }

  Future<void> getQuoteOfTheDay() async {
    try {
      final data = await mediaService.getQuoteOfTheDay();
      state = state.copyWith(quoteOfTheDay: data);
    } on Failure catch (e) {
      state = state.failure(e);
    }
  }

  Future<void> getWeeklyProgress() async {
    try {
      final data = await fitnessService.getWeeklyProgress();
      final report = List<FitnessProgress?>.filled(7, null, growable: true);
      report.replaceRange(0, data.length - 1, data);
      state = state.copyWith(weekProgress: report);
    } on Failure catch (e) {
      state = state.failure(e);
    }
  }

  Future<void> getMotivation() async {
    try {
      final data = await mediaService.fetchMotivations();
      state = state.copyWith(motivations: data);
    } on Failure catch (e) {
      state = state.failure(e);
    }
  }

  Future<void> onEmotionTap(Emotion e) async {
    try {
      final _date = DateTime.now();
      await showAppDialog(const ConfirmationDialog(body: "Mood Set"));
      await storageService.saveNum(
          key: StorageKeys.emotionSaveTime,
          value: _date.millisecondsSinceEpoch);
      state = state.copyWith(showEmotions: showEmotion);
    } on Failure catch (e) {
      state = state.failure(e);
    }
  }

  Future<void> createJournal() async {
    await showAppDialog(const NewJournalDialog());
  }

  void navigateToMediaDetail(MediaModel media) {
    if (media.type == MediaType.video) {
      navigationService.navigateTo(Routes.videoMediaDetailView,
          arguments: media);
    } else {
      navigationService.navigateTo(Routes.mediaDetailView, arguments: media);
    }
  }

  void navigateBack() => navigationService.pop();

  bool get showEmotion {
    final _date = DateTime.now();
    final _lastSaveTime =
        storageService.readNum(key: StorageKeys.emotionSaveTime);
    if (_lastSaveTime == null) return true;
    return _date.day !=
        DateTime.fromMillisecondsSinceEpoch(_lastSaveTime.toInt()).day;
  }
}

final homeNotifier = StateNotifierProvider<HomeNotifier, State>(
  (ref) => HomeNotifier(
    storageService: ref.watch(keyValueStorageService),
    navigationService: ref.watch(navigationService),
    authenticationService: ref.watch(authenticationService),
    mediaService: ref.watch(mediaService),
    fitnessService: ref.watch(fitnessService),
  ),
);
