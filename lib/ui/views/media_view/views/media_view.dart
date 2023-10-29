import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:powerhouse/core/enums/media_type.dart';
import 'package:powerhouse/ui/components/_components.dart';
import 'package:powerhouse/ui/constants/_constants.dart';
import 'package:powerhouse/ui/views/media_view/notifiers/media_notifier.dart';

class MediaView extends StatefulHookConsumerWidget {
  const MediaView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MediaViewState();
}

class _MediaViewState extends ConsumerState<MediaView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(mediaNotifier.notifier).onInit();
    });
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.watch(mediaNotifier.notifier);
    final state = ref.watch(mediaNotifier);
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
                if (state.isBusy && state.data!.mediaList.isEmpty) {
                  return const Center(
                    child: AppLoader(),
                  );
                }
                return RefreshIndicator(
                  onRefresh: () => notifier.fetchMedia(),
                  child: Visibility(
                    visible: state.data!.type != null
                        ? state.data!.sortedMedia.isEmpty
                        : state.data!.media.isEmpty,
                    child: ScrollColumnExpandable(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: [
                        Expanded(
                          child: Center(
                            child: Text(
                              "No media found",
                              style: AppTextStyles.kTextStyle(
                                15,
                                height: 17.58,
                                weight: FontWeight.w500,
                                color: AppColors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    replacement: ListView.separated(
                      itemCount: state.data!.mediaList.length,
                      padding: const EdgeInsets.only(bottom: 19, top: 4),
                      physics: const AlwaysScrollableScrollPhysics(),
                      controller: notifier.scrollController,
                      separatorBuilder: (context, index) {
                        return const Divider(
                          thickness: 2,
                          color: AppColors.veryLightGrey,
                        );
                      },
                      itemBuilder: (context, index) {
                        final data = state.data!.mediaList[index];
                        return MediaListItem(
                          title: data.title.toUpperCase(),
                          body: data.body,
                          subText: data.author.toUpperCase(),
                          image: data.coverImage,
                          showIndicator: false,
                          onTap: () => notifier.onMediaClick(data),
                        );
                      },
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
                              "Media",
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
                        Expanded(
                          child: OptionWidget(
                            icon: AppAssets.articleSvg,
                            name: "Articles",
                            spacing: 5,
                            onTap: () => notifier.sortMedia(MediaType.article),
                            textColor: state.data!.type == MediaType.article
                                ? AppColors.white
                                : AppColors.black,
                            iconColor: state.data!.type == MediaType.article
                                ? AppColors.white
                                : null,
                            color: state.data!.type == MediaType.article
                                ? AppColors.darkPink
                                : AppColors.white,
                          ),
                        ),
                        const XSpacing(10),
                        Expanded(
                          child: OptionWidget(
                            icon: AppAssets.podcastSvg,
                            name: "Podcasts",
                            spacing: 5,
                            onTap: () => notifier.sortMedia(MediaType.podcast),
                            textColor: state.data!.type == MediaType.podcast
                                ? AppColors.white
                                : AppColors.black,
                            iconColor: state.data!.type == MediaType.podcast
                                ? AppColors.white
                                : null,
                            color: state.data!.type == MediaType.podcast
                                ? AppColors.darkPink
                                : AppColors.white,
                          ),
                        ),
                        const XSpacing(10),
                        Expanded(
                          child: OptionWidget(
                            icon: AppAssets.videosSvg,
                            name: "Videos",
                            spacing: 5,
                            onTap: () => notifier.sortMedia(MediaType.video),
                            textColor: state.data!.type == MediaType.video
                                ? AppColors.white
                                : AppColors.black,
                            iconColor: state.data!.type == MediaType.video
                                ? AppColors.white
                                : null,
                            color: state.data!.type == MediaType.video
                                ? AppColors.darkPink
                                : AppColors.white,
                          ),
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
