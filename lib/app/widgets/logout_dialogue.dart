import 'package:domainchat/app/views/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../helpers/color_helper.dart';

class LogoutDialog {
  static void show(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.scale,
      title: 'Logout',
      titleTextStyle: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
        color: ColorHelper.whiteColor,
      ),
      desc: 'Are you sure you want to logout?',
      descTextStyle: TextStyle(
        fontSize: 14.sp,
        color: ColorHelper.whiteColor,
      ),
      dialogBackgroundColor: ColorHelper.secondary,
      btnOkText: 'Logout',
      btnOkColor: ColorHelper.red,
      btnCancelColor: ColorHelper.greyColor,
      buttonsBorderRadius: BorderRadius.circular(8.r),
      buttonsTextStyle: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        color: ColorHelper.whiteColor,
      ),
      padding: EdgeInsets.all(16.w),
      width: 300.w,
      dismissOnTouchOutside: true,
      btnOkOnPress: () async{
        final prefs = await SharedPreferences.getInstance();
        await prefs.clear();
        Get.offAll(const WelcomeScreen());
      },
      btnCancelOnPress: () {
      },
    ).show();
  }
}

void showLogoutDialog(BuildContext context) {
  LogoutDialog.show(context);
}

Widget buildLogoutButton(BuildContext context) {
  return IconButton(
    icon: Icon(
      Icons.logout,
      color: ColorHelper.whiteColor,
      size: 24.sp,
    ),
    onPressed: () => LogoutDialog.show(context),
  );
}