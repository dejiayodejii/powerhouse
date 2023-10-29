import 'package:chewie/chewie.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:video_player/video_player.dart';

import 'video_player_service.dart';

abstract class IVideoPlayerService {
  Duration get currentPosition;
  Duration get duration;
  bool get isPlaying;
  VideoPlayerController? get controller;
  ChewieController? get chewieController;
  Future<void> init(String url);
  Future<void> play();
  Future<void> pause();
  Future<void> stop();
  Future<void> seek(Duration position);
  Future<void> dispose();
  void toggleFullView(bool isFullView);
}

final videoPlayerService = Provider<IVideoPlayerService>(
  (_) => VideoPlayerService(),
);
