import 'package:domainchat/app/controlers/domain_controller.dart';
import 'package:domainchat/app/views/message_screen.dart';
import 'package:domainchat/app/views/registration_screen.dart';
import 'package:domainchat/app/views/welcome_screen.dart';
import 'package:domainchat/app/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../helpers/color_helper.dart';
import '../helpers/space_helper.dart';
import '../widgets/commons.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final DomainController domainController=Get.put(DomainController());
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorHelper.bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SpaceHelper.verticalSpace20,
              GestureDetector(
                onTap: () => Get.offAll(const WelcomeScreen()),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: ColorHelper.whiteColor,
                  size: 24.sp,
                ),
              ),
              SpaceHelper.verticalSpace30,
              CommonComponents.headingText(
                text: "Welcome Back!",
                fontSize: 28,
              ),
              SpaceHelper.verticalSpace10,
              CommonComponents.customText(
                text: "Sign in to continue",
                color: ColorHelper.greyColor,
                fontSize: 16,
              ),
              SpaceHelper.verticalSpace40,
              CommonComponents.inputField(
                controller: _emailController,
                hintText: "Email",
                keyboardType: TextInputType.emailAddress,
                prefixIcon: Icon(
                  Icons.email_outlined,
                  color: ColorHelper.greyColor,
                  size: 20.sp,
                ),
              ),
              SpaceHelper.verticalSpace20,
              CommonComponents.inputField(
                controller: _passwordController,
                hintText: "Password",
                obscureText: !_isPasswordVisible,
                prefixIcon: Icon(
                  Icons.lock_outline,
                  color: ColorHelper.greyColor,
                  size: 20.sp,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                    color: ColorHelper.greyColor,
                    size: 20.sp,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
              SpaceHelper.verticalSpace15,
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                  },
                  child: CommonComponents.customText(
                    text: "Forgot Password?",
                    fontSize: 14,
                    color: ColorHelper.whiteColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SpaceHelper.verticalSpace30,
              CommonComponents.primaryButton(
                text: "Sign In",
                onPressed: () async{
                  setState(() => _isLoading = true);
                  await domainController.login(_emailController.text, _passwordController.text);
                  Future.delayed(const Duration(seconds: 1), () {
                    setState(() => _isLoading = false);
                  });
                  if(domainController.loginDone.value)
                    {
                      Toast.success("Login Successfully ");
                      Get.offAll(const MessageScreen());
                    }
                  else{
                    Toast.error("Login Failed");
                  }
                },
                isLoading: _isLoading,
              ),
              SpaceHelper.verticalSpace30,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CommonComponents.customText(
                    text: "Don't have an account? ",
                    fontSize: 14,
                    color: ColorHelper.greyColor,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.offAll(const CreateAccountPage());
                    },
                    child: CommonComponents.customText(
                      text: "Sign Up",
                      fontSize: 14,
                      color: ColorHelper.whiteColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}