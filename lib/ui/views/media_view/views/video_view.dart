import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:powerhouse/core/models/_models.dart';
import 'package:powerhouse/ui/components/_components.dart';
import 'package:powerhouse/ui/constants/_constants.dart';
import 'package:powerhouse/ui/views/media_view/notifiers/media_detail_notifier.dart';
import 'package:powerhouse/ui/views/media_view/notifiers/video_notifier.dart';
import 'package:video_player/video_player.dart';

class VideoView extends StatefulHookConsumerWidget {
  final MediaModel medium;
  const VideoView({
    Key? key,
    required this.medium,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VideoViewState();
}

class _VideoViewState extends ConsumerState<VideoView> {
  late VideoNotifier mediaRef;

  @override
  void initState() {
    super.initState();
    ref.read(mediaDetailNotifier.notifier).onInit(widget.medium);
    mediaRef = ref.read(videoNotifier.notifier);
    mediaRef.init(widget.medium);
  }

  @override
  void dispose() {
    mediaRef.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.watch(mediaDetailNotifier.notifier);
    final state = ref.watch(mediaDetailNotifier);
    final vidNotifier = ref.watch(videoNotifier.notifier);
    final vidState = ref.watch(videoNotifier);
    final _medium = state.data!.medium!;

    if (vidState.data?.isFullScreen ?? false) {
      return const VideoFullScreenView();
    }

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(20.sp),
          child: Column(
            children: [
              const AppBackButton(),
              const YSpacing(20),
              Expanded(
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.sp),
                  ),
                  child: StreamBuilder<Duration>(
                    initialData: Duration.zero,
                    stream: vidNotifier.positionStream(),
                    builder: (context, snapshot) {
                      return Stack(
                        fit: StackFit.expand,
                        children: [
                          Positioned.fill(
                            child: Builder(
                              builder: (context) {
                                if (vidNotifier.controller != null) {
                                  final isInitialized = vidNotifier
                                          .controller?.value.isInitialized ??
                                      false;
                                  if (isInitialized) {
                                    return AspectRatio(
                                      aspectRatio: vidNotifier
                                          .controller!.value.aspectRatio,
                                      child:
                                          VideoPlayer(vidNotifier.controller!),
                                    );
                                  }
                                }
                                return Image.network(
                                  _medium.coverImage,
                                  fit: BoxFit.cover,
                                );
                              },
                            ),
                          ),
                          Builder(
                            builder: (context) {
                              if (vidState.isBusy) {
                                return const Center(
                                  child: AppLoader(),
                                );
                              }
                              final isPlaying =
                                  vidState.data?.mediaIsPlaying ?? false;
                              if (!isPlaying) {
                                return Center(
                                  child: IconButton(
                                    onPressed: () => vidNotifier.onPlayTap(),
                                    color: AppColors.white,
                                    iconSize: 70.r,
                                    icon: const Icon(
                                      Icons.play_circle,
                                    ),
                                  ),
                                );
                              }
                              return InkWell(
                                onTap: () => vidNotifier.onPlayTap(),
                                child: const SizedBox(
                                  height: double.maxFinite,
                                  width: double.maxFinite,
                                ),
                              );
                            },
                          ),
                          Positioned(
                            bottom: 15.h,
                            left: 14.w,
                            right: 14.w,
                            child: Builder(builder: (context) {
                              if (!(vidState.data?.mediaIsPlaying ?? false)) {
                                return Row(
                                  children: [
                                    InkWell(
                                      onTap: () =>
                                          notifier.onLikeClick(_medium),
                                      child: CircleAvatar(
                                        radius: 16.sp,
                                        backgroundColor: AppColors.pink,
                                        child: Icon(
                                          _medium.isLiked
                                              ? Icons.favorite
                                              : Icons.favorite_border,
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
                                    const Spacer(),
                                    InkWell(
                                      onTap: () =>
                                          vidNotifier.toFullScreenMode(),
                                      child: SvgPicture.asset(
                                        AppAssets.expandViewSvg,
                                      ),
                                    ),
                                  ],
                                );
                              }
                              return const SizedBox();
                            }),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              const YSpacing(15),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Container(
                      width: double.maxFinite,
                      padding: EdgeInsets.symmetric(
                          horizontal: 14.w, vertical: 20.h),
                      decoration: BoxDecoration(
                        color: AppColors.veryLightGrey,
                        borderRadius: BorderRadius.circular(15.sp),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _medium.title + " - " + _medium.author,
                            textAlign: TextAlign.start,
                            style:
                                AppTextStyles.bold14.copyWith(fontSize: 18.sm),
                          ),
                          const YSpacing(11),
                          Text(
                            _medium.title,
                            textAlign: TextAlign.start,
                            style: AppTextStyles.whiteLight15.copyWith(
                              color: AppColors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const YSpacing(10),
            ],
          ),
        ),
      ),
    );
  }
}

class VideoFullScreenView extends HookConsumerWidget {
  const VideoFullScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WillPopScope(
      onWillPop: () {
        ref.read(videoNotifier.notifier).toFullScreenMode();
        return Future.value(false);
      },
      child: SafeArea(
        child: Material(
          color: AppColors.black,
          child: Chewie(
            controller: ref.watch(videoNotifier.notifier).cheiweController!,
          ),
        ),
      ),
    );
  }
}
