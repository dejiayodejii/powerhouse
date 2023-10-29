import 'flavors_enum.dart';

class FlavorConfig {
  final Flavor flavor;
  final String appName;

  static FlavorConfig? _instance;

  factory FlavorConfig({
    required Flavor flavor,
    required String appName,
  }) {
    _instance ??= FlavorConfig._internal(flavor, appName);
    return _instance!;
  }

  FlavorConfig._internal(this.flavor, this.appName);

  static FlavorConfig get instance {
    return _instance!;
  }

  static bool isProduction() => _instance!.flavor == Flavor.prod;
  static bool isDevelopment() => _instance!.flavor == Flavor.dev;
}
