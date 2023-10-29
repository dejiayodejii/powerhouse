import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:powerhouse/ui/constants/_constants.dart';

class OptionWidget extends StatelessWidget {
  final String name;
  final String? icon;
  final Color? color;
  final Color textColor;
  final Color? iconColor;
  final double? spacing;
  final LinearGradient? gradient;
  final VoidCallback? onTap;

  const OptionWidget({
    Key? key,
    required this.name,
    this.icon,
    this.color,
    required this.textColor,
    this.iconColor,
    this.spacing,
    this.gradient,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 32.h,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: gradient,
          ),
          padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 15.sp),
          child: FittedBox(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    name,
                    style: AppTextStyles.bold14.copyWith(color: textColor),
                    maxLines: 1,
                  ),
                ),
                spacing == null ? const Spacer() : XSpacing(spacing!),
                if (icon != null)
                  icon!.endsWith(".svg")
                      ? SvgPicture.asset(
                          icon!,
                          color: iconColor,
                          width: 14.sp,
                        )
                      : Image.asset(
                          icon!,
                          color: iconColor,
                          width: 14.sp,
                        ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
