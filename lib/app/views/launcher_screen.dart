import 'package:domainchat/app/helpers/color_helper.dart';
import 'package:domainchat/app/views/message_screen.dart';
import 'package:domainchat/app/views/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LauncherScreen extends StatefulWidget {
  const LauncherScreen({super.key});

  @override
  State<LauncherScreen> createState() => _LauncherScreenState();
}

class _LauncherScreenState extends State<LauncherScreen> {
  @override
  void initState() {
checkLog();
    super.initState();
  }
  Future<void> checkLog()async{
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('user_token');
    if(token!=null && token!="")
      {
        Get.offAll(const MessageScreen());
      }
    else{
      Get.offAll(const WelcomeScreen());
    }
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: ColorHelper.bgColor,
      body:  Center(child: Icon(Icons.email_outlined,size: 30.sp, color: Colors.white,)),
    );
  }
}
