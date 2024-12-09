import 'package:domainchat/app/views/domain_screen.dart';
import 'package:domainchat/app/views/registration_screen.dart';
import 'package:domainchat/app/views/sigin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../helpers/space_helper.dart';
import '../widgets/commons.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommonComponents.customContainer(
        decoration:const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.black,
              Colors.black87,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(),
                CommonComponents.customContainer(
                  height: 120.h,
                  width: 120.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.chat_bubble_outline,
                    size: 60.sp,
                    color: Colors.blue,
                  ),
                ),
                SpaceHelper.verticalSpace50,
                CommonComponents.headingText(
                  text: 'Welcome to DoMail',
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  textAlign: TextAlign.center,
                ),
                SpaceHelper.verticalSpace15,
                CommonComponents.customText(
                  text: 'Connect with friends and family securely',
                  fontSize: 16.sp,
                  color: Colors.white.withOpacity(0.8),
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                CommonComponents.primaryButton(
                  onPressed: () {
                    Get.offAll(const SignInPage());
                  },
                  text: 'Sign In',
                  backgroundColor: Colors.white,
                  textColor: Colors.blue[800],
                ),
                // SpaceHelper.verticalSpace15,
                // CommonComponents.outlineButton(
                //   onPressed: () {
                //     Get.offAll(const CreateAccountPage());
                //   },
                //   text: 'Create Account',
                //   borderColor: Colors.white,
                //   textColor: Colors.white,
                // ),
                SpaceHelper.verticalSpace10,
                CommonComponents.outlineButton(
                  onPressed: () {
                    Get.offAll(const DomainListScreen());
                  },
                  text: 'Continue',
                  borderColor: Colors.white,
                  textColor: Colors.white,
                ),
                SpaceHelper.verticalSpace30,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
