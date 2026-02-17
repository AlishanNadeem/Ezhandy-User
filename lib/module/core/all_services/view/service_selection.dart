import 'package:ezhandy_user/utils/app_dialogs.dart';
import 'package:ezhandy_user/utils/app_padding.dart';
import 'package:ezhandy_user/utils/routes/app_navigation.dart';
import 'package:ezhandy_user/utils/routes/app_route.dart';
import 'package:ezhandy_user/widgets/Container/custom_container.dart';
import 'package:ezhandy_user/widgets/button_widgets/custom_button.dart';
import 'package:ezhandy_user/widgets/logo_and_backgrounds/background.dart';
import 'package:ezhandy_user/widgets/profile_widget/user_image_widget.dart';
import 'package:ezhandy_user/widgets/text_fields/custom_text_field.dart';
import 'package:ezhandy_user/widgets/text_widgets/terms_privacy_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/utils/app_strings.dart';
import 'package:ezhandy_user/utils/asset_path.dart';
import 'package:ezhandy_user/widgets/Slideable/slideable.dart';
import 'package:ezhandy_user/widgets/dropdown/custom_dropdown.dart';
import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';

class ServiceSelection extends StatefulWidget {
  // String? serviceName;
  ServiceSelection({super.key});

  @override
  State<ServiceSelection> createState() => _ServiceSelectionState();
}

class _ServiceSelectionState extends State<ServiceSelection> {
  String? primaryServiceValue;
  String? secondaryServiceValue;
  String? filterStartValue;
  var serviceList = ["Service 1", "Service 2", "Service 3"];

  // String? filterStartValue;

  // bool isLike=false;
  
  @override
  void initState() {
   primaryServiceValue="Service 1";
    // TODO: implement initState
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
        leading: AssetPath.backIcon,
        onclickLead: () {
          Get.back();
        },
        title: AppStrings.serviceSelection,
        appBarheight: 50,
        child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppPadding.padding12),
            child: Column(children: [
              20.verticalSpace,
              CustomText(
                  text: AppStrings.primaryService,
                  color: AppColors.orange,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp),
              20.verticalSpace,
              primaryServiceDropDown(),
              20.verticalSpace,
              CustomText(
                  text: AppStrings.secondaryService,
                  color: AppColors.orange,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp),
              20.verticalSpace,
              secondaryServiceDropDown(),
              20.verticalSpace,
              noteWidget(),
              20.verticalSpace,
              btnWidget(context),
            ])));
  }

  Widget primaryServiceDropDown() {
    return CustomDropDown2(
      // width: 110.w, // 👈 Controls button width
      dropDownWidth: 0.95.sw, // 👈 Controls dropdown menu width
      dropDownData: serviceList,
      borderColor: AppColors.greyBorder, borderRadius: 10.r,

      hintText: AppStrings.selectService,
      dropdownValue: primaryServiceValue,
      dropdownListColor: AppColors.white,
      hintTextColor: AppColors.black,
      onChanged: (value) {
        setState(() {
          primaryServiceValue = value.toString();
        });
      },
    );
  }

  Widget secondaryServiceDropDown() {
    return CustomDropDown2(
      // width: 110.w, // 👈 Controls button width
      dropDownWidth: 0.95.sw, // 👈 Controls dropdown menu width
      dropDownData: serviceList,
      borderColor: AppColors.greyBorder,
      hintText: AppStrings.selectService,
      dropdownValue: secondaryServiceValue,
      borderRadius: 10.r,
      dropdownListColor: AppColors.white,
      hintTextColor: AppColors.black,
      onChanged: (value) {
        setState(() {
          secondaryServiceValue = value.toString();
        });
      },
    );
  }

  CustomButton btnWidget(BuildContext context) {
    return CustomButton(
      text: AppStrings.next,
      onclick: () {
        AppNavigation.navigateTo(
          context,
          AppRoutes.chooseYourPaymentMethodScreenRoute,
        );
      },
    );
  }

  Text noteWidget() {
    return Text.rich(
      TextSpan(
        style: TextStyle(
            color: AppColors.orange,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500),
        text: "Note: ",
        children: [
          TextSpan(
              style: const TextStyle(
                color: AppColors.black,
                // fontFamily: AppStrings.mon0tserrat,
                // fontWeight: FontWeight.bold,
                // fontStyle: FontStyle.italic,
                // fontSize: 14,
                // decoration: TextDecoration.underline
              ),
              text: AppStrings.discussAndConfirmDetails),
        ],
      ),
    );
  }
}
