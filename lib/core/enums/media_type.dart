enum MediaType {
  article,
  podcast,
  video,
}

String mediaTypeToString(MediaType type) {
  switch (type) {
    case MediaType.article:
      return "article";
    case MediaType.podcast:
      return "podcast";
    case MediaType.video:
      return "video";
  }
}

MediaType mediaTypeFromString(String value) {
  switch (value) {
    case "article":
      return MediaType.article;
    case "podcast":
      return MediaType.podcast;
    case "video":
      return MediaType.video;
    default:
      return MediaType.article;
  }
}
