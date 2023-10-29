import 'package:powerhouse/core/models/_models.dart';

class MediaDetailState {
  MediaModel? medium;
  bool isBusy = false;
  bool mediaIsPlaying = false;

  bool isFullScreen = false;

  MediaDetailState({
    this.medium,
    this.isBusy = false,
    this.mediaIsPlaying = false,
    this.isFullScreen = false,
  });

  MediaDetailState.playing() : mediaIsPlaying = true;
  MediaDetailState.fullScreen(bool value) : isFullScreen = value;
  //  {
  //   MediaDetailState.values(
  //     medium: medium,
  //     isBusy: isBusy,
  //     mediaIsPlaying: mediaIsPlaying,
  //     isFullScreen: value,
  //   );
  // }

  MediaDetailState.values({
    MediaModel? medium,
    bool? isBusy,
    bool? mediaIsPlaying,
    bool? isFullScreen,
  }) {
    MediaDetailState(
      medium: medium ?? this.medium,
      isBusy: isBusy ?? this.isBusy,
      mediaIsPlaying: mediaIsPlaying ?? this.mediaIsPlaying,
      isFullScreen: isFullScreen ?? this.isFullScreen,
    );
  }
}
