import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:powerhouse/core/utils/utils.dart';
import 'package:powerhouse/ui/components/_components.dart';
import 'package:powerhouse/ui/constants/_constants.dart';
import 'package:powerhouse/ui/views/home/widgets/emotion_and_journal_card.dart';
import 'package:powerhouse/ui/views/home/widgets/fitness_weekly_report.dart';
import 'package:powerhouse/ui/views/home/widgets/motivations.dart';

import '../notifiers/home_notifier.dart';

class HomeView extends StatefulHookConsumerWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(homeNotifier.notifier).init();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homeNotifier);
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: ref.read(homeNotifier.notifier).getWeeklyProgress,
        child: ScrollColumnExpandable(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.all(20.sp),
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const YSpacing(20),
            const SettingsButton(),
            Text.rich(
              TextSpan(
                text: "Hi ${state.user.firstName}, ",
                style: AppTextStyles.kTextStyle(
                  34,
                  height: 39.84,
                  weight: FontWeight.bold,
                  color: AppColors.black,
                ),
                children: [
                  TextSpan(
                    text: Utils.getGreeting(),
                    style: AppTextStyles.kTextStyle(
                      22,
                      height: 25.79,
                      weight: FontWeight.w300,
                      color: AppColors.darkPink,
                    ),
                  ),
                ],
              ),
            ),
            const YSpacing(20),
            const QuoteOfTheDay(),
            const YSpacing(20),
            const Motivations(),
            const FitnessWeeklyReport(),
            const YSpacing(16),
            const EmotionAndJournalCard(),
            const YSpacing(100),
          ],
        ),
      ),
    );
  }
}

class QuoteOfTheDay extends HookConsumerWidget {
  const QuoteOfTheDay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeNotifier);
    if (state.isBusy) {
      return const Center(
        child: AppLoader(padding: 20),
      );
    }
    if (state.quoteOfTheDay == null) return const SizedBox();

    return Card(
      elevation: 0,
      color: AppColors.darkGrey,
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.pink.withOpacity(0.05),
              AppColors.pink.withOpacity(0.5),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.1, 1],
          ),
        ),
        padding: EdgeInsets.all(25.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "QUOTE OF THE DAY",
                  style: AppTextStyles.whiteBold16,
                ),
                const Spacer(),
                SvgPicture.asset(AppAssets.pinkQuoteSvg, height: 15.sp),
              ],
            ),
            const YSpacing(12),
            Text.rich(
              TextSpan(
                text: state.quoteOfTheDay!.quote + " - ",
                style: AppTextStyles.whiteLight15,
                children: [
                  TextSpan(
                    text: state.quoteOfTheDay!.author,
                    style: AppTextStyles.whiteLight15.copyWith(
                      fontWeight: FontWeight.bold,
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
