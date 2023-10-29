import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:powerhouse/core/models/_models.dart';

import 'media_services.dart';

abstract class IMediaService {
  Future<QuoteModel> getQuoteOfTheDay();
  Future<List<MediaModel>> fetchMotivations();
  Future<List<MediaModel>> fetchArticles();
  Future<List<MediaModel>> fetchPodcasts();
  Future<List<MediaModel>> fetchVideos();
  Future<MediaModel?> fetchMediaDetail(String mediaType, String mediaId);
  Future<bool> toggleLike(MediaModel media);
}

final mediaService = Provider<IMediaService>(
  (ref) => MediaService(),
);
