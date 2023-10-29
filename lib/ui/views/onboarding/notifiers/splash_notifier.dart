import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:launch_review/launch_review.dart';
import 'package:powerhouse/app/_app.dart';
import 'package:powerhouse/core/mixins/_mixins.dart';
import 'package:powerhouse/services/_services.dart';
import 'package:powerhouse/ui/constants/_constants.dart';
import 'package:powerhouse/ui/dialogs/confirmation_dialog.dart';

typedef State = AsyncValue<void>;

class SplashNotifier extends StateNotifier<State>
    with DialogAndSheetMixin, ToastMixin {
  final INavigationService navigationService;
  final IAuthenticationService authenticationService;
  final IForceUpdateAppService forceUpdateAppService;
  final KeyValueStorageService keyValueStorageService;

  SplashNotifier({
    required this.authenticationService,
    required this.navigationService,
    required this.forceUpdateAppService,
    required this.keyValueStorageService,
  }) : super(const AsyncValue.data(null));

  Future<void> init() async {
    final user = FirebaseAuth.instance.currentUser;
    await keyValueStorageService.init();
    final needsUpdate = await forceUpdateAppService.needsUpdate;
    navigationService.replaceWith(
        user == null ? Routes.onboardingView : Routes.mainView,
      );
    // if (needsUpdate) {
    //   showAppUpdateDialog();
    // } else {
    //   navigationService.replaceWith(
    //     user == null ? Routes.onboardingView : Routes.mainView,
    //   );
    // }
  }

  Future<void> showAppUpdateDialog() async {
    await showAppDialog(ConfirmationDialog(
      body: "New Update Available",
      buttonText: "Install Update",
      icon: AppAssets.updateAvailableSvg,
      canPop: false,
      onPressed: () {
        LaunchReview.launch(
          androidAppId: DynamicLinkService.appId,
          iOSAppId: DynamicLinkService.iosAppId,
        );
      },
    ));
  }

  void navigateBack() => navigationService.pop();
}

final splashNotifier = StateNotifierProvider.autoDispose<SplashNotifier, State>(
  (ref) => SplashNotifier(
    navigationService: ref.watch(navigationService),
    authenticationService: ref.watch(authenticationService),
    forceUpdateAppService: ref.watch(forceUpdateService),
    keyValueStorageService: ref.watch(keyValueStorageService),
  ),
);
