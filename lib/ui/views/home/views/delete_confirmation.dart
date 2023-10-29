import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:powerhouse/core/mixins/validator_mixin.dart';
import 'package:powerhouse/ui/components/_components.dart';
import 'package:powerhouse/ui/constants/_constants.dart';
import 'package:powerhouse/ui/views/home/notifiers/profile_notifier.dart';
import 'package:powerhouse/ui/views/home/notifiers/settings_notifier.dart';

class DeleteSheet extends HookConsumerWidget with ValidatorMixin {
  const DeleteSheet({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier2 = ref.watch(settingsNotifier.notifier);
    final state2 = ref.watch(settingsNotifier);
    final state = ref.watch(profileNotifier);
    return Container(
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      padding: EdgeInsets.symmetric(horizontal: 70.w, vertical: 10.h),
      decoration: BoxDecoration(
        gradient: AppColors.boxGradient,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 4.h,
              width: 100.w,
              decoration: BoxDecoration(
                color: AppColors.black,
                borderRadius: BorderRadius.circular(5.r),
              ),
            ),
            const YSpacing(30),
            Text(
              "Are you sure you want to delete your account?",
              style: AppTextStyles.semibold22,
              textAlign: TextAlign.center,
            ),
            const YSpacing(20),
            Column(
              children: [
                AppButton(
                    label: "YES",
                    isBusy: state2.isBusy,
                    onTap: () {
                      notifier2.deleteUser(state.data!.user.id!);
                    }),
                const YSpacing(10),
                AppButton(
                   buttonColor: Colors.white,
                    labelColor: AppColors.darkGrey,
                  label: "CANCEL",
                  onTap: notifier2.navigateBack,
                ),
              ],
            ),
            const YSpacing(40),
          ],
        ),
      ),
    );
  }
}
