import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:powerhouse/core/models/_models.dart';
import 'package:powerhouse/services/_services.dart';

abstract class IAuthenticationService {
  /// [Future]<[void]> Signs up a user
  ///
  /// Parameters: [SignupModel] model containing the user sign up details
  Future<void> signUp(UserModel userDetails);

  /// [Future]<[void]> Sends a user a reset code
  ///
  /// Parameters: [String] email of the user
  Future<void> resetPassword(String email);

  /// [Future]<[UserModel]> Signs in a user
  ///
  /// Parameters: `User Email` and `User Password`
  Future<UserModel> signIn(String email, String password);

  /// [Future]<[void]> Updates a user's details
  ///
  /// Parameters: `User Full Name` and `Date of Birth`
  Future<void> updateProfile(String fullName, String dob);

  /// [Future]<[void]> Signs the currently logged in user out of the app
  ///
  /// Parameters: null
  Future<void> logOut();

  Future<void> deleteProfile(String userId);

  // returns the details of the current user
  UserModel? get currentUser;
}

final authenticationService = Provider<IAuthenticationService>(
  (ref) => AuthenticationService(
    keyValStorageService: ref.watch(keyValueStorageService),
  ),
);
