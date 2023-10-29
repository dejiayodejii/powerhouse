import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:powerhouse/ui/components/_components.dart';
import 'package:powerhouse/ui/views/home/notifiers/home_notifier.dart';

class Motivations extends StatefulHookConsumerWidget {
  const Motivations({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MotivationsState();
}

class _MotivationsState extends ConsumerState<Motivations> {
  Timer? _timer;
  PageController? _pageController;

  @override
  void initState() {
    super.initState();
    _scrollMotivation();
  }

  void _scrollMotivation() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      final state = ref.read(homeNotifier);
      if (state.motivations.isEmpty) return;
      if (_pageController == null) return;
      if (!_pageController!.hasClients) return;
      _pageController!.animateToPage(
        _pageController!.page == 2
            ? 0
            : (_pageController!.page?.toInt() ?? 0) + 1,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homeNotifier);
    _pageController = usePageController();
    if (state.isBusy) {
      return const Center(
        child: AppLoader(padding: 20),
      );
    }
    if (state.motivations.isEmpty) return const SizedBox();
    return SizedBox(
      height: 120.h,
      child: PageView.builder(
        itemCount: state.motivations.length,
        controller: _pageController,
        itemBuilder: (context, index) {
          final motivation = state.motivations[index];
          return MediaWidget(
            title: motivation.title.toUpperCase(),
            body: motivation.body,
            image: motivation.coverImage,
            onTap: () => ref
                .read(homeNotifier.notifier)
                .navigateToMediaDetail(motivation),
            currentIndex: index,
          );
        },
      ),
    );
  }
}
