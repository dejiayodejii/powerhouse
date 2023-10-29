import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:powerhouse/core/mixins/validator_mixin.dart';
import 'package:powerhouse/ui/components/_components.dart';
import 'package:powerhouse/ui/constants/_constants.dart';
import 'package:powerhouse/ui/views/onboarding/notifiers/password_reset_notifier.dart';
import 'package:powerhouse/ui/views/onboarding/states/password_reset_state.dart';

class ResetPasswordSheet extends HookConsumerWidget with ValidatorMixin {
  const ResetPasswordSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(passwordResetNotifier);
    final emailController = useTextEditingController();

    return Container(
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      padding: EdgeInsets.symmetric(horizontal: 70.w, vertical: 10.h),
      decoration: BoxDecoration(
        gradient: AppColors.boxGradient,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Form(
        key: ref.read(passwordResetNotifier.notifier).formKey,
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
            const YSpacing(40),
            Text(
              "Reset Password",
              style: AppTextStyles.semibold22,
              textAlign: TextAlign.center,
            ),
            const YSpacing(20),
            AppTextField(
              hint: "Enter Email",
              controller: emailController,
              validator: validateEmail,
              keyboardType: TextInputType.emailAddress,
            ),
            const YSpacing(10),
            Row(
              children: [
                Flexible(
                  child: AppButton(
                    label: "CANCEL",
                    labelColor: AppColors.black,
                    buttonColor: AppColors.white,
                    onTap:
                        ref.read(passwordResetNotifier.notifier).navigateBack,
                  ),
                ),
                const XSpacing(10),
                Flexible(
                  child: AppButton(
                    label: "PROCEED",
                    isBusy: state is PasswordResetLoadingState,
                    onTap: () => ref
                        .read(passwordResetNotifier.notifier)
                        .sendResetCode(emailController.text),
                  ),
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
