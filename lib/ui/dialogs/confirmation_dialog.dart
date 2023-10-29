import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:powerhouse/ui/components/_components.dart';
import 'package:powerhouse/ui/constants/_constants.dart';

class ConfirmationDialog extends StatelessWidget {
  final String icon;
  final String body;
  final String? buttonText;
  final bool canPop;
  final VoidCallback? onPressed;
  const ConfirmationDialog({
    Key? key,
    required this.body,
    this.icon = AppAssets.doneCircleSvg,
    this.buttonText,
    this.canPop = true,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(canPop),
      child: Dialog(
        clipBehavior: Clip.hardEdge,
        backgroundColor: AppColors.pink,
        insetPadding: EdgeInsets.all(20.sp),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const YSpacing(75),
              SvgPicture.asset(icon),
              const YSpacing(27),
              Text(
                body,
                style: AppTextStyles.light20.copyWith(fontSize: 23.sm),
              ),
              const YSpacing(24),
              AppButton(
                label: buttonText ?? "Close",
                onTap: onPressed ?? () => Navigator.pop(context),
              ),
              const YSpacing(44),
            ],
          ),
        ),
      ),
    );
  }
}
