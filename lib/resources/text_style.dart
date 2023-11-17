import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static TextStyle header2Text({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    double? height,
    TextDecoration? textDecoration,
    BuildContext? context,
  }) =>
      GoogleFonts.karla(
          color: color ?? Theme.of(context!).colorScheme.primary,
          fontSize: fontSize ?? 12.sp,
          fontWeight: fontWeight ?? FontWeight.w500,
          decoration: textDecoration,
          height: height ?? 1.1.sp);
  static TextStyle header1Text({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    double? height,
    TextDecoration? textDecoration,
    BuildContext? context,
  }) =>
      GoogleFonts.karla(
          color: color ?? Theme.of(context!).colorScheme.primary,
          fontSize: fontSize ?? 14.sp,
          fontWeight: fontWeight ?? FontWeight.w600,
          decoration: textDecoration,
          height: height ?? 1.1.sp);

  static TextStyle headerText({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    double? height,
    TextDecoration? textDecoration,
    BuildContext? context,
  }) =>
      GoogleFonts.karla(
          color: color ?? Theme.of(context!).colorScheme.primary,
          fontSize: fontSize ?? 40.sp,
          fontWeight: fontWeight ?? FontWeight.w600,
          decoration: textDecoration,
          height: height ?? 1.1.sp);
}
