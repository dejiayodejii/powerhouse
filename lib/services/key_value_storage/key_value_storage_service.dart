import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'get_storage_service.dart';

abstract class KeyValueStorageService {
  Future<void> init();
  Future<void> saveNum({required String key, required num value});
  Future<void> saveString({required String key, required String value});
  Future<void> saveBool({required String key, required bool value});
  Future<void> saveList({required String key, required List value});
  Future<void> saveMap(
      {required String key, required Map<String, dynamic> value});

  num? readNum({required String key});
  String? readString({required String key});
  bool? readBool({required String key});
  List? readList({required String key});
  Map<String, dynamic>? readMap({required String key});

  Future<void> delete({required String key});
}

final keyValueStorageService = Provider<KeyValueStorageService>(
  (ref) => GetStorageService()..init(),
);
