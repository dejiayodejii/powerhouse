import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:powerhouse/core/models/_models.dart';
import 'package:powerhouse/core/utils/utils.dart';
import 'package:powerhouse/services/_services.dart';
import 'package:powerhouse/ui/constants/view_state.dart';
import 'package:powerhouse/ui/views/media_view/state/media_detail_state.dart';

typedef State = ViewState<MediaDetailState>;

class PodcastNotifier extends StateNotifier<State> {
  final IMediaService mediaService;
  final INavigationService navigationService;
  final IAudioPlayerService audioPlayerService;

  PodcastNotifier({
    required this.mediaService,
    required this.navigationService,
    required this.audioPlayerService,
  }) : super(ViewState.loading());
  final logger = Logger();

  void init(MediaModel medium) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      state = state.loading();
      await audioPlayerService.init(medium.mediaUrl!);
      state = state.idle();
    });
  }

  Future<void> play() async {
    try {
      // print(isPlaying);
      // print(state.data!.mediaIsPlaying);
      state = state.idle(MediaDetailState.playing());
      await audioPlayerService.play();
      assert(isPlaying);
    } catch (e) {
      logger.e(e.toString());
    }
  }

  Future<void> pause() async {
    try {
      // print("HERE:" + isPlaying.toString());
      // print(state.data!.mediaIsPlaying);
      await audioPlayerService.pause();
      state = state.idle(MediaDetailState());
    } catch (e) {
      logger.e(e.toString());
    }
  }

  Future<void> jumpToDuration(double position) async {
    state = state.loading();
    final _position = Duration(milliseconds: (position.floor()));
    await audioPlayerService.seek(_position);
    state = state.idle();
  }

  Future<void> close() async {
    await audioPlayerService.dispose();
    state = state.idle(MediaDetailState());
  }

  String getDuration(Duration duration) {
    String time = duration.toString();
    return Utils.formatDuration(time);
  }

  Stream<Duration> get currentPosition => audioPlayerService.currentPosition;
  Duration? get duration => audioPlayerService.duration;
  bool get isPlaying => audioPlayerService.isPlaying;
}

final podcastNotifier = StateNotifierProvider<PodcastNotifier, State>(
  (ref) => PodcastNotifier(
    mediaService: ref.watch(mediaService),
    navigationService: ref.watch(navigationService),
    audioPlayerService: ref.watch(audioPlayerService),
  ),
);
