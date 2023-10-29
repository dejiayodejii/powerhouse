import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:powerhouse/ui/components/_components.dart';
import 'package:powerhouse/ui/constants/_constants.dart';

import '../notifiers/journal_notifier.dart';

class JournalView extends StatefulHookConsumerWidget {
  const JournalView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _JournalViewState();
}

class _JournalViewState extends ConsumerState<JournalView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(journalNotifier.notifier).init();
    });
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.watch(journalNotifier.notifier);
    final state = ref.watch(journalNotifier);
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
              child: Builder(
                builder: (context) {
                  if (state.isBusy && state.data!.journals.isEmpty) {
                    return const Center(
                      child: AppLoader(padding: 20),
                    );
                  }
                  final journals = state.data!.journals;
                  if (journals.isEmpty) {
                    return Center(
                      child: Text(
                        "No journal entries yet",
                        style: AppTextStyles.kTextStyle(
                          15,
                          height: 17.58,
                          weight: FontWeight.w500,
                          color: AppColors.black,
                        ),
                      ),
                    );
                  }
                  return RefreshIndicator(
                    onRefresh: () => notifier.fetchJournals(),
                    child: GridView.builder(
                      itemCount: journals.length,
                      padding: EdgeInsets.only(bottom: 20.h, top: 30.h),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1,
                        crossAxisSpacing: 20.sp,
                        mainAxisSpacing: 20.sp,
                        // mainAxisExtent: 146.h,
                      ),
                      itemBuilder: (context, index) {
                        final journal = journals[index];
                        return JournalCard(
                          title: journal.title,
                          body: journal.body,
                          bottomLText: journal.parsedDate,
                          bottomRText: journal.parsedTime,
                          cardColor: AppColors.veryLightGrey,
                          textColor: AppColors.black,
                          onTap: () =>
                              notifier.navigateToJournalDetail(journal),
                        );
                      },
                    ),
                  );
                },
              ),
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
                              "Journal",
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
                        const OptionWidget(
                          name: "Recently Added",
                          spacing: 5,
                          textColor: AppColors.white,
                          color: AppColors.darkPink,
                          icon: AppAssets.recentlyAddedImage,
                        ),
                        const XSpacing(10),
                        OptionWidget(
                          name: "Create New",
                          spacing: 5,
                          textColor: AppColors.black,
                          color: AppColors.white,
                          icon: AppAssets.createJournal,
                          onTap: notifier.createJournal,
                        ),
                      ],
                    ),
                    const Spacer(),
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
