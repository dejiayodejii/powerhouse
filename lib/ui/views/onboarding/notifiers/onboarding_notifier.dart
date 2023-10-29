import 'dart:async';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:powerhouse/app/_app.dart';
import 'package:powerhouse/core/mixins/_mixins.dart';
import 'package:powerhouse/core/models/_models.dart';
import 'package:powerhouse/services/_services.dart';
import 'package:powerhouse/ui/bottom_sheets/_bottom_sheets.dart';
import 'package:powerhouse/ui/constants/_constants.dart';
import 'package:powerhouse/ui/dialogs/confirmation_dialog.dart';
import 'package:powerhouse/ui/views/onboarding/states/onboarding_state.dart';
import 'package:url_launcher/url_launcher.dart';

typedef State = AsyncValue<OnboardingState>;

class OnboardingNotifier extends StateNotifier<State>
    with DialogAndSheetMixin, ToastMixin {
  final INavigationService navigationService;
  final IAuthenticationService authenticationService;
  final IForceUpdateAppService forceUpdateAppService;

  OnboardingNotifier({
    required this.authenticationService,
    required this.navigationService,
    required this.forceUpdateAppService,
  }) : super(const AsyncValue.data(OnboardingState())) {
    _watchFailure();
  }

  final formKey = GlobalKey<FormState>();
  final _logger = Logger();

  void _watchFailure() {
    addListener((state) {
      state.whenOrNull(
        error: (error, stackTrace) {
          final e = error as Failure;
          _logger.e(e.message);
          showFailureToast(e.message);
        },
      );
    });
  }

  Future<void> showAppUpdateDialog() async {
    await showAppDialog(ConfirmationDialog(
      body: "New Update Available",
      buttonText: "Install Update",
      icon: AppAssets.updateAvailableSvg,
      canPop: false,
      onPressed: () {
        if (Platform.isAndroid) {
          launchUrl(Uri.parse(AppStrings.playStoreLink));
        }
      },
    ));
  }

  void onPageChanged(int value) {
    state = AsyncValue.data(state.value!.copyWith(pageIndex: value));
  }

  void onFieldChanged(String? val) {
    state = AsyncValue.data(
      state.value!.copyWith(showVisibilityIcon: val!.isNotEmpty),
    );
  }

  void togglePasswordVisibility() {
    state = AsyncValue.data(
      state.value!.copyWith(showPasword: !state.value!.showPasword),
    );
  }

  Future<void> showSignUpSheet() async {
    await showAppBottomSheet(const SignUpSheet());
  }

  void openResetPasswordSheet() {
    navigateBack();
    showAppBottomSheet(const ResetPasswordSheet());
  }

  Future<void> showSignInSheet() async {
    await showAppBottomSheet(const SignInSheet());
  }

  Future<void> login(String email, String password) async {
    try {
      if (!formKey.currentState!.validate()) return;
      FocusManager.instance.primaryFocus?.unfocus();
      state = const AsyncValue.loading();
      await authenticationService.signIn(email.trim(), password.trim());
       print('jiii');
      navigationService.replaceAll(Routes.mainView, (_) => false);
      showSuccessToast("Login Successful");
    } on Failure catch (e) {
      print('jiii');
      state = AsyncValue.error(e,StackTrace.current);
       print('mmmiii');
    } finally {
      state = const AsyncValue.data(OnboardingState());
    }
  }

  Future<void> signUp(UserModel user) async {
    try {
      if (!formKey.currentState!.validate()) return;
      FocusManager.instance.primaryFocus?.unfocus();
      state = const AsyncValue.loading();
      //call the endpoint to get token
      //then add the token as part of the user data
      //create a seperate collection for this so it will be easier to remove
      await authenticationService.signUp(user);
      navigationService.replaceAll(Routes.mainView, (_) => false);
      showSuccessToast("Welcome to Powerhouse");
    } on Failure catch (e) {
      state = AsyncValue.error(e,StackTrace.current);
    } finally {
      state = const AsyncValue.data(OnboardingState());
    }
  }

  void navigateBack() => navigationService.pop();
}

final onboardingNotifier =
    StateNotifierProvider.autoDispose<OnboardingNotifier, State>(
  (ref) => OnboardingNotifier(
    navigationService: ref.watch(navigationService),
    authenticationService: ref.watch(authenticationService),
    forceUpdateAppService: ref.watch(forceUpdateService),
  ),
);
