import 'package:domainchat/app/controlers/domain_controller.dart';
import 'package:domainchat/app/views/sigin_screen.dart';
import 'package:domainchat/app/views/welcome_screen.dart';
import 'package:domainchat/app/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../helpers/color_helper.dart';
import '../helpers/space_helper.dart';
import '../widgets/commons.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final DomainController domainController =Get.put(DomainController());

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isLoading = false;
  bool _acceptTerms = false;
  bool registrationDone = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleSignUp() async{
    if (_validateForm()) {
      setState(() => _isLoading = true);
      await domainController.createAccount(_emailController.text, _passwordController.text);
      Future.delayed(const Duration(seconds: 1), () {
        setState(() => _isLoading = false);
      });
      if(domainController.registrationDone.value){
        Toast.success("Account created successfully");
        Get.offAll(const WelcomeScreen());
      }
      else{
        Toast.error("Try Again");
      }
    }
    else{
      Toast.error("Fill all the required fields");
    }
  }

  bool _validateForm() {
    if(_usernameController.text.isNotEmpty && _passwordController.text.isNotEmpty && (_passwordController.text==_confirmPasswordController.text))
    {
      return true;
    }
    else
      {
        return false;
      }

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
                text: "Create Account",
                fontSize: 28,
              ),
              SpaceHelper.verticalSpace10,
              CommonComponents.customText(
                text: "Fill in your details to get started",
                color: ColorHelper.greyColor,
                fontSize: 16,
              ),
              SpaceHelper.verticalSpace40,
              CommonComponents.inputField(
                controller: _usernameController,
                hintText: "Username",
                onChanged: (v){
                  setState(() {
                    _emailController.text="${_usernameController.text}@${domainController.selectedDomain!.domain!}";

                  });
                 },
                keyboardType: TextInputType.text,
                prefixIcon: Icon(
                  Icons.alternate_email,
                  color: ColorHelper.greyColor,
                  size: 20.sp,
                ),
              ),
              SpaceHelper.verticalSpace20,

              CommonComponents.inputField(
                controller: _emailController,
                hintText: "Email",
                keyboardType: TextInputType.emailAddress,
                enabled: false,
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
              SpaceHelper.verticalSpace20,

              CommonComponents.inputField(
                controller: _confirmPasswordController,
                hintText: "Confirm Password",
                obscureText: !_isConfirmPasswordVisible,
                prefixIcon: Icon(
                  Icons.lock_outline,
                  color: ColorHelper.greyColor,
                  size: 20.sp,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isConfirmPasswordVisible
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: ColorHelper.greyColor,
                    size: 20.sp,
                  ),
                  onPressed: () {
                    setState(() {
                      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                    });
                  },
                ),
              ),
              SpaceHelper.verticalSpace20,

              Row(
                children: [
                  SizedBox(
                    height: 24.h,
                    width: 24.w,
                    child: Checkbox(
                      value: _acceptTerms,
                      onChanged: (value) {
                        setState(() {
                          _acceptTerms = value ?? false;
                        });
                      },
                      fillColor: MaterialStateProperty.resolveWith<Color>(
                            (states) => states.contains(MaterialState.selected)
                            ? ColorHelper.primary
                            : ColorHelper.greyColor,
                      ),
                      checkColor: ColorHelper.whiteColor,
                    ),
                  ),
                  SpaceHelper.horizontalSpace10,
                  Expanded(
                    child: Wrap(
                      children: [
                        CommonComponents.customText(
                          text: "I agree to the ",
                          fontSize: 14,
                          color: ColorHelper.greyColor,
                        ),
                        GestureDetector(
                          onTap: () {
                          },
                          child: CommonComponents.customText(
                            text: "Terms & Conditions",
                            fontSize: 14,
                            color: ColorHelper.whiteColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        CommonComponents.customText(
                          text: " and ",
                          fontSize: 14,
                          color: ColorHelper.greyColor,
                        ),
                        GestureDetector(
                          onTap: () {
                          },
                          child: CommonComponents.customText(
                            text: "Privacy Policy",
                            fontSize: 14,
                            color: ColorHelper.whiteColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SpaceHelper.verticalSpace30,

              CommonComponents.primaryButton(

                text: "Create Account",
                onPressed: _handleSignUp,
                isLoading: _isLoading,
              ),
              SpaceHelper.verticalSpace30,

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CommonComponents.customText(
                    text: "Already have an account? ",
                    fontSize: 14,
                    color: ColorHelper.greyColor,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.offAll(const SignInPage());
                    },
                    child: CommonComponents.customText(
                      text: "Sign In",
                      fontSize: 14,
                      color: ColorHelper.whiteColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SpaceHelper.verticalSpace20,
            ],
          ),
        ),
      ),
    );
  }
}