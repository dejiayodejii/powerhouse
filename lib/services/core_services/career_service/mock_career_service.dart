import 'package:powerhouse/core/models/_models.dart';

import 'i_career_service.dart';

class MockCareerService extends ICareerService {
  @override
  Future<List<CareerModel>> fetchAllCareers() async {
    await Future.delayed(const Duration(seconds: 2));
    return mockCareers;
  }

  @override
  Future<List<MediaModel>> fetchCareerDetail(String id) async {
    await Future.delayed(const Duration(seconds: 2));
    return List.filled(20, mockMedia2);
  }
}

final mockCareers = [
  CareerModel(
    id: "123456",
    name: "How to prepare for your first job",
    desc: "Wondering how to ace your first job interview, here are some tips.",
    count: 2,
  ),
  CareerModel(
    id: "456789",
    name: "How to start a business",
    desc: "Whether you thinking about fashion or your fintech, start here.",
    count: 4,
  ),
  CareerModel(
    id: "123789",
    name: "How to find your purpose",
    desc: "Tech is all the rave now, here are new career paths you should try",
    count: 20,
  ),
];
