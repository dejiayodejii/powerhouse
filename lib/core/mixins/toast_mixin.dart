import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:powerhouse/ui/constants/_constants.dart';

class ToastMixin {
  static final scaffoldkey = GlobalKey<ScaffoldMessengerState>();

  void showSuccessToast(String message) {
    showToastWidget(toastWidget(AppColors.green, message));
  }

  void showFailureToast(String message) {
    showToastWidget(toastWidget(AppColors.red, message));
  }

  void showInfoToast(String message){
    showToastWidget(toastWidget(AppColors.darkPink, message));
  }

  Widget toastWidget(Color color, String message) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.all(15.sp),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.r),
      ),
      margin: EdgeInsets.only(
        bottom: media.height - kToolbarHeight * 4,
        left: 20.w,
        right: 20.w,
      ),
      child: Text(message),
    );
  }

  Size get media => MediaQuery.of(scaffoldkey.currentContext!).size;
}
