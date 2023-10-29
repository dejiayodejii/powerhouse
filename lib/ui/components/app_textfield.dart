// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:powerhouse/ui/constants/_constants.dart';

class AppTextField extends StatelessWidget {
  final String? label;
  final String? hint;
  final String? initialValue;
  bool obscureText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String?)? onChanged;
  final void Function()? onEditingComplete;
  final void Function()? onTap;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final Widget? suffix;
  final Widget? prefix;
  final bool readOnly;
  final bool expands;
  final int? minLines, maxLines, maxLength;
  final bool enabled;
  final Color? fillColor;
  final TextAlign? textAlign;
  final TextAlignVertical? textAlignVertical;
  final List<TextInputFormatter>? inputFormatters;

  AppTextField({
    Key? key,
    this.label,
    this.hint,
    this.controller,
    this.validator,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.suffix,
    this.obscureText = false,
    this.prefix,
    this.initialValue,
    this.readOnly = false,
    this.expands = false,
    this.minLines,
    this.maxLines,
    this.maxLength,
    this.enabled = true,
    this.fillColor,
    this.onChanged,
    this.onEditingComplete,
    this.onTap,
    this.textAlign,
    this.textAlignVertical,
    this.inputFormatters,
  })  : assert(initialValue == null || controller == null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      validator: validator,
      onChanged: onChanged,
      onTap: onTap,
      keyboardType: keyboardType,
      cursorColor: AppColors.darkGrey,
      textCapitalization: textCapitalization,
      obscureText: obscureText,
      readOnly: readOnly,
      expands: expands,
      maxLines: maxLines,
      minLines: minLines,
      maxLength: maxLength,
      inputFormatters: inputFormatters,
      textAlignVertical: textAlignVertical ?? TextAlignVertical.center,
      onEditingComplete:
          onEditingComplete ?? () => FocusScope.of(context).nextFocus(),
      style: AppTextStyles.kTextStyle(
        18,
        height: 21.09,
        weight: FontWeight.w300,
        color: AppColors.hintColor,
      ),
      textAlign: textAlign ?? TextAlign.center,
      autovalidateMode: AutovalidateMode.disabled,
      decoration: kDecoration.copyWith(
        hintText: hint,
        labelText: label,
        suffixIcon: suffix,
        prefixIcon: prefix,
        enabled: enabled,
        filled: true,
        fillColor: fillColor ?? AppColors.white,
      ),
    );
  }
}

final kDecoration = InputDecoration(
  isDense: true,
  labelStyle: AppTextStyles.kTextStyle(
    16,
    height: 19.2,
    weight: FontWeight.w500,
    color: AppColors.hintColor,
  ),
  floatingLabelStyle: AppTextStyles.kTextStyle(
    12,
    height: 14.4,
    weight: FontWeight.bold,
    color: AppColors.black,
  ),
  hintStyle: AppTextStyles.kTextStyle(
    20,
    height: 23.4,
    weight: FontWeight.w300,
    color: AppColors.hintColor,
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12.r),
    borderSide: BorderSide.none,
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12.r),
    borderSide: BorderSide.none,
  ),
  disabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12.r),
    borderSide: BorderSide.none,
  ),
  errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide.none),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12.r),
    borderSide: BorderSide.none,
  ),
);

final kBorderDecoration = InputDecoration(
  isDense: true,
  labelStyle: AppTextStyles.kTextStyle(
    18,
    height: 19.2,
    weight: FontWeight.w300,
    color: AppColors.hintColor,
  ),
  floatingLabelStyle: AppTextStyles.kTextStyle(
    14,
    weight: FontWeight.bold,
    color: AppColors.black,
  ),
  hintStyle: AppTextStyles.kTextStyle(
    18,
    height: 23.4,
    weight: FontWeight.w300,
    color: AppColors.hintColor,
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12.r),
    borderSide: const BorderSide(
      color: AppColors.lightGrey,
      width: 1,
    ),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12.r),
    borderSide: const BorderSide(
      color: AppColors.lightGrey,
      width: 1,
    ),
  ),
  disabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12.r),
    borderSide: const BorderSide(
      color: AppColors.lightGrey,
      width: 1,
    ),
  ),
  errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: const BorderSide(
        color: AppColors.lightGrey,
        width: 1,
      )),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12.r),
    borderSide: const BorderSide(
      color: AppColors.lightGrey,
      width: 1,
    ),
  ),
);

class BorderTextField extends StatelessWidget {
  final String? label;
  final String? hint;
  final String? initialValue;
  bool obscureText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String?)? onChanged;
  final void Function()? onEditingComplete;
  final void Function()? onTap;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final Widget? suffix;
  final Widget? prefix;
  final bool readOnly;
  final bool expands;
  final int? minLines, maxLines, maxLength;
  final bool enabled;
  final Color? fillColor;
  final TextAlign? textAlign;
  final TextAlignVertical? textAlignVertical;
  final List<TextInputFormatter>? inputFormatters;

  BorderTextField({
    Key? key,
    this.label,
    this.hint,
    this.controller,
    this.validator,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.suffix,
    this.obscureText = false,
    this.prefix,
    this.initialValue,
    this.readOnly = false,
    this.expands = false,
    this.minLines,
    this.maxLines,
    this.maxLength,
    this.enabled = true,
    this.fillColor,
    this.onChanged,
    this.onEditingComplete,
    this.onTap,
    this.textAlign,
    this.textAlignVertical,
    this.inputFormatters,
  })  : assert(initialValue == null || controller == null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      validator: validator,
      onChanged: onChanged,
      onTap: onTap,
      keyboardType: keyboardType,
      cursorColor: AppColors.darkGrey,
      textCapitalization: textCapitalization,
      obscureText: obscureText,
      readOnly: readOnly,
      expands: expands,
      maxLines: maxLines,
      minLines: minLines,
      maxLength: maxLength,
      inputFormatters: inputFormatters,
      textAlignVertical: textAlignVertical ?? TextAlignVertical.center,
      onEditingComplete:
          onEditingComplete ?? () => FocusScope.of(context).nextFocus(),
      style: AppTextStyles.kTextStyle(
        18,
        weight: FontWeight.normal,
        color: AppColors.black.withOpacity(0.65),
      ),
      textAlign: textAlign ?? TextAlign.center,
      autovalidateMode: AutovalidateMode.disabled,
      decoration: kBorderDecoration.copyWith(
        hintText: hint,
        labelText: label,
        suffixIcon: suffix,
        prefixIcon: prefix,
        enabled: enabled,
        contentPadding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 18.h),
        filled: true,
        fillColor:
            enabled ? (fillColor ?? AppColors.white) : AppColors.veryLightGrey,
      ),
    );
  }
}
