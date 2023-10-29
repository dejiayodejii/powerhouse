import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:powerhouse/app/flavors/flavor_config.dart';
import 'package:powerhouse/core/constants/_constants.dart';

import 'i_force_update_service.dart';

class ForceUpdateAppService implements IForceUpdateAppService {
  final log = Logger();
  @override
  Future<String?> get enforcedVersionRaw async {
    final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
    try {
      remoteConfig.setDefaults({
        RemoteConfigKeys.enforcedVersion: await currentVersionRaw,
      });
      await remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 120),
          minimumFetchInterval: const Duration(hours: 1),
        ),
      );
      await remoteConfig.fetchAndActivate();
    } catch (e) {
      log.e(e);
    }
    return remoteConfig.getString(RemoteConfigKeys.enforcedVersion);
  }

  @override
  Future<String> get currentVersionRaw async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  @override
  Future<String> get currentBuildNumber async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.buildNumber;
  }

  @override
  Future<bool> get needsUpdate async {
    final List<int>? currentVersion = await currentVersionRaw.then((value) {
      log.i('Current Version - $value');
      if (FlavorConfig.isDevelopment()) value = value.replaceAll("-dev", "");
      return value.split('.').map((number) => int.parse(number)).toList();
    });
    final List<int>? enforcedVersion = await enforcedVersionRaw.then((value) {
      log.i('Enforced Version - $value');
      return value?.split('.').map((number) => int.parse(number)).toList();
    });
    for (int i = 0; i < 3; i++) {
      if ((enforcedVersion?[i] ?? 0) < (currentVersion?[i] ?? 0)) return false;
      if ((enforcedVersion?[i] ?? 0) > (currentVersion?[i] ?? 0)) return true;
    }
    return false;
  }
}
