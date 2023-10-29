import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:powerhouse/ui/constants/_constants.dart';
import 'package:powerhouse/ui/views/media_view/notifiers/media_detail_notifier.dart';

class ArticleView extends HookConsumerWidget {
  const ArticleView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ScrollController();
    final notifier = ref.watch(mediaDetailNotifier.notifier);
    final state = ref.watch(mediaDetailNotifier);
    final _medium = state.data!.medium;

    return Column(
      children: [
        Container(
          height: 179.h,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.sp),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned.fill(
                child: Image.network(
                  _medium!.coverImage,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 15.h,
                left: 14.w,
                child: Row(
                  children: [
                    InkWell(
                      onTap: () => notifier.onLikeClick(_medium),
                      child: CircleAvatar(
                        radius: 16.sp,
                        backgroundColor: AppColors.pink,
                        child: Icon(
                          _medium.isLiked
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: AppColors.black,
                        ),
                      ),
                    ),
                    const XSpacing(11),
                    InkWell(
                      onTap: notifier.onShareClick,
                      child: CircleAvatar(
                        radius: 16.sp,
                        backgroundColor: AppColors.pink,
                        child: const Icon(
                          Icons.share,
                          color: AppColors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const YSpacing(15),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 20.h),
            decoration: BoxDecoration(
              color: AppColors.veryLightGrey,
              borderRadius: BorderRadius.circular(15.sp),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _medium.title,
                  textAlign: TextAlign.start,
                  style: AppTextStyles.bold14.copyWith(fontSize: 18.sm),
                ),
                const YSpacing(11),
                Expanded(
                  child: ScrollbarTheme(
                    data: ScrollbarThemeData(
                      trackVisibility: MaterialStateProperty.all(true),
                      thickness: MaterialStateProperty.all(12),
                    ),
                    child: Scrollbar(
                      controller: controller,
                      thumbVisibility: true,
                      thickness: 5.sp,
                      radius: const Radius.circular(20),
                      trackVisibility: true,
                      scrollbarOrientation: ScrollbarOrientation.right,
                      child: SingleChildScrollView(
                        controller: controller,
                        padding: EdgeInsets.only(right: 15.w),
                        child: Text(
                          _medium.body,
                          style: AppTextStyles.light20.copyWith(
                            fontSize: 15.sm,
                            height: 1.5,
                            color: AppColors.darkGrey,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
