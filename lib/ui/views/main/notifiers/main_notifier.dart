import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:powerhouse/app/_app.dart';
import 'package:powerhouse/core/enums/_enums.dart';
import 'package:powerhouse/core/mixins/_mixins.dart';
import 'package:powerhouse/core/models/_models.dart';
import 'package:powerhouse/main.dart';
import 'package:powerhouse/services/_services.dart';
import 'package:powerhouse/ui/constants/view_state.dart';

import '../states/main_view_state.dart';

typedef State = ViewState<MainViewState>;

class MainNotifier extends StateNotifier<State> with ToastMixin {
  final IDynamicLinkService dynamicLinkService;
  final IMediaService mediaService;
  final INavigationService navigationService;
  MainNotifier({
    required this.dynamicLinkService,
    required this.mediaService,
    required this.navigationService,
  }) : super(ViewState.idle(MainViewState()));

  void init() {
    _didReceiveDynamicLink();
  }

  Future<void> _didReceiveDynamicLink() async {
    if (dynamicLinkService.mediaId == null) return;
    final media = await mediaService.fetchMediaDetail(
        dynamicLinkService.mediaType!, dynamicLinkService.mediaId!);
    // final media = await mediaService.fetchMediaDetail("video", "1");
    if (media == null) {
      showFailureToast("Media not found");
      return;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      navigateToMediaDetail(media);
    });
  }

  void navigateToMediaDetail(MediaModel media) {
    if (media.type == MediaType.video) {
      navigationService.navigateTo(Routes.videoMediaDetailView,
          arguments: media);
    } else {
      navigationService.navigateTo(Routes.mediaDetailView, arguments: media);
    }
  }

  void onTabChanged(int index) {
    state = state.copyWith(data: MainViewState.ofTab(index));
  }
}

final mainNotifier = StateNotifierProvider<MainNotifier, State>(
  (ref) => MainNotifier(
    dynamicLinkService: contextlessRef.read(dynamicLinkService),
    mediaService: ref.watch(mediaService),
    navigationService: ref.watch(navigationService),
  ),
);
