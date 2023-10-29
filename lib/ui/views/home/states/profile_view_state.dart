import 'package:powerhouse/core/models/_models.dart';

class ProfileViewState {
  UserModel user;

  ProfileViewState({
    required this.user,
  });

  void updateUser(UserModel user) {
    this.user = user;
  }
}
