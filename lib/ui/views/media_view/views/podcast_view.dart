import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:powerhouse/ui/components/_components.dart';
import 'package:powerhouse/ui/constants/_constants.dart';
import 'package:powerhouse/ui/views/media_view/notifiers/media_detail_notifier.dart';
import 'package:powerhouse/ui/views/media_view/notifiers/podcast_notifier.dart';

class PodcastView extends HookConsumerWidget {
  const PodcastView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(mediaDetailNotifier.notifier);
    final podNotifier = ref.watch(podcastNotifier.notifier);
    final podState = ref.watch(podcastNotifier);
    final state = ref.watch(mediaDetailNotifier);
    final _medium = state.data!.medium;
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.sp),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: Image.network(
              _medium!.coverImage,
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              color: AppColors.black.withOpacity(0.5),
            ),
          ),
          Positioned(
            bottom: 15.h,
            left: 14.w,
            child: Row(
              children: [
                InkWell(
                  onTap: () => notifier.onLikeClick(_medium),
                  child: CircleAvatar(
                    radius: 16.sp,
                    backgroundColor: AppColors.pink,
                    child: Icon(
                      _medium.isLiked ? Icons.favorite : Icons.favorite_border,
                      color: AppColors.black,
                    ),
                  ),
                ),
                const XSpacing(11),
                InkWell(
                  onTap: notifier.onShareClick,
                  child: CircleAvatar(
                    radius: 16.sp,
                    backgroundColor: AppColors.pink,
                    child: const Icon(
                      Icons.share,
                      color: AppColors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned.fill(
            top: 83.h,
            bottom: 83.h,
            left: 14.w,
            right: 14.w,
            child: Builder(
              builder: (context) {
                if (podState.isBusy && podNotifier.duration == null) {
                  return const Center(
                    child: AppLoader(),
                  );
                }
                return Column(
                  children: [
                    const Spacer(),
                    Center(
                      child: Visibility(
                        visible: !podState.isBusy,
                        child: IconButton(
                          onPressed: podState.data?.mediaIsPlaying ?? false
                              ? podNotifier.pause
                              : podNotifier.play,
                          color: AppColors.white,
                          iconSize: 70.r,
                          icon: Icon(
                            podState.data?.mediaIsPlaying ?? false
                                ? Icons.pause_circle
                                : Icons.play_circle,
                          ),
                        ),
                        replacement: const AppLoader(),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      _medium.title,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.whiteBold16.copyWith(
                        fontSize: 18.sm,
                      ),
                    ),
                    const YSpacing(10),
                    Text(
                      _medium.author.toUpperCase(),
                      style: AppTextStyles.whiteLight15.copyWith(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const YSpacing(14),
                    StreamBuilder<Duration>(
                      stream: podNotifier.currentPosition,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                                ConnectionState.waiting ||
                            snapshot.data == null) {
                          return const AppLoader();
                        }
                        final data = snapshot.data ?? Duration.zero;
                        return Column(
                          children: [
                            Slider(
                              value: data.inMilliseconds.toDouble(),
                              onChanged: podNotifier.jumpToDuration,
                              activeColor: AppColors.pink,
                              inactiveColor: AppColors.lightGrey,
                              thumbColor: AppColors.pink,
                              max: (podNotifier.duration ?? Duration.zero)
                                  .inMilliseconds
                                  .toDouble(),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const XSpacing(15),
                                Text(
                                  podNotifier.getDuration(data),
                                  style: AppTextStyles.light12.copyWith(
                                    color: AppColors.white,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  podNotifier.getDuration(
                                      podNotifier.duration ?? Duration.zero),
                                  style: AppTextStyles.light12.copyWith(
                                    color: AppColors.white,
                                  ),
                                ),
                                const XSpacing(15),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
