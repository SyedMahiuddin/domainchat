import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../helpers/color_helper.dart';

class Toast {
  static void show({
    required String message,
    bool isError = false,
    Duration? duration,
    IconData? icon,
  }) {
    Get.closeAllSnackbars();
    Get.snackbar(
      '',
      '',
      snackPosition: SnackPosition.TOP,
      backgroundColor: isError
          ? ColorHelper.red.withOpacity(0.9)
          : ColorHelper.primary.withOpacity(0.9),
      margin: EdgeInsets.all(16.w),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      borderRadius: 12.r,
      duration: duration ?? const Duration(seconds: 3),
      messageText: Row(
        children: [
          Icon(
            icon ?? (isError ? Icons.error_outline : Icons.check_circle_outline),
            color: ColorHelper.whiteColor,
            size: 20.sp,
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: ColorHelper.whiteColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      titleText: const SizedBox.shrink(),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutCubic,
      reverseAnimationCurve: Curves.easeInCubic,
      onTap: (_) => Get.closeAllSnackbars(),
    );
  }

  static void success(String message) {
    show(
      message: message,
      isError: false,
      icon: Icons.check_circle_outline,
    );
  }

  static void error(String message) {
    show(
      message: message,
      isError: true,
      icon: Icons.error_outline,
    );
  }

  static void warning(String message) {
    show(
      message: message,
      icon: Icons.warning_amber_rounded,
    );
  }

  static void info(String message) {
    show(
      message: message,
      icon: Icons.info_outline,
    );
  }

  static void loading(String message) {
    Get.closeAllSnackbars();
    Get.snackbar(
      '',
      '',
      snackPosition: SnackPosition.TOP,
      backgroundColor: ColorHelper.secondary.withOpacity(0.9),
      margin: EdgeInsets.all(16.w),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      borderRadius: 12.r,
      duration: const Duration(seconds: 30),
      messageText: Row(
        children: [
          SizedBox(
            height: 20.sp,
            width: 20.sp,
            child: CircularProgressIndicator(
              strokeWidth: 2.w,
              valueColor: AlwaysStoppedAnimation<Color>(ColorHelper.whiteColor),
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: ColorHelper.whiteColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      titleText: const SizedBox.shrink(),
      isDismissible: false,
    );
  }
}
