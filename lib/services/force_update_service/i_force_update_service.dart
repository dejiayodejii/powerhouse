import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'force_update_service.dart';

abstract class IForceUpdateAppService {
  Future<bool> get needsUpdate;
  Future<String?> get enforcedVersionRaw;
  Future<String> get currentVersionRaw;
  Future<String> get currentBuildNumber;
}

final forceUpdateService =
    Provider<IForceUpdateAppService>((ref) => ForceUpdateAppService());
