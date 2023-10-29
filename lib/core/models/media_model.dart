import 'dart:convert';

import 'package:powerhouse/core/enums/media_type.dart';
import 'package:powerhouse/ui/constants/_constants.dart';

class MediaModel {
  final String id;
  final String title;
  final String author;
  final String body;
  final String coverImage;
  String? mediaUrl;
  MediaType? type;
  bool isLiked;

  MediaModel({
    required this.id,
    required this.title,
    required this.author,
    required this.body,
    required this.coverImage,
    this.mediaUrl,
    this.type,
    required this.isLiked,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'author': author,
      'cover_image': coverImage,
      'media_url': mediaUrl,
      'body': body,
    };
  }

  factory MediaModel.fromMap(Map<String, dynamic> map) {
    return MediaModel(
      id: map['id'],
      title: map['title'],
      author: map['author'],
      coverImage: map['cover_image'],
      mediaUrl: map['media_url'],
      body: map['body'],
      isLiked: false,
    );
  }

  factory MediaModel.fromJson(String source) =>
      MediaModel.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MediaModel &&
        other.id == id &&
        other.title == title &&
        other.author == author;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        author.hashCode ^
        mediaUrl.hashCode ^
        type.hashCode ^
        body.hashCode;
  }
}

final mockMedia = MediaModel(
  id: '1',
  title: "The Speech That Shook The International Community",
  body:
      '''The end of May through June is always a wonderful time, as it's when many Black folks graduate with high school diplomas, as well with undergraduate and advanced degrees. 
\nIt's always great to see our people pursuing their dreams and achieving greatness.
\nAnother added bonus is the number of phenomenal and successful Black women who are invited to give the commencement
\nThis is a sample article, so it stops here. 
The end of May through June is always a wonderful time, as it's when many Black folks graduate with high school diplomas, as well with undergraduate and advanced degrees. 
\nIt's always great to see our people pursuing their dreams and achieving greatness.
\nAnother added bonus is the number of phenomenal and successful Black women who are invited to give the commencement
\nThis is a sample article, so it stops here. 
The end of May through June is always a wonderful time, as it's when many Black folks graduate with high school diplomas, as well with undergraduate and advanced degrees. 
\nIt's always great to see our people pursuing their dreams and achieving greatness.
\nAnother added bonus is the number of phenomenal and successful Black women who are invited to give the commencement
\nThis is a sample article, so it stops here. ''',
  coverImage: AppStrings.mockNetworkImage,
  type: MediaType.article,
  author: "Dan Vinci",
  isLiked: false,
);

final mockMedia1 = MediaModel(
  id: '2',
  title: "How I Started My Business With Little Experience",
  body:
      'https://ia601607.us.archive.org/24/items/Show128GratitudeFeatMattPfeffer5LCBJAndCavs/Show%20128%20Gratitude%20Feat%20Matt%20Pfeffer%20%235L%20CBJ%20and%20Cavs.mp3',
  coverImage: AppStrings.mockNetworkImage,
  mediaUrl: AppStrings.mockNetworkImage,
  type: MediaType.podcast,
  author: "KELLY PELLER",
  isLiked: true,
);

final mockMedia2 = MediaModel(
  id: '3',
  title: "Why Every Woman Should Embrace Her Purpose",
  body:
      'https://archive.org/download/electricsheep-flock-248-0-7/00248%3D00097%3D00060%3D00082.mp4',
  mediaUrl:
      "https://cdn.theatlantic.com/thumbor/ZmO_L_TJAnQ1KX_DXbZWSScLqeI=/0x50:980x601/976x549/media/img/mt/2017/01/GettyImages_476064417-1/original.jpg",
  coverImage: AppStrings.mockNetworkImage,
  type: MediaType.video,
  author: "Michelle Obama",
  isLiked: false,
);
