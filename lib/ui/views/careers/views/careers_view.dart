import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:powerhouse/ui/components/_components.dart';
import 'package:powerhouse/ui/constants/_constants.dart';

import '../notifiers/careers_notifier.dart';

class CareersView extends StatefulHookConsumerWidget {
  const CareersView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CareersViewState();
}

class _CareersViewState extends ConsumerState<CareersView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(careersNotifier.notifier).init();
    });
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.watch(careersNotifier.notifier);
    final state = ref.watch(careersNotifier);

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
                  if (state.isBusy && state.data!.careers.isEmpty) {
                    return const Center(
                      child: AppLoader(),
                    );
                  }
                  final careers = state.data!.careers;
                  if (careers.isEmpty) {
                    return Center(
                      child: Text(
                        "No Careers for now",
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
                    onRefresh: () => notifier.fetchCareers(),
                    child: GridView.builder(
                      itemCount: careers.length,
                      padding: EdgeInsets.only(bottom: 20.h, top: 30.h),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1,
                        crossAxisSpacing: 20.sp,
                        mainAxisSpacing: 20.sp,
                        // mainAxisExtent: 146.h,
                      ),
                      itemBuilder: (context, index) {
                        final career = careers[index];
                        return JournalCard(
                          title: career.name,
                          body: career.desc,
                          bottomLText: "${career.count} Videos",
                          cardColor: AppColors.darkGrey,
                          textColor: AppColors.white,
                          onTap: () => notifier.navigateToCareerDetail(career),
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
                              "Careers",
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
                      children: const [
                        OptionWidget(
                          name: "Mentorship",
                          icon: AppAssets.mentorshipSvg,
                          spacing: 5,
                          textColor: AppColors.white,
                          iconColor: AppColors.white,
                          color: AppColors.darkPink,
                        ),
                        // OptionWidget(
                        //   name: "Job Openings",
                        //   icon: AppAssets.jobOpeningsSvg,
                        //   spacing: 5,
                        //   textColor: AppColors.black,
                        //   gradient: AppColors.boxGradient,
                        // ),
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
