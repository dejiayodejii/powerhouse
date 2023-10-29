import 'package:powerhouse/core/enums/_enums.dart';
import 'package:powerhouse/core/models/_models.dart';

class MediaState {
  List<MediaModel> media = [];
  List<MediaModel> sortedMedia = [];
  // List<MediaModel> mediaList = [];
  bool isBusy = false;
  MediaType? type;

  List<MediaModel> get mediaList => sortedMedia.isEmpty ? media : sortedMedia;
}
