import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:powerhouse/ui/components/_components.dart';
import 'package:powerhouse/ui/constants/_constants.dart';

import '../notifiers/fitness_notifier.dart';

class FitnessView extends StatefulHookConsumerWidget {
  const FitnessView({Key? key}) : super(key: key);

  @override
  ConsumerState<FitnessView> createState() => _FitnessViewState();
}

class _FitnessViewState extends ConsumerState<FitnessView> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    ref.read(fitnessNotifier.notifier).initialize();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(fitnessNotifier);
    return SafeArea(
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
              top: 150.h,
              left: 20.w,
              right: 20.w,
              bottom: 90.h,
              child: Builder(builder: (context) {
                if (state.isLoading && state.anyisNull) {
                  return const Center(
                    child: AppLoader(),
                  );
                }
                return RefreshIndicator(
                  onRefresh: () async {
                    await ref.read(fitnessNotifier.notifier).initialize();
                  },
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    padding: EdgeInsets.only(top: 20.h),
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        Container(
                          height: 200.h,
                          padding: EdgeInsets.all(15.r),
                          decoration: BoxDecoration(
                            color: AppColors.veryLightGrey,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Progress Sheet",
                                    style: AppTextStyles.kTextStyle(
                                      17,
                                      height: 19,
                                      weight: FontWeight.w500,
                                    ),
                                  ),
                                  const Spacer(),
                                  // Icon(
                                  //   Icons.circle,
                                  //   size: 15.sp,
                                  //   color: AppColors.darkPink,
                                  // ),
                                  // const XSpacing(2),
                                  // Text(
                                  //   "Workout",
                                  //   style: AppTextStyles.kTextStyle(
                                  //     10,
                                  //     height: 11,
                                  //     weight: FontWeight.normal,
                                  //   ),
                                  // ),
                                  const XSpacing(8),
                                  Icon(
                                    Icons.circle,
                                    size: 15.sp,
                                    color: AppColors.black,
                                  ),
                                  const XSpacing(2),
                                  Text(
                                    "Progress",
                                    style: AppTextStyles.kTextStyle(
                                      10,
                                      height: 11,
                                      weight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                              const YSpacing(35),
                              const Expanded(
                                child: ProgressGraph(),
                              ),
                            ],
                          ),
                        ),
                        const YSpacing(16),
                        DayPlan(scrollController: _scrollController),
                      ],
                    ),
                  ),
                );
              }),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 150.h,
                padding: EdgeInsets.fromLTRB(20.sp, 10.h, 20.sp, 10.h),
                decoration: BoxDecoration(
                  color: AppColors.pink,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(20.r),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const YSpacing(30),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 7.w),
                          child: FittedBox(
                            child: Text(
                              "Fitness",
                              style: AppTextStyles.kTextStyle(
                                27,
                                height: 39.84,
                                weight: FontWeight.bold,
                                color: AppColors.black,
                              ),
                            ),
                          ),
                        ),
                        const SettingsButton(),
                      ],
                    ),
                    const YSpacing(10),
                    Row(
                      children: [
                        Flexible(
                          child: OptionWidget(
                            name: "Overview",
                            spacing: 5,
                            icon: AppAssets.fitnessOverviewSvg,
                            textColor: AppColors.white,
                            iconColor: AppColors.white,
                            color: AppColors.darkPink,
                            onTap: ref
                                .read(fitnessNotifier.notifier)
                                .onScheduleTap,
                          ),
                        ),
                        const XSpacing(10),
                        // Flexible(
                        //   child: OptionWidget(
                        //     name: "Join Challenge",
                        //     spacing: 5,
                        //     icon: AppAssets.joinChallengeSvg,
                        //     textColor: AppColors.black,
                        //     iconColor: AppColors.black,
                        //     color: AppColors.white,
                        //     onTap: ref
                        //         .read(fitnessNotifier.notifier)
                        //         .onEmergencyTap,
                        //   ),
                        // ),
                      ],
                    ),
                    const Spacer(flex: 2),
                    const YSpacing(5),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
