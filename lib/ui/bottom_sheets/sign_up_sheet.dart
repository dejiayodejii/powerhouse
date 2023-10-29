import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:powerhouse/core/mixins/validator_mixin.dart';
import 'package:powerhouse/core/models/_models.dart';
import 'package:powerhouse/ui/components/_components.dart';
import 'package:powerhouse/ui/constants/_constants.dart';
import 'package:powerhouse/ui/views/onboarding/notifiers/onboarding_notifier.dart';

class SignUpSheet extends HookConsumerWidget with ValidatorMixin {
  const SignUpSheet({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(onboardingNotifier.notifier);
    final state = ref.watch(onboardingNotifier);
    final firstNameController = useTextEditingController();
    final lastNameController = useTextEditingController();
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
                "Join the PowerHouse",
                style: AppTextStyles.semibold22,
                textAlign: TextAlign.center,
              ),
              const YSpacing(20),
              AppTextField(
                hint: "Enter First Name",
                controller: firstNameController,
                textCapitalization: TextCapitalization.words,
                maxLines: 1,
                validator: validateNotEmpty,
                keyboardType: TextInputType.name,
              ),
              const YSpacing(10),
              AppTextField(
                hint: "Enter Last Name",
                controller: lastNameController,
                maxLines: 1,
                textCapitalization: TextCapitalization.words,
                validator: validateNotEmpty,
                keyboardType: TextInputType.name,
              ),
              const YSpacing(10),
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
                    state.whenOrNull(data: (_) => !_.showPasword) ?? true,
                maxLines: 1,
                onChanged: notifier.onFieldChanged,
                validator: validatePassword,
                suffix:
                    state.whenOrNull(data: (_) => _.showVisibilityIcon) ?? false
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
              AppTextField(
                hint: "Confirm Password",
                obscureText:
                    state.whenOrNull(data: (_) => !_.showPasword) ?? true,
                onChanged: notifier.onFieldChanged,
                maxLines: 1,
                validator: (val) =>
                    validateConfirmPassword(val, passwordController.text),
                suffix:
                    state.whenOrNull(data: (_) => _.showVisibilityIcon) ?? false
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
              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      label: "CANCEL",
                      labelColor: AppColors.black,
                      buttonColor: AppColors.white,
                      onTap: notifier.navigateBack,
                    ),
                  ),
                  const XSpacing(10),
                  Expanded(
                    child: AppButton(
                      label: "SIGN UP",
                      isBusy: state is AsyncLoading,
                      onTap: () => notifier.signUp(
                        UserModel(
                          firstName: firstNameController.text.trim(),
                          lastName: lastNameController.text.trim(),
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const YSpacing(40),
            ],
          ),
        ),
      ),
    );
  }
}
