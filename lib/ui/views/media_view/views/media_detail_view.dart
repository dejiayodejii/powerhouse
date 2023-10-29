import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:powerhouse/core/enums/media_type.dart';
import 'package:powerhouse/core/models/media_model.dart';
import 'package:powerhouse/ui/components/_components.dart';
import 'package:powerhouse/ui/constants/_constants.dart';
import 'package:powerhouse/ui/views/media_view/notifiers/media_detail_notifier.dart';
import 'package:powerhouse/ui/views/media_view/notifiers/podcast_notifier.dart';
import 'package:powerhouse/ui/views/media_view/views/podcast_view.dart';

import 'article_view.dart';

class MediaDetailView extends StatefulHookConsumerWidget {
  final MediaModel medium;
  const MediaDetailView({
    Key? key,
    required this.medium,
  }) : super(key: key);
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MediaDetailViewState();
}

class _MediaDetailViewState extends ConsumerState<MediaDetailView> {
  dynamic mediaRef;
  @override
  void initState() {
    super.initState();
    ref.read(mediaDetailNotifier.notifier).onInit(widget.medium);
    switch (widget.medium.type) {
      case MediaType.podcast:
        mediaRef = ref.read(podcastNotifier.notifier);
        mediaRef.init(widget.medium);
        break;
      default:
        break;
    }
  }

  @override
  void dispose() {
    switch (widget.medium.type) {
      case MediaType.podcast:
        mediaRef.close();
        break;
      default:
        break;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(20.sp),
          child: Column(
            children: [
              const AppBackButton(),
              const YSpacing(20),
              Expanded(
                child: Builder(
                  builder: (context) {
                    if (widget.medium.type == MediaType.podcast) {
                      return const PodcastView();
                    } else {
                      return const ArticleView();
                    }
                  },
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
