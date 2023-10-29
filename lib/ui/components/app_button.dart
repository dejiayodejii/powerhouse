import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:powerhouse/ui/components/_components.dart';
import 'package:powerhouse/ui/constants/_constants.dart';

class AppButton extends StatelessWidget {
  final void Function()? onTap;
  final double? width, height, borderRadius;
  final double? horizPad, vertPad, labelSize;
  final Color? buttonColor;
  final String label;
  final Color? labelColor, loaderColor, borderColor;
  final bool hasShadow, hasBorder, isBusy, hasGradient, isEnabled;
  final FontWeight fontWeight;
  final Widget? icon;
  const AppButton({
    Key? key,
    this.onTap,
    this.width,
    this.height,
    this.icon,
    this.buttonColor = AppColors.darkGrey,
    required this.label,
    this.labelSize,
    this.labelColor = AppColors.white,
    this.loaderColor = AppColors.white,
    this.borderColor,
    this.hasShadow = false,
    this.hasBorder = false,
    this.isBusy = false,
    this.hasGradient = false,
    this.isEnabled = true,
    this.fontWeight = FontWeight.w600,
    this.borderRadius,
    this.horizPad,
    this.vertPad,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width?.w ?? 200.w,
      height: height?.h ?? 46.h,
      // width: width?.w ?? 200.w,
      // height: height?.h ?? 46.h,
      child: MaterialButton(
        onPressed: !isEnabled || onTap == null
            ? null
            : () {
                if (!isBusy) onTap!.call();
              },
        color: buttonColor,
        elevation: hasShadow ? 5 : 0,
        padding: EdgeInsets.zero,
        disabledColor: buttonColor?.withOpacity(0.5),
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius?.r ?? 15.r),
          side: hasBorder
              ? BorderSide(
                  color: borderColor ?? Colors.grey[400]!,
                  width: 2.r,
                )
              : BorderSide.none,
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: hasGradient
                ? LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: const [0.2, 0.8],
                    tileMode: TileMode.decal,
                    colors: [
                      AppColors.white.withOpacity(0.15),
                      AppColors.black.withOpacity(0.15),
                    ],
                  )
                : null,
          ),
          child: FittedBox(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizPad?.w ?? 0,
                vertical: vertPad?.h ?? 0,
              ),
              child: Visibility(
                visible: !isBusy,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (icon != null)
                      Container(
                        padding: const EdgeInsets.only(right: 5),
                        child: icon,
                      ),
                    if (icon != null) const XSpacing(15),
                    Text(
                      label,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.kTextStyle(
                        labelSize ?? 20,
                        // height: 23.44,
                        weight: FontWeight.w500,
                        color: labelColor,
                      ),
                    ),
                  ],
                ),
                replacement: AppLoader(
                  color: loaderColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
