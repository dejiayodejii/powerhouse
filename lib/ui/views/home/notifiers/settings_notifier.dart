import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:powerhouse/app/_app.dart';
import 'package:powerhouse/core/mixins/_mixins.dart';
import 'package:powerhouse/services/_services.dart';
import 'package:powerhouse/ui/constants/view_state.dart';
import 'package:powerhouse/ui/views/home/views/delete_confirmation.dart';

import '../../../../core/mixins/toast_mixin.dart';
import '../states/settings_view_state.dart';

typedef State = ViewState<SettingsViewState>;

class SettingsNotifier extends StateNotifier<State>
    with ToastMixin, DialogAndSheetMixin {
  final IAuthenticationService authService;
  final INavigationService navService;
  SettingsNotifier({
    required this.authService,
    required this.navService,
  }) : super(ViewState.idle(SettingsViewState()));

  void logout() {
    authService.logOut();
    navService.replaceAll(Routes.onboardingView, (p0) => false);
  }

  Future<void> deleteUser(String userId) async {
    try {
      print(userId);
      state = state.loading();
      await authService.deleteProfile(userId);
      navService.replaceAll(Routes.onboardingView, (p0) => false);
      // navigationService.pop();
      showSuccessToast("Account deleted Succesfully");
    } catch (e) {
      showFailureToast(e.toString());
    } finally {
      state = state.idle();
    }
  }

  Future<void> showSignUpSheet() async {
    await showAppBottomSheet(const DeleteSheet());
  }

  void navigateBack() => navService.pop();

  void navigateToAboutView() => navService.navigateTo(Routes.aboutView);

  void navigateToEditProfileView() =>
      navService.navigateTo(Routes.editProfileView);
}

final settingsNotifier = StateNotifierProvider<SettingsNotifier, State>((ref) {
  return SettingsNotifier(
    authService: ref.watch(authenticationService),
    navService: ref.watch(navigationService),
  );
});
