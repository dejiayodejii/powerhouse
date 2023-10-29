import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:powerhouse/core/constants/_constants.dart';
import 'package:powerhouse/core/models/_models.dart';
import 'package:powerhouse/services/_services.dart';

class AuthenticationService implements IAuthenticationService {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final KeyValueStorageService keyValStorageService;

  AuthenticationService({
    required this.keyValStorageService,
  });

  CollectionReference get _userColl => _firestore.collection(ApiKeys.users);

  @override
  Future<void> signUp(UserModel userInfo) async {
    try {
      final _user = await _auth.createUserWithEmailAndPassword(
          email: userInfo.email, password: userInfo.password!);
      userInfo = userInfo.copyWith(id: _user.user!.uid);
      //call the token endpoint and assign token to each user
      await _userColl.doc(userInfo.id).set(userInfo.toMap());
      await keyValStorageService.saveMap(
          key: StorageKeys.userData, value: userInfo.toMap());
    } on FirebaseAuthException catch (e) {
      throw Failure(message: e.message, stackTrace: e.stackTrace);
    }
  }

  @override
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw Failure(message: e.message, stackTrace: e.stackTrace);
    }
  }

  @override
  Future<UserModel> signIn(String email, String password) async {
    try {
      final _userCred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      final _user = await _userColl.doc(_userCred.user!.uid).get()
          as DocumentSnapshot<Map<String, dynamic>?>;
      await keyValStorageService.saveMap(
          key: StorageKeys.userData, value: _user.data()!);
      return UserModel.fromMap(_user.data()!);
    } on FirebaseAuthException catch (e) {
      throw Failure(message: e.message, stackTrace: e.stackTrace);
    }
  }

  @override
  Future<void> updateProfile(String fullName, String dob) async {
    try {
      final data = {
        "name": fullName,
        "dob": dob,
      };
      await _userColl.doc(currentUser!.id).update(data);
      final _user = await _userColl.doc(currentUser!.id).get()
          as DocumentSnapshot<Map<String, dynamic>?>;

      await keyValStorageService.saveMap(
          key: StorageKeys.userData, value: _user.data()!);
    } on FirebaseAuthException catch (e) {
      throw Failure(message: e.message, stackTrace: e.stackTrace);
    }
  }

  @override
  Future<void> deleteProfile(String userId) async {
     print('i am here 1');
    await _firestore.collection("users").doc(userId).delete();
    print('i am here 2');
    await _auth.currentUser?.delete();
     print('i am here 3');
//     FirebaseUser user = await FirebaseAuth.instance.currentUser();
// user.delete();
    await _auth.signOut();
    await keyValStorageService.delete(key: StorageKeys.userData);
    // _auth.signOut();
  }

  @override
  Future<void> logOut() async {
    await _auth.signOut();
    await keyValStorageService.delete(key: StorageKeys.userData);
  }

  @override
  UserModel? get currentUser {
    final data = keyValStorageService.readMap(key: StorageKeys.userData);
    if (data == null) return null;
    return UserModel.fromMap(data);
  }
}
