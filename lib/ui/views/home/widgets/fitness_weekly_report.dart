import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:powerhouse/ui/components/_components.dart';
import 'package:powerhouse/ui/constants/_constants.dart';
import 'package:powerhouse/ui/views/home/notifiers/home_notifier.dart';

class FitnessWeeklyReport extends HookConsumerWidget {
  const FitnessWeeklyReport({Key? key}) : super(key: key);
  static const days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeNotifier);
    if (state.isBusy) {
      return const Center(
        child: AppLoader(padding: 20),
      );
    }
    if (state.hasError) return const SizedBox();
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: REdgeInsets.all(13),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        color: AppColors.veryLightGrey,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Fitness Progress",
            style: AppTextStyles.light20.copyWith(
              fontSize: 20.sm,
            ),
          ),
          const YSpacing(10),
          Row(
            children: [
              for (int i = 0; i < state.weekProgress.length - 1; i++)
                Builder(
                  builder: (context) {
                    final e = state.weekProgress[i];
                    final isReached = e != null;
                    final isDone = e?.doneRatio == 1;
                    return Expanded(
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 17.r,
                            backgroundColor: !isReached
                                ? AppColors.lightGrey
                                : isDone
                                    ? AppColors.green
                                    : AppColors.pink,
                            child: Visibility(
                              visible: isReached,
                              child: Center(
                                child: Icon(
                                  isDone ? Icons.done : Icons.close,
                                  color: AppColors.black,
                                  size: 14.sp,
                                ),
                              ),
                            ),
                          ),
                          const YSpacing(10),
                          Text(
                            days[i],
                            style: AppTextStyles.light12.copyWith(
                              color: AppColors.lightGrey,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }
}
