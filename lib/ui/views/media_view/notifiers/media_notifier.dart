import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:powerhouse/app/_app.dart';
import 'package:powerhouse/core/enums/media_type.dart';
import 'package:powerhouse/core/models/_models.dart';
import 'package:powerhouse/services/_services.dart';
import 'package:powerhouse/ui/constants/view_state.dart';
import 'package:powerhouse/ui/views/media_view/state/media_state.dart';

typedef State = ViewState<MediaState>;

class MediaNotifier extends StateNotifier<State> {
  final IMediaService mediaService;
  final INavigationService navigationService;

  MediaNotifier({
    required this.mediaService,
    required this.navigationService,
  }) : super(ViewState.idle(MediaState()));

  final scrollController = ScrollController();
  final _logger = Logger();

  void onInit() {
    fetchMedia();
  }

  Future<void> fetchMedia() async {
    try {
      state = state.loading();
      final articles = await mediaService.fetchArticles();
      final videos = await mediaService.fetchVideos();
      final podcasts = await mediaService.fetchPodcasts();
      state = state.idle(state.data!..media = articles + videos + podcasts);
      sortMedia();
    } on Failure catch (e) {
      _logger.e(e.toString());
      state = state.failure(e);
    } finally {
      state = state.idle();
    }
  }

  void sortMedia([MediaType? type]) {
    final media = state.data!.media;

    state.data!.sortedMedia.clear();
    if (state.data!.type == type) {
      /// Set Type to null and add all media to sorted media
      state.data!.type = null;
      state = state.idle(state.data!..sortedMedia.addAll(media));
    } else {
      /// Set Type to [type] and add all media of [type] to sorted media
      type = type ?? state.data!.type;
      state.data!.sortedMedia.addAll(
        media.where((item) => item.type == type),
      );
      state.data!.type = type;
    }
    state = state.idle(state.data!);
    if (scrollController.hasClients) {
      scrollController.animateTo(0,
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  Future<void> onLikeClick(MediaModel media) async {
    try {
      final isLiked = await mediaService.toggleLike(media);
      state.data!.media.firstWhere((e) => e.id == media.id).isLiked = isLiked;
      state = state.idle();
      state.data!.media = await mediaService.fetchArticles();
    } on Failure catch (e) {
      _logger.e(e.toString());
      state = state.failure(e);
    }
  }

  void onMediaClick(MediaModel data) {
    if (data.type == MediaType.video) {
      navigationService.navigateTo(Routes.videoMediaDetailView,
          arguments: data);
    } else {
      navigationService.navigateTo(Routes.mediaDetailView, arguments: data);
    }
  }
}

final mediaNotifier = StateNotifierProvider<MediaNotifier, State>(
  (ref) => MediaNotifier(
    mediaService: ref.watch(mediaService),
    navigationService: ref.watch(navigationService),
  ),
);
