import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:powerhouse/ui/components/_components.dart';
import 'package:powerhouse/ui/constants/_constants.dart';
import 'package:powerhouse/ui/views/fitness/notifiers/fitness_notifier.dart';

class DayPlan extends HookConsumerWidget {
  const DayPlan({
    Key? key,
    required ScrollController scrollController,
  })  : _scrollController = scrollController,
        super(key: key);

  final ScrollController _scrollController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(fitnessNotifier);
    if (state.failure != null) {
      return const Center(
        child: Text("Error"),
      );
    }
    return Container(
      padding: EdgeInsets.all(15.r),
      decoration: BoxDecoration(
        color: AppColors.veryLightGrey,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Today's Plan",
                style: AppTextStyles.kTextStyle(
                  17,
                  height: 19,
                  weight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              AppButton(
                label: "View Full Plan",
                buttonColor: AppColors.black,
                borderRadius: 15,
                labelSize: 10,
                height: 30,
                width: 95,
                onTap: ref.read(fitnessNotifier.notifier).viewFullPlan,
              ),
            ],
          ),
          const YSpacing(10),
          GridView(
            shrinkWrap: true,
            controller: _scrollController,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              // mainAxisExtent: 86.r,
              childAspectRatio: 1,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            children: [
              PlanItem(
                isSelected: state.userProgress?.breakfast ?? false,
                title: "Breakfast",
                subtitle: state.dayPlan!.breakfast,
                onTap: (val) =>
                    ref.read(fitnessNotifier.notifier).onItemTap(0, val),
              ),
              PlanItem(
                isSelected: state.userProgress?.lunch ?? false,
                title: "Lunch",
                subtitle: state.dayPlan!.lunch,
                onTap: (val) =>
                    ref.read(fitnessNotifier.notifier).onItemTap(1, val),
              ),
              PlanItem(
                isSelected: state.userProgress?.dinner ?? false,
                title: "Dinner",
                subtitle: state.dayPlan!.dinner,
                onTap: (val) =>
                    ref.read(fitnessNotifier.notifier).onItemTap(2, val),
              ),
              PlanItem(
                isSelected: state.userProgress?.snacks ?? false,
                title: "Snack",
                subtitle: state.dayPlan!.snacks,
                onTap: (val) =>
                    ref.read(fitnessNotifier.notifier).onItemTap(3, val),
              ),
              PlanItem(
                isSelected: state.userProgress?.workout ?? false,
                title: "Exercise",
                subtitle: state.dayPlan!.workout,
                onTap: (val) =>
                    ref.read(fitnessNotifier.notifier).onItemTap(4, val),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PlanItem extends StatelessWidget {
  const PlanItem({
    Key? key,
    required this.isSelected,
    required this.title,
    required this.subtitle,
    required this.onTap,
  }) : super(key: key);

  final bool isSelected;
  final String title;
  final String subtitle;
  final void Function(bool) onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(!isSelected),
      child: Container(
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.darkPink : AppColors.white,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FittedBox(
              child: Text(
                title,
                textAlign: TextAlign.start,
                style: AppTextStyles.kTextStyle(
                  17,
                  weight: FontWeight.w500,
                  color: isSelected ? AppColors.white : AppColors.black,
                ),
              ),
            ),
            const YSpacing(3),
            Expanded(
              child: Text(
                subtitle,
                softWrap: true,
                overflow: TextOverflow.fade,
                textAlign: TextAlign.start,
                style: AppTextStyles.kTextStyle(
                  11,
                  weight: FontWeight.w500,
                  color: isSelected ? AppColors.white : AppColors.black,
                ),
              ),
            ),
            const YSpacing(5),
            Visibility(
              visible: isSelected,
              child: const Align(
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.check_circle_outline_outlined,
                  color: AppColors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
