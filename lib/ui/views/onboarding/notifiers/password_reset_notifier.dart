import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:powerhouse/core/mixins/_mixins.dart';
import 'package:powerhouse/core/models/_models.dart';
import 'package:powerhouse/services/_services.dart';
import 'package:powerhouse/ui/views/onboarding/states/password_reset_state.dart';

// typedef State = ViewState<PasswordResetState>;
typedef State = PasswordResetState;

class PasswordResetNotifier extends StateNotifier<State>
    with DialogAndSheetMixin, ToastMixin {
  final INavigationService navigationService;
  final IAuthenticationService authenticationService;
  final IForceUpdateAppService forceUpdateAppService;

  PasswordResetNotifier({
    required this.authenticationService,
    required this.navigationService,
    required this.forceUpdateAppService,
  }) : super(PasswordResetInitialState()) {
    addListener((state) {
      if (state is PasswordResetFailureState) {
        _logger.e(state.failure.toDebugString());
        showFailureToast(state.failure.message);
      }
    });
  }

  final formKey = GlobalKey<FormState>();
  final _logger = Logger();

  Future<void> sendResetCode(String email) async {
    try {
      if (!formKey.currentState!.validate()) return;
      FocusManager.instance.primaryFocus?.unfocus();
      state = PasswordResetLoadingState();
      await authenticationService.resetPassword(email.trim());
      state = PasswordResetSuccessState();
      navigateBack();
      showSuccessToast("Success! Check your email for next steps.");
    } on Failure catch (e) {
      state = PasswordResetFailureState(e);
    }
  }

  void navigateBack() => navigationService.pop();
}

final passwordResetNotifier =
    StateNotifierProvider.autoDispose<PasswordResetNotifier, State>(
  (ref) => PasswordResetNotifier(
    navigationService: ref.watch(navigationService),
    authenticationService: ref.watch(authenticationService),
    forceUpdateAppService: ref.watch(forceUpdateService),
  ),
);
