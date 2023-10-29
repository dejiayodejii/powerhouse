import 'dart:async';

import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:powerhouse/app/_app.dart';
import 'package:powerhouse/main.dart';
import 'package:powerhouse/services/_services.dart';
import 'package:powerhouse/ui/constants/_constants.dart';

const FirebaseOptions dev = FirebaseOptions(
  apiKey: 'AIzaSyAf-6Qsj32PDCZ_qHneAxtaQyhjZ4NShC4',
  appId: '1:162376616120:android:d55c1f615921e163c3cc4d',
  messagingSenderId: '162376616120',
  projectId: 'powerhouse-c73ed',
  // authDomain: 'dev-mandal.firebaseapp.com',
  // storageBucket: 'dev-mandal.appspot.com',
  // measurementId: 'G-4QB1SP63XB',
);

void main() async {
  await runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    FlavorConfig(flavor: Flavor.dev, appName: AppStrings.devAppName);
    await Firebase.initializeApp();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    await contextlessRef.read(dynamicLinkService).initialize();



    runApp(DevicePreview(
      enabled: kReleaseMode,
      builder: (context) => const ProviderScope(child: PowerHouse()),
    ));
  }, (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  });
}
