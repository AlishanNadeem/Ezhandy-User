import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/utils/app_padding.dart';
import 'package:ezhandy_user/utils/app_strings.dart';
import 'package:ezhandy_user/utils/asset_path.dart';
import 'package:ezhandy_user/utils/routes/app_navigation.dart';
import 'package:ezhandy_user/widgets/button_widgets/custom_button.dart';
import 'package:ezhandy_user/widgets/logo_and_backgrounds/background.dart';
import 'package:ezhandy_user/widgets/rating_star/rating_star.dart';
import 'package:ezhandy_user/widgets/text_fields/custom_text_field.dart';
import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';

class ReportIssue extends StatefulWidget {
  ReportIssue({super.key});

  @override
  State<ReportIssue> createState() => _ReportIssueState();
}

class _ReportIssueState extends State<ReportIssue> {
  TextEditingController controller = TextEditingController();
  // double initialRating = 0.0;
  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
        // is_registration: widget.isRegistration,
        leading: AssetPath.backIcon,
        onclickLead: () {
          Get.back();
        },
        // appBarheight: 50.h,
        title: AppStrings.reportIssue,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.padding12),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.verticalSpace,
             
              CustomText(
                text: AppStrings.reportIssue,
                fontSize: 18.sp,
              ),
              10.verticalSpace,
              textField(),
              10.verticalSpace,
              // Spacer(),
              buttonWidget(),
              25.verticalSpace,
            ],
          ),
        ));
  }


  Widget buttonWidget() {
    return CustomButton(
      text: AppStrings.submit,
      onclick: () {
        AppNavigation.navigatorPop(context);
      },
    );
  }

  Widget textField() {
    return CustomTextField(
      borderRadius: 15.r,
      // fillColor: AppColors.fieldColor,
      fontColor: AppColors.black,
      hintColor: AppColors.grey,
      prefixIconColor: AppColors.green,

      divider: false,
      label: false,
      lines: 10,
      hint: AppStrings.saySomeThing,
      inputFormatters: [LengthLimitingTextInputFormatter(275)],
      controller: controller,
    );
  }
}
