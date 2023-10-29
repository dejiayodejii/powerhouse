import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:powerhouse/ui/constants/_constants.dart';

class JournalCard extends StatelessWidget {
  final String title;
  final String body;
  final String bottomLText;
  final String? bottomRText;
  final Color cardColor;
  final Color textColor;
  final VoidCallback onTap;
  const JournalCard({
    Key? key,
    required this.title,
    required this.body,
    required this.bottomLText,
    this.bottomRText,
    required this.cardColor,
    required this.textColor,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.fromLTRB(18.w, 25.h, 18.w, 15.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          color: cardColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                title,
                overflow: TextOverflow.fade,
                textAlign: TextAlign.left,
                maxLines: 2,
                style: AppTextStyles.kTextStyle(
                  17,
                  height: 19,
                  color: textColor,
                  weight: FontWeight.w500,
                ),
              ),
            ),
            const YSpacing(7),
            Expanded(
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  body,
                  overflow: TextOverflow.fade,
                  style: AppTextStyles.kTextStyle(
                    12,
                    height: 14,
                    color: textColor,
                    weight: FontWeight.w300,
                  ),
                ),
              ),
            ),
            const YSpacing(7),
            Row(
              children: [
                Flexible(
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        AppAssets.iconsCalenderSvg,
                        height: 12.sp,
                        color: textColor,
                      ),
                      const XSpacing(5),
                      Flexible(
                        child: FittedBox(
                          child: Text(
                            bottomLText,
                            style: AppTextStyles.kTextStyle(
                              11,
                              height: 13,
                              weight: FontWeight.w500,
                              color: textColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const XSpacing(10),
                if (bottomRText != null)
                  Row(
                    children: [
                      SvgPicture.asset(
                        AppAssets.timeFiveSvg,
                        height: 12.sp,
                        color: textColor,
                      ),
                      const XSpacing(5),
                      FittedBox(
                        child: Text(
                          bottomRText!,
                          style: AppTextStyles.kTextStyle(
                            11,
                            height: 13,
                            weight: FontWeight.w500,
                            color: textColor,
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
