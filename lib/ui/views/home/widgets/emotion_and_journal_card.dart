import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:powerhouse/ui/components/_components.dart';
import 'package:powerhouse/ui/constants/_constants.dart';
import 'package:powerhouse/ui/views/home/notifiers/home_notifier.dart';

class EmotionAndJournalCard extends ConsumerWidget {
  const EmotionAndJournalCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeNotifier);
    return Expanded(
      child: Container(
        clipBehavior: Clip.hardEdge,
        padding: EdgeInsets.all(15.sp),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          color: AppColors.veryLightGrey,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Visibility(
              visible: state.showEmotions,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "How do you feel today?",
                    style: AppTextStyles.light20.copyWith(
                      fontSize: 20.sm,
                    ),
                  ),
                  const YSpacing(10),
                  Wrap(
                    spacing: 10.w,
                    runSpacing: 10,
                    children: HomeNotifier.emotions.map((e) {
                      return OptionWidget(
                        icon: e.icon,
                        name: e.name.toUpperCase(),
                        textColor: AppColors.black,
                        iconColor: AppColors.black,
                        color: AppColors.pink,
                        spacing: 5,
                        onTap: () =>
                            ref.read(homeNotifier.notifier).onEmotionTap(e),
                      );
                    }).toList(),
                  ),
                  const YSpacing(13),
                ],
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: ref.read(homeNotifier.notifier).createJournal,
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  padding: EdgeInsets.all(17.sp),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    color: AppColors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Journal your thoughts",
                            style: AppTextStyles.light20.copyWith(
                              fontSize: 18.sm,
                              color: AppColors.lightGrey,
                            ),
                          ),
                          SvgPicture.asset(AppAssets.writeNoteSvg),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
