import 'package:chewie/chewie.dart';
import 'package:flutter/services.dart';
import 'package:powerhouse/services/video_player_service/i_video_player_service.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerService extends IVideoPlayerService {
  VideoPlayerController? _videocontroller;
  ChewieController? _chewieController;

  @override
  Duration get currentPosition => _videocontroller!.value.position;
  @override
  Duration get duration => _videocontroller!.value.duration;
  @override
  bool get isPlaying => _videocontroller!.value.isPlaying;

  @override
  Future<void> dispose() async {
    await _videocontroller!.dispose();
    _chewieController!.dispose();
    _videocontroller = null;
    _chewieController = null;
  }

  @override
  void toggleFullView(bool isFullView) {
    _chewieController = _chewieController!.copyWith(
      allowedScreenSleep: !isFullView,
      showControls: isFullView,
    );
  }

  @override
  Future<void> init(String url) async {
    _videocontroller = VideoPlayerController.network(url);
    await _videocontroller!.initialize();
    _chewieController = ChewieController(
      videoPlayerController: _videocontroller!,
      looping: false,
      allowedScreenSleep: true,
      fullScreenByDefault: false,
      allowFullScreen: true,
      showControls: true,
      // showOptions: false,
      deviceOrientationsOnEnterFullScreen: [
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ],
      deviceOrientationsAfterFullScreen: [
        // DeviceOrientation.landscapeLeft,
        // DeviceOrientation.landscapeRight,
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );
    // _videocontroller!.setLooping(true);
  }

  @override
  Future<void> pause() async {
    await _videocontroller!.pause();
  }

  @override
  Future<void> play() async {
    // if (_videocontroller!.value.isBuffering) ;
    await _videocontroller!.play();
  }

  @override
  Future<void> seek(Duration position) async {
    await _videocontroller!.seekTo(position);
  }

  @override
  Future<void> stop() async {
    await _videocontroller!.dispose();
    _videocontroller = null;
  }

  @override
  VideoPlayerController? get controller => _videocontroller;
  @override
  ChewieController? get chewieController => _chewieController;
}
