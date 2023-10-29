import 'package:equatable/equatable.dart';
import 'package:powerhouse/core/extensions/_extension.dart';
import 'package:powerhouse/core/models/_models.dart';

class FitnessState extends Equatable {
  final bool isLoading;
  final Failure? failure;
  final FitnessDayPlan? dayPlan;
  final FitnessProgress? userProgress;
  final List<FitnessProgress>? pastProgress;

  const FitnessState({
    this.isLoading = false,
    this.failure,
    this.dayPlan,
    this.userProgress,
    this.pastProgress,
  });

  FitnessState copyWith({
    bool? isLoading,
    Failure? failure,
    FitnessDayPlan? dayPlan,
    FitnessProgress? userProgress,
    List<FitnessProgress>? pastProgress,
  }) {
    return FitnessState(
      isLoading: isLoading ?? this.isLoading,
      failure: failure,
      dayPlan: dayPlan ?? this.dayPlan,
      userProgress: userProgress ?? this.userProgress,
      pastProgress: pastProgress ?? this.pastProgress,
    );
  }

  FitnessState loading() => copyWith(isLoading: true, failure: null);
  FitnessState error(Failure failure) =>
      copyWith(failure: failure, isLoading: false);

  bool get anyisNull =>
      dayPlan == null || userProgress == null || pastProgress == null;

  double? get graphInterval {
    if (pastProgress == null) return null;
    final first = pastProgress!.first.timestamp.minutesSinceEpoch;
    final last = pastProgress!.last.timestamp.minutesSinceEpoch;
    if (pastProgress!.length < 5) return Duration.minutesPerDay.toDouble();
    return (last - first) / 4;
  }

  @override
  List<Object?> get props => [
        isLoading,
        failure,
        dayPlan,
        userProgress,
        pastProgress,
      ];
}
