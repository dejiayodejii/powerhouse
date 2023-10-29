import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:powerhouse/core/mixins/_mixins.dart';
import 'package:powerhouse/core/models/_models.dart';
import 'package:powerhouse/services/_services.dart';
import 'package:powerhouse/ui/dialogs/_dialogs.dart';

import '../state/fitness_state.dart';

typedef State = FitnessState;

class FitnessNotifier extends StateNotifier<State>
    with DialogAndSheetMixin, ToastMixin {
  final StateNotifierProviderRef<FitnessNotifier, State> ref;
  FitnessNotifier(this.ref) : super(const FitnessState(isLoading: true));

  INavigationService get _navigationService => ref.watch(navigationService);
  IFitnessService get _fitnessService => ref.watch(fitnessService);

  final _logger = Logger();

  Future<void> initialize() async {
    try {
      await _getCurrentDayPlan();
      await _get30dayprogress();
      await _getCurrentDayProgress();
    } on Failure catch (error) {
      _logger.e(error.message);
      state = state.error(error);
      showFailureToast(error.toString());
    }
  }

  Future<void> _getCurrentDayPlan() async {
    try {
      final fitnessDayPlan = await _fitnessService.getCurrentDayPlan();
      state = state.copyWith(dayPlan: fitnessDayPlan);
    } on Failure catch (error) {
      _logger.e(error.message);
      state = state.error(error);
      showFailureToast(error.toString());
    }
  }

  Future<void> _getCurrentDayProgress() async {
    try {
      final progress = await _fitnessService.getCurrentDayProgress();
      state = state.copyWith(userProgress: progress);
    } on Failure catch (error) {
      _logger.e(error.message);
      state = state.error(error);
      showFailureToast(error.toString());
    }
  }

  Future<void> _get30dayprogress() async {
    try {
      final progress = await _fitnessService.getMonthProgress();
      state = state.copyWith(pastProgress: progress);
    } on Failure catch (error) {
      _logger.e(error.message);
      state = state.error(error);
      showFailureToast(error.toString());
    }
  }

  void navigateBack() => _navigationService.pop();

  void onScheduleTap() => () {}; //showAppDialog(const ScheduleChatDialog());

  void onItemTap(int index, bool newVal) {
    final oldProgress = state.userProgress!;
    final progress = oldProgress.copyWith(
      breakfast: index == 0 ? newVal : oldProgress.breakfast,
      lunch: index == 1 ? newVal : oldProgress.lunch,
      dinner: index == 2 ? newVal : oldProgress.dinner,
      snacks: index == 3 ? newVal : oldProgress.snacks,
      workout: index == 4 ? newVal : oldProgress.workout,
    );
    _fitnessService.updateProgress(progress).then((res) {
      state = state.copyWith(userProgress: res);
    }).catchError((e, s) {
      _logger.e(e, s);
      state = state.copyWith(userProgress: oldProgress);
    });
    _get30dayprogress();
    state = state.copyWith(userProgress: progress);
  }

  void scheduleChat(DateTime? date, TimeOfDay? time) {
    try {
      if (date == null || time == null) {
        throw Failure(message: "Please select a date and time.");
      }
      _navigationService.pop();
      showAppDialog(const ConfirmationDialog(
        body: "Submitted",
        buttonText: "Done",
      ));
    } on Failure catch (e) {
      _logger.e(e.toString());
      showFailureToast(e.toString());
    }
  }

  void startLiveChat(String text) {
    try {
      if (text.isEmpty) throw Failure(message: "Please enter a message.");
      _navigationService.pop();
      showAppDialog(const ConfirmationDialog(
        body: "Submitted",
        buttonText: "Done",
      ));
    } on Failure catch (e) {
      _logger.e(e.toString());
      showFailureToast(e.toString());
    }
  }

  void onEmergencyTap() => () {}; //showAppDialog(const LiveChatDialog());

  void viewFullPlan() => showInfoToast("Coming Soon!!");
}

final fitnessNotifier = StateNotifierProvider<FitnessNotifier, State>(
  (ref) => FitnessNotifier(ref),
);
