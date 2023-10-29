import 'package:powerhouse/core/enums/_enums.dart';
import 'package:powerhouse/core/models/_models.dart';
import 'package:powerhouse/ui/constants/view_state.dart';

class HomeViewState extends ViewState2 {
  final UserModel user;
  final List<FitnessProgress?> weekProgress;
  final bool showEmotions;
  final QuoteModel? quoteOfTheDay;
  final List<MediaModel> motivations;

  HomeViewState({
    required this.user,
    this.weekProgress = const [],
    this.showEmotions = true,
    this.quoteOfTheDay,
    this.motivations = const [],
    ViewState2? state,
  }) : super(state: state?.state ?? AppState.idle, error: state?.error);

  HomeViewState copyWith({
    UserModel? user,
    List<FitnessProgress?>? weekProgress,
    bool? showEmotions,
    QuoteModel? quoteOfTheDay,
    List<MediaModel>? motivations,
    ViewState2? viewState,
  }) {
    return HomeViewState(
      user: user ?? this.user,
      weekProgress: weekProgress ?? this.weekProgress,
      showEmotions: showEmotions ?? this.showEmotions,
      quoteOfTheDay: quoteOfTheDay ?? this.quoteOfTheDay,
      motivations: motivations ?? this.motivations,
      state: viewState ?? super.idle(),
    );
  }

  @override
  HomeViewState loading() {
    return copyWith(viewState: super.loading());
  }

  @override
  HomeViewState failure(Failure error) {
    return copyWith(viewState: super.failure(error));
  }
}
