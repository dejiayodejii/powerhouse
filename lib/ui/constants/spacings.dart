import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class YSpacing extends StatelessWidget {
  final double space;

  const YSpacing(this.space, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: space.h,
    );
  }
}

class XSpacing extends StatelessWidget {
  final double space;

  const XSpacing(this.space, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: space.w,
    );
  }
}
