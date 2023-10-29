import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:powerhouse/ui/constants/_constants.dart';

class AppTextStyles {
  static TextStyle kTextStyle(
    double size, {
    Color? color,
    FontWeight? weight,
    double? height,
    double? spacing,
    FontStyle? style,
  }) {
    return GoogleFonts.roboto(
      fontSize: size.sm,
      color: color ?? AppColors.black,
      fontWeight: weight,
      height: height == null ? null : height / size,
      letterSpacing: spacing,
    );
  }

  static TextStyle heading1 = GoogleFonts.roboto(
    fontSize: 40.sm,
    color: AppColors.black,
    fontWeight: FontWeight.w700,
    height: 1,
  );

  static TextStyle regularBody = GoogleFonts.roboto(
    fontSize: 16.sm,
    color: AppColors.black,
    fontWeight: FontWeight.w500,
    height: 1.5,
  );

  static TextStyle semibold22 = GoogleFonts.roboto(
    fontSize: 22.sm,
    color: AppColors.black,
    fontWeight: FontWeight.w600,
    height: 1.172,
  );

  static TextStyle light20 = GoogleFonts.roboto(
    fontSize: 20.sm,
    color: AppColors.black,
    fontWeight: FontWeight.w300,
    height: 1.172,
  );

  static TextStyle whiteBold16 = GoogleFonts.roboto(
    fontSize: 16.sm,
    color: AppColors.white,
    fontWeight: FontWeight.bold,
    height: 1.172,
  );

  static TextStyle whiteLight15 = GoogleFonts.roboto(
    fontSize: 15.sm,
    color: AppColors.white,
    fontWeight: FontWeight.w300,
    height: 1.172,
  );

  static TextStyle bold14 = GoogleFonts.roboto(
    fontSize: 14.sm,
    color: AppColors.black,
    fontWeight: FontWeight.bold,
    height: 1.172,
  );

  static TextStyle light12 = GoogleFonts.roboto(
    fontSize: 12.sm,
    color: AppColors.black,
    fontWeight: FontWeight.w300,
    height: 1.172,
  );
}
