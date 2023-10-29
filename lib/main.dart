import 'package:device_preview/device_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:oktoast/oktoast.dart';
import 'package:powerhouse/app/_app.dart';
import 'package:powerhouse/services/_services.dart';
import 'package:powerhouse/ui/constants/_constants.dart';

import 'core/mixins/_mixins.dart';

final contextlessRef = ProviderContainer();

class PowerHouse extends HookConsumerWidget {
  const PowerHouse({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigator = ref.read(navigationService);
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (context, __) {
        return OKToast(
          child: MaterialApp(
            title: FlavorConfig.instance.appName,
            theme: AppTheme.theme,
            scrollBehavior: const CupertinoScrollBehavior(),
            onGenerateRoute: Routes.generateRoute,
            navigatorKey: navigator.navigatorKey,
            builder: DevicePreview.appBuilder,
            locale: DevicePreview.locale(context),
            scaffoldMessengerKey: ToastMixin.scaffoldkey,
          ),
        );
      },
    );
  }
}

// TODO: Add created_at and updated_at to all db data
// TODO: Add timeout to all firebase calls
// 
