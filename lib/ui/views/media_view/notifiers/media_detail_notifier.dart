import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:powerhouse/core/enums/_enums.dart';
import 'package:powerhouse/core/models/_models.dart';
import 'package:powerhouse/services/_services.dart';
import 'package:powerhouse/ui/constants/view_state.dart';
import 'package:powerhouse/ui/views/media_view/state/media_detail_state.dart';

typedef State = ViewState<MediaDetailState>;

class MediaDetailNotifier extends StateNotifier<State> {
  final IMediaService mediaService;
  final INavigationService navigationService;
  final IAudioPlayerService audioPlayerService;
  final IDynamicLinkService dynamicLinkService;

  MediaDetailNotifier({
    required this.mediaService,
    required this.navigationService,
    required this.audioPlayerService,
    required this.dynamicLinkService,
  }) : super(ViewState.idle(MediaDetailState()));

  final scrollController = ScrollController();
  final _logger = Logger();

  void onInit(MediaModel medium) {
    state.data!.medium = medium;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchMedia(medium);
    });
  }

  Future<void> fetchMedia(MediaModel medium) async {
    try {
      state = state.loading();
      final _medium = await mediaService.fetchMediaDetail(
        mediaTypeToString(medium.type!),
        medium.id,
      );
      state = state.idle(state.data!..medium = _medium!);
    } on Failure catch (e) {
      _logger.e(e.toString());
      state = state.failure(e);
    } finally {
      state = state.idle();
    }
  }

  Future<void> onLikeClick(MediaModel data) async {
    try {
      state = state.idle(state.data!..medium!.isLiked = !data.isLiked);
      await mediaService.toggleLike(data);
    } on Failure catch (e) {
      _logger.e(e.toString());
      state.data!.medium!.isLiked = !data.isLiked;
      state = state.failure(e);
    }
  }

  Future<void> onShareClick() async {
    try {
      final link =
          await dynamicLinkService.generateLink(media: state.data!.medium!);
      await dynamicLinkService.shareLink(link);
    } on Failure catch (e) {
      _logger.e(e.toString());
    }
  }
}

final mediaDetailNotifier = StateNotifierProvider<MediaDetailNotifier, State>(
  (ref) => MediaDetailNotifier(
    mediaService: ref.watch(mediaService),
    navigationService: ref.watch(navigationService),
    audioPlayerService: ref.watch(audioPlayerService),
    dynamicLinkService: ref.watch(dynamicLinkService),
  ),
);
