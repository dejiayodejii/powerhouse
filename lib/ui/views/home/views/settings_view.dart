import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:powerhouse/ui/components/_components.dart';
import 'package:powerhouse/ui/constants/_constants.dart';
import 'package:powerhouse/ui/views/home/notifiers/settings_notifier.dart';

class SettingsView extends HookConsumerWidget {
  const SettingsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(settingsNotifier.notifier);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(20.sp),
          child: Column(
            children: [
              const AppBackButton(),
              const YSpacing(20),
              const Divider(color: AppColors.veryLightGrey),
              const YSpacing(30),
              SettingsTile(
                leading: AppAssets.editProfileSvg,
                title: "Edit Profile",
                onTap: notifier.navigateToEditProfileView,
              ),
              SettingsTile(
                leading: AppAssets.aboutUsSvg,
                title: "About Us",
                onTap: notifier.navigateToAboutView,
              ),
              SettingsTile(
                leading: AppAssets.logoutSvg,
                title: "Logout",
                onTap: notifier.logout,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SettingsTile extends StatelessWidget {
  final String leading;
  final String title;
  final void Function()? onTap;
  const SettingsTile({
    Key? key,
    required this.leading,
    required this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SvgPicture.asset(leading),
      title: Text(
        title,
        style: AppTextStyles.semibold22.copyWith(
          fontWeight: FontWeight.normal,
        ),
      ),
      onTap: onTap,
    );
  }
}
