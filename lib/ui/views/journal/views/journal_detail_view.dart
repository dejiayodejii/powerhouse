import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:powerhouse/core/models/_models.dart';
import 'package:powerhouse/ui/components/_components.dart';
import 'package:powerhouse/ui/constants/_constants.dart';
import 'package:powerhouse/ui/views/journal/notifiers/journal_notifier.dart';

class JournalDetailView extends HookConsumerWidget {
  final JournalModel journal;
  const JournalDetailView({
    Key? key,
    required this.journal,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(journalNotifier.notifier);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(20.sp),
          child: Column(
            children: [
              const AppBackButton(),
              const YSpacing(20),
              Container(
                height: 140.h,
                clipBehavior: Clip.hardEdge,
                padding: EdgeInsets.fromLTRB(18.w, 20.h, 18.w, 25.h),
                decoration: BoxDecoration(
                  color: AppColors.blue,
                  borderRadius: BorderRadius.circular(15.sp),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: PopupMenuButton<String>(
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                        onSelected: (val) =>
                            notifier.onJournalMenuSelected(val, journal),
                        child: Padding(
                          padding: EdgeInsets.all(5.r),
                          child: CarouselIndicator(
                            length: 3,
                            currentIndex: -1,
                            spacing: 6.w,
                            activeWidget: Container(
                              decoration: BoxDecoration(
                                // borderRadius: BorderRadius.circular(borderRadius ?? 0),
                                color: AppColors.lightGrey,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.black,
                                ),
                              ),
                              height: 5.w,
                              width: 5.w,
                            ),
                          ),
                        ),
                        itemBuilder: (context) {
                          return ["Edit", "Delete"].map((e) {
                            return PopupMenuItem(
                              child: Text(e, style: AppTextStyles.regularBody),
                              value: e.toLowerCase(),
                            );
                          }).toList();
                        },
                      ),
                    ),
                    const YSpacing(3),
                    Expanded(
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          journal.title,
                          style: AppTextStyles.kTextStyle(
                            18,
                            height: 21.09,
                            color: AppColors.white,
                            weight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "-" * 2000,
                      style: AppTextStyles.kTextStyle(
                        15,
                        height: 17.58,
                        weight: FontWeight.w500,
                        color: AppColors.white,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                    ),
                    const YSpacing(3),
                    Text(
                      journal.parsedDate,
                      style: AppTextStyles.kTextStyle(
                        15,
                        height: 17.58,
                        weight: FontWeight.w500,
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const YSpacing(15),
              Expanded(
                child: Container(
                  width: double.maxFinite,
                  padding:
                      EdgeInsets.symmetric(horizontal: 14.w, vertical: 20.h),
                  decoration: BoxDecoration(
                    color: AppColors.veryLightGrey,
                    borderRadius: BorderRadius.circular(15.sp),
                  ),
                  child: ScrollbarTheme(
                    data: ScrollbarThemeData(
                      trackVisibility: MaterialStateProperty.all(true),
                      thickness: MaterialStateProperty.all(12),
                    ),
                    child: Scrollbar(
                      thumbVisibility: true,
                      thickness: 5.sp,
                      radius: const Radius.circular(20),
                      trackVisibility: true,
                      scrollbarOrientation: ScrollbarOrientation.right,
                      child: SingleChildScrollView(
                        padding: EdgeInsets.only(right: 15.w),
                        child: Text(
                          journal.body,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
