import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:powerhouse/services/_services.dart';

mixin DialogAndSheetMixin {
  Future<T?> showAppBottomSheet<T>(Widget child) async {
    final _nav = NavigationService.instance;
    return showModalBottomSheet(
      context: _nav.navigatorKey.currentContext!,
      enableDrag: true,
      isScrollControlled: true,
      elevation: 0,
      isDismissible: true,
      useRootNavigator: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.r),
        ),
      ),
      builder: (context) => child,
    );
  }

  Future<T?> showAppDialog<T>(Widget child) async {
    final _nav = NavigationService.instance;
    return showDialog(
      context: _nav.navigatorKey.currentContext!,
      useRootNavigator: true,
      useSafeArea: true,
      builder: (context) => child,
    );
  }
}
