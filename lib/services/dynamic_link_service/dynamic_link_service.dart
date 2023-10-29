import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:logger/logger.dart';
import 'package:powerhouse/app/_app.dart';
import 'package:powerhouse/core/enums/_enums.dart';
import 'package:powerhouse/core/models/_models.dart';
import 'package:powerhouse/services/force_update_service/i_force_update_service.dart';
import 'package:powerhouse/ui/constants/_constants.dart';
import 'package:share_plus/share_plus.dart';

import 'i_dynamic_link_service.dart';

/// example of short link
/// `https://sheisapowerhouse.page.link/E23AYzob1DyPojZm7`
///
///
/// example of long link
/// `https://sheisapowerhouse.page.link?utm_campaign=example-promo&sd=A%20joint%20where%20all%20things%20fun%20are%20made%20to%20happen!&st=Welcome%20to%20GoodTime...&amv=0&apn=com.devmike.goodtime_app&link=https%3A%2F%2Fgoodtime.gt%2Fcommunity%3F98da8b9e-a5fa-48f1-b464-803b0d7c2d72&utm_medium=social&utm_source=orkut`
///
///
/// format of the deep link
/// `https://powerhouse.com/[media-type]?[media-id]`
///
/// Note that if the [linkDomain] url is changed it must be changed in the
/// android manifest
class DynamicLinkService extends IDynamicLinkService {
  //  static DynamicLinkService? _instance;

  // DynamicLinkService._internal();

  // static DynamicLinkService getInstance() {
  //   _instance ??= DynamicLinkService._internal();

  //   return _instance!;
  // }
  // static DynamicLinkService instance(IForceUpdateAppService forceUpdateAppService) => DynamicLinkService._();
  final IForceUpdateAppService forceUpdateAppService;
  DynamicLinkService({
    required this.forceUpdateAppService,
  });

  static const appId = "com.powerhouse.app";
  static const iosAppId = "com.powerhouse.ios-app";

  static const devLinkDomain = "https://sheisapowerhouse.page.link";
  static const prodLinkDomain = "https://sheisapowerhouseapp.page.link";
  String get linkDomain =>
      FlavorConfig.isDevelopment() ? devLinkDomain : prodLinkDomain;

  final _log = Logger();

  @override
  String? mediaType;
  @override
  String? mediaId;

  @override
  Future<void> initialize() async {
    final _dynamicLink = await FirebaseDynamicLinks.instance.getInitialLink();

    if (_dynamicLink != null) {
      final Uri deepLink = _dynamicLink.link;
      _log.i('DEEPLINK IS $deepLink');
      _handleData(deepLink.toString());
    }

    FirebaseDynamicLinks.instance.onLink.listen((dynamicLink) {
      final Uri deepLink = dynamicLink.link;
      _handleData(deepLink.toString());
    }).onError((error) {
      _log.e(error.toString());
    });
  }

  void _handleData(String query) {
    final queryParams = Uri.parse(query).queryParameters;
    _log.i('Dynamic Link Data: $queryParams');
    mediaType = queryParams['type'];
    mediaId = queryParams['id'];
    assert(mediaType != null && mediaId != null);
  }

  Uri _getLinkFromMedia(MediaModel media) {
    final mediaType = mediaTypeToString(media.type!);
    return Uri.parse(
        "https://sheisapowerhouse.com?type=$mediaType&id=${media.id}");
  }

  @override
  Future<String> generateLink({required MediaModel media}) async {
    Uri deepLink = _getLinkFromMedia(media);

    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: linkDomain,
      link: deepLink,
      androidParameters: AndroidParameters(
        packageName: appId,
        minimumVersion:
            int.tryParse(await forceUpdateAppService.currentBuildNumber),
      ),
      iosParameters: IOSParameters(
        bundleId: iosAppId,
        minimumVersion: await forceUpdateAppService.currentBuildNumber,
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
        title: AppStrings.appName,
        description: media.title,
        imageUrl: Uri.parse(media.coverImage),
      ),
    );

    final dynamicUrl = await FirebaseDynamicLinks.instance.buildShortLink(
      parameters,
      shortLinkType: ShortDynamicLinkType.unguessable,
    );
    return dynamicUrl.shortUrl.toString();
  }

  @override
  Future<void> shareLink(String link) async {
    try {
      await Share.share(link, subject: AppStrings.appName);
    } catch (e) {
      throw Failure(message: "Could not share link");
    }
  }

  @override
  void clearData() {
    mediaType = null;
    mediaId = null;
  }
}
// https://pastebin.com/MujJ6jM4