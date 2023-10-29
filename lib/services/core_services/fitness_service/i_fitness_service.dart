import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:powerhouse/core/models/_models.dart';
import 'package:powerhouse/services/_services.dart';

abstract class IFitnessService {
  Future<FitnessDayPlan> getCurrentDayPlan();
  Future<List<FitnessProgress>> getMonthProgress();
  Future<FitnessProgress> getCurrentDayProgress();
  Future<FitnessProgress> updateProgress(FitnessProgress progress);
  Future<List<FitnessProgress>> getWeeklyProgress();
}

final fitnessService = Provider<IFitnessService>((ref) {
  return FitnessService(
    userService: ref.watch(userService),
  );
});
