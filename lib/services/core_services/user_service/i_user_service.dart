import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:powerhouse/core/models/_models.dart';
import 'package:powerhouse/services/_services.dart';

abstract class IUserService {
  /// [Future]<[void]> Saves user Emotion data to the database
  ///
  /// Parameters: null
  Future<void> saveEmotion();

  /// [Future]<[void]> Updates a user's details
  ///
  /// Parameters: `User Full Name` and `Date of Birth`
  Future<void> updateProfile(UserModel user);

    Future<void> deleteProfile(String userId);

  // returns the details of the current user
  UserModel? get currentUser;
}

final userService = Provider<IUserService>(
  (ref) => UserService(
    keyValStorageService: ref.watch(keyValueStorageService),
  ),
);
