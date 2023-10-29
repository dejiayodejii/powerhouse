import 'package:get_storage/get_storage.dart';

import 'key_value_storage_service.dart';

class GetStorageService implements KeyValueStorageService {
  final _storage = GetStorage();

  @override
  Future<void> init() async {
    await _storage.initStorage;
  }

  @override
  Future<void> saveNum({required String key, required num value}) async {
    await _storage.write(key, value);
  }

  @override
  Future<void> saveString({required String key, required String value}) async {
    await _storage.write(key, value);
  }

  @override
  Future<void> saveBool({required String key, required bool value}) async {
    await _storage.write(key, value);
  }

  @override
  Future<void> saveList({required String key, required List value}) async {
    await _storage.write(key, value);
  }

  @override
  Future<void> saveMap(
      {required String key, required Map<String, dynamic> value}) async {
    await _storage.write(key, value);
  }

  @override
  num? readNum({required String key}) {
    return _storage.read<num>(key);
  }

  @override
  String? readString({required String key}) {
    return _storage.read<String>(key);
  }

  @override
  bool? readBool({required String key}) {
    return _storage.read<bool>(key);
  }

  @override
  List? readList({required String key}) {
    return _storage.read<List>(key);
  }

  @override
  Map<String, dynamic>? readMap({required String key}) {
    return _storage.read<Map<String, dynamic>>(key);
  }

  @override
  Future<void> delete({required String key}) async {
    return await _storage.remove(key);
  }
}
