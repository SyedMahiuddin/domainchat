import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../helpers/color_helper.dart';

class CommonComponents {
  static Text customText({
    required String text,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    double? letterSpacing,
    TextDecoration? decoration,
  }) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        color: color ?? ColorHelper.whiteColor,
        fontSize: (fontSize ?? 14).sp,
        fontWeight: fontWeight ?? FontWeight.normal,
        letterSpacing: letterSpacing,
        decoration: decoration,
      ),
      textAlign: textAlign ?? TextAlign.left,
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  static Text headingText({
    required String text,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
  }) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        color: color ?? ColorHelper.whiteColor,
        fontSize: (fontSize ?? 24).sp,
        fontWeight: fontWeight ?? FontWeight.bold,
      ),
      textAlign: textAlign ?? TextAlign.left,
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  static Container customContainer({
    Widget? child,
    Color? color,
    double? width,
    double? height,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    BoxDecoration? decoration,
    AlignmentGeometry? alignment,
    BoxConstraints? constraints,
  }) {
    return Container(
      width: width?.w,
      height: height?.h,
      padding: padding ?? EdgeInsets.all(16.w),
      margin: margin,
      alignment: alignment,
      constraints: constraints,
      decoration: decoration ??
          BoxDecoration(
            color: color ?? ColorHelper.primary,
            borderRadius: BorderRadius.circular(12.r),
          ),
      child: child,
    );
  }

  static Container cardContainer({
    required Widget child,
    Color? color,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    double? borderRadius,
  }) {
    return Container(
      padding: padding ?? EdgeInsets.all(16.w),
      margin: margin,
      decoration: BoxDecoration(
        color: color ?? ColorHelper.secondary,
        borderRadius: BorderRadius.circular(borderRadius ?? 16.r),
        boxShadow: [
          BoxShadow(
            color: ColorHelper.bgColor.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: child,
    );
  }

  static ElevatedButton primaryButton({
    required String text,
    required VoidCallback onPressed,
    Color? backgroundColor,
    Color? textColor,
    double? width,
    double? height,
    double? fontSize,
    FontWeight? fontWeight,
    EdgeInsetsGeometry? padding,
    bool isLoading = false,
  }) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? ColorHelper.primary,
        foregroundColor: textColor ?? ColorHelper.whiteColor,
        minimumSize: Size(width?.w ?? double.infinity, height?.h ?? 50.h),
        padding: padding ?? EdgeInsets.symmetric(vertical: 16.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        elevation: 0,
      ),
      child: isLoading
          ? SizedBox(
        height: 20.h,
        width: 20.w,
        child: CircularProgressIndicator(
          color: ColorHelper.whiteColor,
          strokeWidth: 2.w,
        ),
      )
          : Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: (fontSize ?? 16).sp,
          fontWeight: fontWeight ?? FontWeight.w600,
        ),
      ),
    );
  }


  static OutlinedButton outlineButton({
    required String text,
    required VoidCallback onPressed,
    Color? borderColor,
    Color? textColor,
    double? width,
    double? height,
    double? fontSize,
    FontWeight? fontWeight,
    EdgeInsetsGeometry? padding,
    bool isLoading = false,
  }) {
    return OutlinedButton(
      onPressed: isLoading ? null : onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: textColor ?? ColorHelper.whiteColor,
        side: BorderSide(
          color: borderColor ?? ColorHelper.whiteColor,
          width: 1.w,
        ),
        minimumSize: Size(width?.w ?? double.infinity, height?.h ?? 50.h),
        padding: padding ?? EdgeInsets.symmetric(vertical: 16.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      child: isLoading
          ? SizedBox(
        height: 20.h,
        width: 20.w,
        child: CircularProgressIndicator(
          color: ColorHelper.whiteColor,
          strokeWidth: 2.w,
        ),
      )
          : Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: (fontSize ?? 16).sp,
          fontWeight: fontWeight ?? FontWeight.w600,
        ),
      ),
    );
  }

  
  static TextField inputField({
    String? hintText,
    TextEditingController? controller,
    bool obscureText = false,
    TextInputType? keyboardType,
    Widget? prefixIcon,
    Widget? suffixIcon,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
    int? maxLines = 1,
    bool readOnly = false,
    bool enabled = true,
    Color? fillColor,
  }) {
    return TextField(
      enabled: enabled,
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      maxLines: maxLines,
      readOnly: readOnly,
      style: GoogleFonts.poppins(
        color: ColorHelper.whiteColor,
        fontSize: 14.sp,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.poppins(
          color: ColorHelper.greyColor,
          fontSize: 14.sp,
        ),
        filled: true,
        fillColor: fillColor ?? ColorHelper.secondary,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            color: ColorHelper.whiteColor,
            width: 1.w,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            color: ColorHelper.red,
            width: 1.w,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 16.h,
        ),
      ),
      onChanged: onChanged,
    );
  }
}