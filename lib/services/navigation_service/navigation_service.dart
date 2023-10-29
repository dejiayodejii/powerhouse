import 'package:flutter/material.dart';

import 'i_navigation_service.dart';

// final navKey = GlobalKey<NavigatorState>();

class NavigationService extends INavigationService {
  static NavigationService instance = NavigationService._();
  NavigationService._();
  
  @override
  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Future<T?>? navigateTo<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) {
    return navigatorKey.currentState?.pushNamed(
      routeName,
      arguments: arguments,
    );
  }

  @override
  Future<T?>? replaceWith<T extends Object?, TO extends Object?>(
    String routeName, {
    TO? result,
    Object? arguments,
  }) {
    return navigatorKey.currentState?.pushReplacementNamed(
      routeName,
      result: result,
      arguments: arguments,
    );
  }

  @override
  Future<T?>? replaceAll<T extends Object?>(
    String routeName,
    bool Function(Route<dynamic>) predicate, {
    Object? arguments,
  }) {
    return navigatorKey.currentState?.pushNamedAndRemoveUntil(
      routeName,
      predicate,
      arguments: arguments,
    );
  }

  @override
  void pop<T extends Object?>([T? result]) {
    return navigatorKey.currentState?.pop(result);
  }

  @override
  void popRepeated<T extends Object?>(int count, [T? result]) {
    for (var i = 0; i < count; i++) {
      navigatorKey.currentState?.pop();
    }
  }
}
