import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:powerhouse/ui/components/app_back_button.dart';
import 'package:powerhouse/ui/constants/_constants.dart';

class AboutView extends ConsumerWidget {
  const AboutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const YSpacing(20),
            const AppBackButton(),
            const YSpacing(20),
            Text(
              AppStrings.appName,
              style: AppTextStyles.kTextStyle(
                27,
                height: 39.84,
                weight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
            const YSpacing(20),
            Flexible(
              child: FittedBox(
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Image.asset(
                    AppAssets.appIconImage,
                    width: 200.w,
                  ),
                ),
              ),
            ),
            const YSpacing(30),
            Padding(
              padding: EdgeInsets.all(20.r),
              child: Text(
                "PowerHouse is a platform that makes friendship, mentorship, emotional support, motivation, and professional progress more accessible.\n\nIt's designed to compete with the impact that emotional stress and the mental health epidemic have on our daily lives, as well as the variables that lead to these problems.",
                textAlign: TextAlign.center,
                style: AppTextStyles.kTextStyle(
                  18,
                  color: AppColors.black.withOpacity(0.7),
                  height: 30,
                  spacing: 1.2,
                ),
              ),
            ),
            const YSpacing(20),
          ],
        ),
      ),
    );
  }
}
