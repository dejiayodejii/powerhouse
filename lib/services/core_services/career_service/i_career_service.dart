import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:powerhouse/core/models/_models.dart';

import 'mock_career_service.dart';

abstract class ICareerService {
  Future<List<CareerModel>> fetchAllCareers();
  Future<List<MediaModel>> fetchCareerDetail(String id);
}

final careerService = Provider<ICareerService>(
  (ref) => MockCareerService(),
);
