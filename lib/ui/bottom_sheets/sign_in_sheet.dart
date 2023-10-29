import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:powerhouse/core/mixins/validator_mixin.dart';
import 'package:powerhouse/ui/components/_components.dart';
import 'package:powerhouse/ui/constants/_constants.dart';
import 'package:powerhouse/ui/views/onboarding/notifiers/onboarding_notifier.dart';

class SignInSheet extends HookConsumerWidget with ValidatorMixin {
  const SignInSheet({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(onboardingNotifier.notifier);
    final state = ref.watch(onboardingNotifier);

    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    return Container(
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      padding: EdgeInsets.symmetric(horizontal: 70.w, vertical: 10.h),
      decoration: BoxDecoration(
        gradient: AppColors.boxGradient,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Form(
        key: notifier.formKey,
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
              "Welcome Back Queen",
              style: AppTextStyles.semibold22,
              textAlign: TextAlign.center,
            ),
            const YSpacing(20),
            AppTextField(
              hint: "Enter Email",
              controller: emailController,
              maxLines: 1,
              validator: validateEmail,
              keyboardType: TextInputType.emailAddress,
            ),
            const YSpacing(10),
            AppTextField(
              hint: "Enter Password",
              controller: passwordController,
              obscureText:
                  state.whenOrNull(data: (_) => !_.showPasword) ?? false,
              maxLines: 1,
              validator: validatePassword,
              onChanged: notifier.onFieldChanged,
              suffix:
                  (state.whenOrNull(data: (data) => data.showVisibilityIcon) ??
                          false)
                      ? InkWell(
                          onTap: notifier.togglePasswordVisibility,
                          child: Icon(
                            state.value!.showPasword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: AppColors.black,
                          ),
                        )
                      : null,
            ),
            const YSpacing(10),
            InkWell(
              onTap: notifier.openResetPasswordSheet,
              child: Text(
                "Forgot Password?",
                style: AppTextStyles.kTextStyle(
                  16,
                  height: 18,
                  color: AppColors.white,
                  weight: FontWeight.w300,
                ),
              ),
            ),
            const YSpacing(10),
            Row(
              children: [
                Flexible(
                  child: AppButton(
                    label: "CANCEL",
                    labelColor: AppColors.black,
                    buttonColor: AppColors.white,
                    onTap: notifier.navigateBack,
                  ),
                ),
                const XSpacing(10),
                Flexible(
                  child: AppButton(
                    label: "LOGIN",
                    onTap: () => notifier.login(
                      emailController.text,
                      passwordController.text,
                    ),
                    isBusy: state is AsyncLoading,
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
