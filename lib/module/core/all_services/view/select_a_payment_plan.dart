import 'package:ezhandy_user/utils/app_dialogs.dart';
import 'package:ezhandy_user/utils/app_padding.dart';
import 'package:ezhandy_user/utils/routes/app_navigation.dart';
import 'package:ezhandy_user/utils/routes/app_route.dart';
import 'package:ezhandy_user/widgets/Container/custom_container.dart';
import 'package:ezhandy_user/widgets/button_widgets/custom_button.dart';
import 'package:ezhandy_user/widgets/checkbox/custom_checkbox.dart';
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

class SelectAPaymentPlan extends StatefulWidget {
  // String? serviceName;
  SelectAPaymentPlan({super.key});

  @override
  State<SelectAPaymentPlan> createState() => _SelectAPaymentPlanState();
}

class _SelectAPaymentPlanState extends State<SelectAPaymentPlan> {
  String methodValue = AppStrings.payment3;

  // String? filterStartValue;

  // bool isLike=false;
  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
        leading: AssetPath.backIcon,
        onclickLead: () {
          Get.back();
        },
        title: AppStrings.selectAPaymentPlan,
        appBarheight: 50,
        child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppPadding.padding12),
            child: Column(children: [
              20.verticalSpace,
 CustomText(
                  text: AppStrings.dummylorem + ": \$500.00",
                  fontSize: 16.sp,
                  color: AppColors.orange,
                  fontWeight: FontWeight.w600),
              20.verticalSpace,
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: AppPadding.padding12),
                child: Column(
                  children: [
                    CheckBoxWidget(
                        isChecked: methodValue == AppStrings.payment3,
                        ontapCheck: () {
                          setState(() {
                            methodValue = AppStrings.payment3;
                          });
                        },
                        title: AppStrings.payment3),
                    paymentsWidget(text: "3 Payments")
                  ],
                ),
              ),
              Divider(
                thickness: 1,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: AppPadding.padding12),
                child: Column(
                  children: [
                    CheckBoxWidget(
                        isChecked: methodValue == AppStrings.payment6,
                        ontapCheck: () {
                          setState(() {
                            methodValue = AppStrings.payment6;
                          });
                        },
                        title: AppStrings.payment6),
                    paymentsWidget(text: "6 Payments")
                  ],
                ),
              ),
              Divider(
                thickness: 1,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: AppPadding.padding12),
                child: Column(
                  children: [
                    CheckBoxWidget(
                        isChecked: methodValue == AppStrings.payment12,
                        ontapCheck: () {
                          setState(() {
                            methodValue = AppStrings.payment12;
                          });
                        },
                        title: AppStrings.payment12),
                    paymentsWidget(text: "12 Payments")
                  ],
                ),
              ),

              20.verticalSpace,
              btnWidget(context),
            ])));
  }

  Padding paymentsWidget({text}) {
    return Padding(
      padding: EdgeInsets.only(left: 40.w),
      child: CustomText(
        text: text,
        fontSize: 12.sp,
      ),
    );
  }

  CustomButton btnWidget(BuildContext context) {
    return CustomButton(
      text: AppStrings.continu,
      onclick: () {
        AppNavigation.navigateTo(
          context,
          AppRoutes.payOverTimeScreenRoute,
        );
      },
    );
  }
}
