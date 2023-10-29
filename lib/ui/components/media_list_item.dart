import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:powerhouse/ui/constants/_constants.dart';

class MediaListItem extends StatelessWidget {
  final String title;
  final String body;
  final String image;
  final String subText;
  final VoidCallback onTap;
  final bool showIndicator;
  final int currentIndex;
  const MediaListItem({
    Key? key,
    required this.title,
    required this.body,
    required this.image,
    required this.subText,
    required this.onTap,
    this.showIndicator = true,
    this.currentIndex = -1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 130,
        padding: EdgeInsets.fromLTRB(0, 14.h, 0, 12.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FittedBox(
              child: SizedBox.square(
                dimension: 90.h,
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: AppColors.black,
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: Image.network(image, fit: BoxFit.cover),
                ),
              ),
            ),
            const XSpacing(14),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const YSpacing(2),
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.whiteBold16.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                  const YSpacing(5),
                  Expanded(
                    child: Text(
                      body,
                      softWrap: true,
                      overflow: TextOverflow.fade,
                      maxLines: 3,
                      style: AppTextStyles.kTextStyle(
                        12,
                        weight: FontWeight.w300,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                  const YSpacing(4),
                  Text(
                    subText,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.kTextStyle(
                      11,
                      weight: FontWeight.w300,
                      color: AppColors.darkPink,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
