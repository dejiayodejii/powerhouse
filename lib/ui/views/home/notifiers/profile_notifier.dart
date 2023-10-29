import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:powerhouse/core/mixins/_mixins.dart';
import 'package:powerhouse/core/models/_models.dart';
import 'package:powerhouse/services/_services.dart';
import 'package:powerhouse/ui/constants/view_state.dart';
import 'package:powerhouse/ui/views/home/states/profile_view_state.dart';

import '../../../../app/router.dart';

typedef ProfileState = ViewState<ProfileViewState>;

class ProfileNotifier extends StateNotifier<ProfileState> with ToastMixin {
  final IUserService userService;
  final INavigationService navigationService;

  ProfileNotifier({
    required this.userService,
    required this.navigationService,
  }) : super(ProfileState.idle(
          ProfileViewState(user: userService.currentUser!),
        ));

  final formKey = GlobalKey<FormState>();
  String phone = '';

  void onDatePicked(DateTime date) {
    final _user = state.data!.user.copyWith(dateOfBirth: date);
    state = state.idle(state.data!..updateUser(_user));
  }

  Future<void> updateUser(UserModel user) async {
    try {
      state = state.loading();
      await userService.updateProfile(user);
      navigationService.pop();
      showSuccessToast("Profile Updated Succesfully");
    } catch (e) {
      showFailureToast(e.toString());
    } finally {
      state = state.idle();
    }
  }

    Future<void> deleteUser(String userId) async {
    try {
      state = state.loading();
      await userService.deleteProfile(userId);
       navigationService.replaceAll(Routes.onboardingView, (p0) => false);
      // navigationService.pop();
      showSuccessToast("Account deleted Succesfully");
    } catch (e) {
      showFailureToast(e.toString());
    } finally {
      state = state.idle();
    }
  }
}

final profileNotifier = StateNotifierProvider<ProfileNotifier, ProfileState>(
  (ref) => ProfileNotifier(
    userService: ref.read(userService),
    navigationService: ref.read(navigationService),
  ),
);
