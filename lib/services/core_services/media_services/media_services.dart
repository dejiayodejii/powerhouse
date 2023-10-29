import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:powerhouse/core/constants/_constants.dart';
import 'package:powerhouse/core/enums/_enums.dart';
import 'package:powerhouse/core/models/_models.dart';
import 'package:powerhouse/services/_services.dart';

class MediaService extends IMediaService {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  String get userId => _auth.currentUser!.uid;
  DocumentMap get quoteDoc => _firestore.collection("admin").doc("quotes");
  DocumentMap get mediaDoc => _firestore.collection("admin").doc("media");
  CollectionRef get articlesColl => mediaDoc.collection("articles");
  CollectionRef get podcastsColl => mediaDoc.collection("podcasts");
  CollectionRef get videosColl => mediaDoc.collection("videos");

  CollectionRef getColl(MediaType type) {
    switch (type) {
      case MediaType.article:
        return articlesColl;
      case MediaType.podcast:
        return podcastsColl;
      case MediaType.video:
        return videosColl;
    }
  }

  Future<bool> _checkIfLiked(MediaModel media) async {
    final likes =
        await getColl(media.type!).doc(media.id).collection("likes").get();
    return likes.docs.map((e) => e.id).contains(userId);
  }

  @override
  Future<QuoteModel> getQuoteOfTheDay() async {
    final res = await quoteDoc.get();
    return QuoteModel.fromMap(res.data()!);
  }

  @override
  Future<List<MediaModel>> fetchMotivations() async {
    final res = await mediaDoc.get();
    final motivationIds = res.data()!["motivations"] as List;
    final motivations = await articlesColl
        .where(FieldPath.documentId, whereIn: motivationIds)
        .get();
    final parsedData = (motivations.docs
        .map((doc) => MediaModel.fromMap(doc.data()))).toList();
    await Future.forEach(parsedData, (MediaModel doc) async {
      final index = parsedData.indexWhere((media) => media.id == doc.id);
      parsedData[index].type = MediaType.article;
      parsedData[index].isLiked = await _checkIfLiked(doc);
    });
    return parsedData;
  }

  @override
  Future<List<MediaModel>> fetchArticles() async {
    final snapshot = await articlesColl.get();
    final mediaList =
        snapshot.docs.map((doc) => MediaModel.fromMap(doc.data())).toList();
    await Future.forEach(snapshot.docs, (QueryDocumentMap doc) async {
      final index = mediaList.indexWhere((media) => media.id == doc.id);
      mediaList[index].type = MediaType.article;
      mediaList[index].isLiked = await _checkIfLiked(mediaList[index]);
    });
    return mediaList;
  }

  @override
  Future<List<MediaModel>> fetchPodcasts() async {
    final snapshot = await podcastsColl.get();
    final mediaList =
        snapshot.docs.map((doc) => MediaModel.fromMap(doc.data())).toList();
    await Future.forEach(snapshot.docs, (QueryDocumentMap doc) async {
      final index = mediaList.indexWhere((media) => media.id == doc.id);
      mediaList[index].type = MediaType.podcast;
      mediaList[index].isLiked = await _checkIfLiked(mediaList[index]);
    });
    return mediaList;
  }

  @override
  Future<List<MediaModel>> fetchVideos() async {
    final snapshot = await videosColl.get();
    final mediaList =
        snapshot.docs.map((doc) => MediaModel.fromMap(doc.data())).toList();
    await Future.forEach(snapshot.docs, (QueryDocumentMap doc) async {
      final index = mediaList.indexWhere((media) => media.id == doc.id);
      mediaList[index].type = MediaType.video;
      mediaList[index].isLiked = await _checkIfLiked(mediaList[index]);
    });
    return mediaList;
  }

  @override
  Future<MediaModel?> fetchMediaDetail(String mediaType, String mediaId) async {
    final data = await mediaDoc.collection("${mediaType}s").doc(mediaId).get();
    if (data.data() == null) return null;
    return MediaModel.fromMap(data.data()!)
      ..type = mediaTypeFromString(mediaType);
  }

  @override
  Future<bool> toggleLike(MediaModel media) async {
    final data = await getColl(media.type!)
        .doc(media.id)
        .collection("likes")
        .where(FieldPath.documentId, isEqualTo: userId)
        .get();
    final isLiked = data.docs.isNotEmpty;
    if (isLiked) {
      await getColl(media.type!)
          .doc(media.id)
          .collection("likes")
          .doc(userId)
          .delete();
      return false;
    } else {
      await getColl(media.type!)
          .doc(media.id)
          .collection("likes")
          .doc(userId)
          .set({});
      return true;
    }
  }
}
