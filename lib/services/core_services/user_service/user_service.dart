import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:powerhouse/core/constants/_constants.dart';
import 'package:powerhouse/core/models/user_model.dart';
import 'package:powerhouse/services/_services.dart';

class UserService extends IUserService {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final KeyValueStorageService keyValStorageService;
  UserService({
    required this.keyValStorageService,
  });

  @override
  Future<void> saveEmotion() {
    // TODO: implement saveEmotion
    throw UnimplementedError();
  }

  @override
  Future<void> updateProfile(UserModel user) async {
    await _firestore.collection("users").doc(user.id).update(user.toMap());
    await keyValStorageService.saveMap(
        key: StorageKeys.userData, value: user.toMap());
  }

  @override
  Future<void> deleteProfile(String userId) async {
    await _firestore.collection("users").doc(userId).delete();
    // _auth.signOut();
  }

  @override
  UserModel? get currentUser {
    final data = keyValStorageService.readMap(key: StorageKeys.userData);
    if (data == null) return null;
    return UserModel.fromMap(data);
  }
}
