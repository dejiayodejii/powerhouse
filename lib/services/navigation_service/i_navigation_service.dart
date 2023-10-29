import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:powerhouse/services/_services.dart';

abstract class INavigationService {
  GlobalKey<NavigatorState> get navigatorKey;

  Future<T?>? navigateTo<T extends Object?>(
    String routeName, {
    Object? arguments,
  });

  Future<T?>? replaceWith<T extends Object?, TO extends Object?>(
    String routeName, {
    TO? result,
    Object? arguments,
  });

  Future<T?>? replaceAll<T extends Object?>(
    String routeName,
    bool Function(Route<dynamic>) predicate, {
    Object? arguments,
  });

  void pop<T extends Object?>([T? result]);

  void popRepeated<T extends Object?>(int count, [T? result]);
}

final navigationService = Provider<INavigationService>(
  (_) => NavigationService.instance,
);
