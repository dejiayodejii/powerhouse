import 'dart:async';

import 'package:chewie/chewie.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:powerhouse/core/models/_models.dart';
import 'package:powerhouse/services/_services.dart';
import 'package:powerhouse/ui/constants/view_state.dart';
import 'package:powerhouse/ui/views/media_view/state/media_detail_state.dart';
import 'package:video_player/video_player.dart';

typedef State = ViewState<MediaDetailState>;

class VideoNotifier extends StateNotifier<State> {
  final IMediaService mediaService;
  final INavigationService navigationService;
  final IVideoPlayerService videoPlayerService;

  VideoNotifier({
    required this.mediaService,
    required this.navigationService,
    required this.videoPlayerService,
  }) : super(ViewState.loading());

  late StreamSubscription<Duration> durationSub;

  Future<void> toFullScreenMode() async {
    if (state.data!.isFullScreen) {
      videoPlayerService.toggleFullView(false);
      await controller!.pause();
      state = state.idle(MediaDetailState.values(
        mediaIsPlaying: false,
        isFullScreen: false,
      ));
    } else {
      videoPlayerService.toggleFullView(true);
      state = state.idle(MediaDetailState.fullScreen(true));
    }
  }

  Future<void> init(MediaModel medium) async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      state = state.loading();
      await videoPlayerService.init(medium.mediaUrl!);
      controller!.addListener(() {
        if (duration.compareTo(currentPosition) == 0 ||
            duration.compareTo(currentPosition) == -1) {
          state = state.idle(MediaDetailState());
        }
      });
      state = state.idle(MediaDetailState());
    });
  }

  Future<void> onPlayTap() async {
    if (state.data?.mediaIsPlaying ?? false) {
      await videoPlayerService.pause();
      state = state.idle(MediaDetailState());
    } else {
      state = state.loading();
      await videoPlayerService.play();
      state = state.idle(MediaDetailState.playing());
    }
    // state = state.isPlaying ? PodcastState() : PodcastState.playing();
  }

  Future<void> jumpToDuration(double position) async {
    final _position = Duration(milliseconds: (position.floor()));
    await videoPlayerService.seek(_position);
    state = state;
  }

  Future<void> close() async {
    controller?.removeListener(() {});
    await videoPlayerService.dispose();
    state = state.idle();
  }

  Stream<Duration> positionStream() async* {
    yield videoPlayerService.currentPosition;
  }

  Duration get currentPosition => videoPlayerService.currentPosition;
  Duration get duration => videoPlayerService.duration;
  VideoPlayerController? get controller => videoPlayerService.controller;
  ChewieController? get cheiweController => videoPlayerService.chewieController;
  bool get isPlaying => videoPlayerService.isPlaying;
}

final videoNotifier = StateNotifierProvider<VideoNotifier, State>(
  (ref) => VideoNotifier(
    mediaService: ref.watch(mediaService),
    navigationService: ref.watch(navigationService),
    videoPlayerService: ref.watch(videoPlayerService),
  ),
);
