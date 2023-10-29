import 'dart:async';

import 'package:flutter/material.dart' hide State;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:powerhouse/core/mixins/_mixins.dart';
import 'package:powerhouse/ui/components/_components.dart';
import 'package:powerhouse/ui/constants/_constants.dart';
import 'package:powerhouse/ui/views/onboarding/notifiers/onboarding_notifier.dart';

class OnboardingView extends StatefulHookConsumerWidget {
  const OnboardingView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends ConsumerState<OnboardingView>
    with ToastMixin {
  static const onboardingTexts = [
    "Where Women Thrive",
    "Improve Your Business/Career",
    "Journal Your Thoughts",
    "Articles to Inspire You",
  ];
  PageController? pageController;

  @override
  void initState() {
    ref.refresh(onboardingNotifier);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      scrollPageAutomatically();
    });
    super.initState();
  }

  void scrollPageAutomatically() {
    Timer.periodic(const Duration(seconds: 3), (time) {
      if (pageController == null) return;

      if (pageController!.hasClients) {
        if (pageController!.page == 3) {
          pageController!.animateToPage(0,
              duration: const Duration(milliseconds: 500), curve: Curves.ease);
        } else {
          pageController!.nextPage(
              duration: const Duration(milliseconds: 500), curve: Curves.ease);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(onboardingNotifier.notifier);
    final state = ref.watch(onboardingNotifier);
    pageController = usePageController(initialPage: 0);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(flex: 2),
            Expanded(
              flex: 10,
              child: Center(
                child: Image.asset(
                  AppAssets.onboardingImage,
                  height: 436.h,
                ),
              ),
            ),
            Flexible(
              child: PageView(
                controller: pageController,
                onPageChanged: notifier.onPageChanged,
                children: onboardingTexts.map((text) {
                  return Text(
                    text,
                    style: AppTextStyles.light20,
                    textAlign: TextAlign.center,
                  );
                }).toList(),
              ),
            ),
            const Spacer(),
            const YSpacing(10),
            CarouselIndicator(
              length: 4,
              currentIndex: state.whenOrNull(data: (d) => d.pageIndex) ?? 0,
              spacing: 10.w,
              activeWidget: Container(
                decoration: BoxDecoration(
                  // borderRadius: BorderRadius.circular(borderRadius ?? 0),
                  color: AppColors.lightGrey,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.black,
                  ),
                ),
                height: 7.w,
                width: 7.w,
              ),
              inactiveWidget: Container(
                decoration: BoxDecoration(
                  color: AppColors.lightGrey,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.transparent),
                ),
                height: 7.w,
                width: 7.w,
              ),
            ),
            const YSpacing(10),
            const Spacer(flex: 2),
            AppButton(
              label: "LOGIN",
              buttonColor: AppColors.pink,
              labelColor: AppColors.black,
              onTap: () => notifier.showSignInSheet(),
            ),
            const YSpacing(10),
            AppButton(
              label: "SIGN UP",
              isBusy: state is AsyncLoading,
              onTap: () => notifier.showSignUpSheet(),
            ),
            const YSpacing(32),
            Text(
              "Read our terms and conditions before using this application.",
              style: AppTextStyles.light12,
              textAlign: TextAlign.center,
            ),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
