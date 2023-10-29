import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:powerhouse/app/_app.dart';
import 'package:powerhouse/services/_services.dart';
import 'package:powerhouse/ui/constants/_constants.dart';

class SettingsButton extends HookConsumerWidget {
  const SettingsButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _navService = ref.read(navigationService);
    return Align(
      alignment: Alignment.centerRight,
      child: IconButton(
        onPressed: () => _navService.navigateTo(Routes.settingsView),
        iconSize: 25.sp,
        color: AppColors.black,
        icon: const Icon(Icons.settings),
      ),
    );
  }
}
