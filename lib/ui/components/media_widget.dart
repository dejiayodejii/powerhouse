import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:powerhouse/ui/components/_components.dart';
import 'package:powerhouse/ui/constants/_constants.dart';

class MediaWidget extends StatelessWidget {
  final String title;
  final String body;
  final String image;
  final VoidCallback onTap;
  final bool showIndicator;
  final int currentIndex;
  const MediaWidget({
    Key? key,
    required this.title,
    required this.body,
    required this.image,
    required this.onTap,
    this.showIndicator = true,
    this.currentIndex = -1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 110.sp,
        decoration: BoxDecoration(
          color: AppColors.veryLightGrey,
          borderRadius: BorderRadius.circular(15.r),
        ),
        padding: REdgeInsets.fromLTRB(14, 10, 14, 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: FittedBox(
                child: SizedBox.square(
                  dimension: 100.r,
                  child: Container(
                    height: double.maxFinite,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: AppColors.black,
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: Image.network(image, fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
            const XSpacing(12),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Visibility(
                    visible: showIndicator,
                    child: Align(
                      alignment: Alignment.topRight,
                      child: CarouselIndicator(
                        length: 3,
                        spacing: 3,
                        currentIndex: currentIndex,
                        activeWidget: Container(
                          width: 17.w,
                          height: 6.h,
                          decoration: BoxDecoration(
                            color: AppColors.pink,
                            borderRadius: BorderRadius.circular(40.r),
                          ),
                        ),
                        inactiveWidget: Container(
                          width: 7.w,
                          height: 6.h,
                          decoration: BoxDecoration(
                            color: AppColors.pink,
                            borderRadius: BorderRadius.circular(40.r),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  const YSpacing(5),
                  Text(
                    title,
                    maxLines: 2,
                    style: AppTextStyles.whiteBold16.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                  const YSpacing(5),
                  Flexible(
                    flex: 6,
                    child: Text(
                      body,
                      style: AppTextStyles.whiteLight15.copyWith(
                        color: AppColors.black,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const YSpacing(5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
