import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:powerhouse/ui/constants/_constants.dart';
import 'package:powerhouse/ui/views/careers/notifiers/careers_notifier.dart';
import 'package:powerhouse/ui/views/careers/views/careers_view.dart';
import 'package:powerhouse/ui/views/fitness/notifiers/fitness_notifier.dart';
import 'package:powerhouse/ui/views/fitness/views/fitness_view.dart';
import 'package:powerhouse/ui/views/home/notifiers/home_notifier.dart';
import 'package:powerhouse/ui/views/home/views/home_view.dart';
import 'package:powerhouse/ui/views/journal/notifiers/journal_notifier.dart';
import 'package:powerhouse/ui/views/journal/views/journal_view.dart';
import 'package:powerhouse/ui/views/media_view/views/media_view.dart';

import '../notifiers/main_notifier.dart';

class MainView extends StatefulHookConsumerWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainViewState();
}

class _MainViewState extends ConsumerState<MainView> {
  @override
  void initState() {
    super.initState();
    ref.refresh(mainNotifier);
    ref.refresh(homeNotifier);
    ref.refresh(fitnessNotifier);
    ref.refresh(careersNotifier);
    ref.refresh(journalNotifier);
    ref.read(mainNotifier.notifier).init();
  }

  @override
  Widget build(BuildContext context) {
    final tabs = [
      const JournalView(),
      const MediaView(),
      const HomeView(),
      const FitnessView(),
      const CareersView()
    ];
    final state = ref.watch(mainNotifier);
    return DefaultTabController(
      initialIndex: 0,
      length: 5,
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
              child: IndexedStack(
                children: tabs,
                index: state.data!.currentTabIndex,
              ),
            ),
            Positioned(
              bottom: 0.h,
              left: 0.w,
              right: 0.w,
              height: 104.h,
              child: Container(
                height: double.maxFinite,
                decoration: BoxDecoration(
                  color: AppColors.pink,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30.r),
                  ),
                ),
                child: Row(
                  children: const [
                    BottomBarIcon(
                      icon: AppAssets.journalSvg,
                      index: 0,
                      size: 24,
                      label: "Journal",
                    ),
                    BottomBarIcon(
                      icon: AppAssets.mediaSvg,
                      index: 1,
                      size: 28,
                      label: "Media",
                    ),
                    BottomBarIcon(
                      icon: AppAssets.homeSvg,
                      index: 2,
                      size: 28,
                      label: "Home",
                    ),
                    BottomBarIcon(
                      icon: AppAssets.fitnessSvg,
                      index: 3,
                      size: 30,
                      label: "Fitness",
                    ),
                    BottomBarIcon(
                      icon: AppAssets.careersSvg,
                      index: 4,
                      size: 28,
                      label: "Career",
                    ),
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

class BottomBarIcon extends HookConsumerWidget {
  final String icon;
  final int index;
  final double size;
  final String label;
  const BottomBarIcon({
    Key? key,
    required this.icon,
    required this.index,
    this.size = 28,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(mainNotifier.notifier);
    final state = ref.watch(mainNotifier);
    return Expanded(
      child: InkWell(
        onTap: () => notifier.onTabChanged(index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: FittedBox(
                child: SvgPicture.asset(
                  icon,
                  width: size.sp,
                  height: size.sp,
                  color: state.data!.currentTabIndex == index
                      ? AppColors.darkPink
                      : AppColors.white,
                ),
              ),
            ),
            const YSpacing(5),
            Text(
              label,
              style: AppTextStyles.semibold22.copyWith(
                fontSize: 12.sm,
              ),
            )
          ],
        ),
      ),
    );
  }
}
