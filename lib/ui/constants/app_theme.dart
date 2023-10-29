import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:powerhouse/ui/constants/_constants.dart';

class AppTheme {
  static final theme = ThemeData(
    primarySwatch: Colors.pink,
    backgroundColor: AppColors.white,
    scaffoldBackgroundColor: AppColors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.white,
      toolbarHeight: 60.h,
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.pink,
    ),
    fontFamily: GoogleFonts.roboto().fontFamily,
    textTheme: TextTheme(
      headline1: AppTextStyles.heading1,
      bodyText1: AppTextStyles.regularBody,
    ),
  );
}
