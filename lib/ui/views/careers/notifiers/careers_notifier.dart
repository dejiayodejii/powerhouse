import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:powerhouse/app/router.dart';
import 'package:powerhouse/core/enums/_enums.dart';
import 'package:powerhouse/core/models/_models.dart';
import 'package:powerhouse/services/_services.dart';
import 'package:powerhouse/ui/constants/view_state.dart';

import '../states/careers_state.dart';

typedef State = ViewState<CareersState>;

class CareersNotifier extends StateNotifier<State> {
  final ICareerService careerService;
  final INavigationService navigationService;
  CareersNotifier({
    required this.careerService,
    required this.navigationService,
  }) : super(ViewState.idle(CareersState()));

  final _logger = Logger();

  void init() {
    fetchCareers();
  }

  void navigateToCareerDetail(CareerModel career) {
    // navigationService.navigateTo(Routes.careerDetailView, arguments: career);
  }

  Future<void> fetchCareers() async {
    try {
      state = state.loading();
      final _careers = await careerService.fetchAllCareers();
      state = state.idle(state.data!..careers = _careers);
    } on Failure catch (e) {
      _logger.e(e.toString());
      state = state.failure(e);
    } finally {
      state = state.idle();
    }
  }

  Future<List<MediaModel>> fetchCareerLibrary(CareerModel career) async {
    try {
      // state = state.loading();
      return await careerService.fetchCareerDetail(career.id);
    } on Failure catch (e) {
      _logger.e(e.toString());
      // state = state.failure(e);
    } finally {
      // state = state.idle();
    }
    return [];
  }

  void onMediaClick(MediaModel data) {
    if (data.type == MediaType.video) {
      navigationService.navigateTo(Routes.videoMediaDetailView,
          arguments: data);
    } else {
      navigationService.navigateTo(Routes.mediaDetailView, arguments: data);
    }
  }
}

final careersNotifier = StateNotifierProvider<CareersNotifier, State>(
  (ref) => CareersNotifier(
    careerService: ref.watch(careerService),
    navigationService: ref.watch(navigationService),
  ),
);