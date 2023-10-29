import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:powerhouse/core/models/_models.dart';
import 'package:powerhouse/services/_services.dart';

abstract class IDynamicLinkService {
  String? get mediaType;
  String? get mediaId;

  Future<void> initialize();
  Future<String> generateLink({required MediaModel media});
  Future<void> shareLink(String link);
  void clearData();
}

final dynamicLinkService = Provider<IDynamicLinkService>(
  (ref) => DynamicLinkService(
    forceUpdateAppService: ref.read(forceUpdateService),
  ),
);
