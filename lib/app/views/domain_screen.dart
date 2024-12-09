import 'dart:developer';

import 'package:domainchat/app/views/registration_screen.dart';
import 'package:domainchat/app/views/welcome_screen.dart';
import 'package:domainchat/app/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../controlers/domain_controller.dart';
import '../helpers/color_helper.dart';
import '../helpers/space_helper.dart';
import '../widgets/commons.dart';
import '../models/domain_model.dart';

class DomainListScreen extends StatefulWidget {
  const DomainListScreen({super.key});

  @override
  State<DomainListScreen> createState() => _DomainListScreenState();
}

class _DomainListScreenState extends State<DomainListScreen> {

  final DomainController domainController = Get.put(DomainController());

  Widget _buildLoadingShimmer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Shimmer.fromColors(
          baseColor: ColorHelper.secondary,
          highlightColor: ColorHelper.primary.withOpacity(0.3),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 16.h,
            ),
            decoration: BoxDecoration(
              color: ColorHelper.secondary,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 120.w,
                  height: 16.h,
                  decoration: BoxDecoration(
                    color: ColorHelper.whiteColor,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: ColorHelper.whiteColor,
                  size: 24.sp,
                ),
              ],
            ),
          ),
        ),
        SpaceHelper.verticalSpace10,
        CommonComponents.customText(
          text: "Loading domains...",
          color: ColorHelper.greyColor,
          fontSize: 14,
        ),
      ],
    );
  }

  Widget _buildDropdown() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 4.h,
      ),
      decoration: BoxDecoration(
        color: ColorHelper.secondary,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<DomainModel>(
          value: domainController.selectedDomain,
          isExpanded: true,
          hint: Text(
            'Select a domain',
            style: TextStyle(
              color: ColorHelper.greyColor,
              fontSize: 14.sp,
            ),
          ),
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: ColorHelper.whiteColor,
            size: 24.sp,
          ),
          dropdownColor: ColorHelper.secondary,
          items: domainController.domainList.map((DomainModel domain) {
            return DropdownMenuItem<DomainModel>(
              value: domain,
              child: Text(
                domain.domain!,
                style: TextStyle(
                  color: ColorHelper.whiteColor,
                  fontSize: 14.sp,
                ),
              ),
            );
          }).toList(),
          onChanged: (DomainModel? newValue) {
            setState(() {
              domainController.selectedDomain = newValue;
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorHelper.bgColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SpaceHelper.verticalSpace20,
              // Back Button
              GestureDetector(
                onTap: () => Get.offAll(const WelcomeScreen()),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: ColorHelper.whiteColor,
                  size: 24.sp,
                ),
              ),
              SpaceHelper.verticalSpace30,
              // Header
              CommonComponents.headingText(
                text: "Select Domain",
                fontSize: 28,
              ),
              SpaceHelper.verticalSpace10,
              CommonComponents.customText(
                text: "Choose a domain for your email address",
                color: ColorHelper.greyColor,
                fontSize: 16,
              ),
              SpaceHelper.verticalSpace40,

              Obx(() => domainController.domainList.isEmpty
                  ? _buildLoadingShimmer()
                  : _buildDropdown()),

              const Spacer(),


              CommonComponents.primaryButton(
                text: "Continue",
                onPressed:  () {
                  if(domainController.selectedDomain==null)
                    {
                      Toast.error("Select a domain to continue");
                    }
                  else{
                    Get.to(const CreateAccountPage());
                    log('Selected domain: ${domainController.selectedDomain?.domain}');
                  }

                },
                backgroundColor: domainController.selectedDomain == null
                    ? ColorHelper.greyColor
                    : ColorHelper.primary,
              ),
              SpaceHelper.verticalSpace30,
            ],
          ),
        ),
      ),
    );
  }
}