import 'dart:io';

import 'package:ezhandy_user/module/auth/content/routing_arguments/content_routing_arguments.dart';
import 'package:ezhandy_user/module/core/booking/routing_arguments/booking_routing_arguments.dart';
import 'package:ezhandy_user/utils/app_dialogs.dart';
import 'package:ezhandy_user/utils/app_padding.dart';
import 'package:ezhandy_user/utils/constant.dart';
import 'package:ezhandy_user/utils/enums.dart';
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

class PayOverTime extends StatefulWidget {
  // String? serviceName;
  PayOverTime({super.key});

  @override
  State<PayOverTime> createState() => _PayOverTimeState();
}

class _PayOverTimeState extends State<PayOverTime> {
  // String methodValue = AppStrings.payment3;

  // String? filterStartValue;

  // bool isLike=false;
  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
        leading: AssetPath.backIcon,
        onclickLead: () {
          Get.back();
        },
        title: AppStrings.payOverTime,
        appBarheight: 50,
        child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppPadding.padding12),
            child: Column(children: [
              20.verticalSpace,
              CustomText(
                  text: AppStrings.payment3 + ": 3 Payments",
                  fontSize: 16.sp,
                  color: AppColors.orange,
                  fontWeight: FontWeight.w600),
              20.verticalSpace,
              listTileWidget(text: "1 payment of \$200.00"),
              20.verticalSpace,
              listTileWidget(
                  text: "Firer monthly months nut 200.00 starting from May 25"),
              20.verticalSpace,
              listTileWidget(text: "Total of \$500.90 0% APR"),
              20.verticalSpace,
              listTileWidget(text: "0% interest"),
              20.verticalSpace,
              GestureDetector(
                  onTap: () {
                    AppNavigation.navigateTo(
                        context, AppRoutes.contentScreenRoute,
                        arguments: ContentRoutingArgument(
                            title: AppStrings.termsAndConditions,
                            type: WebContentType.tc.name));
                  },
                  child: CustomText(
                    text: AppStrings.termsAndConditions,
                    color: AppColors.orange,
                  )),
              20.verticalSpace,
              btnWidget(context),
            ])));
  }

  ListTile listTileWidget({text}) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      titleAlignment: ListTileTitleAlignment.center,
      leading: CircleAvatar(radius: 5.r, backgroundColor: AppColors.orange),
      title: CustomText(text: text),
      minLeadingWidth: 12,
    );
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
         AppDialogs.showSuccessDialog(
            context,
            description: AppStrings.yourBookingHasBeenDone,
            title: AppStrings.congratulation,
            btnTxt1: AppStrings.ok,
            onTap1: () {
              // AppNavigation.navigatorPop(
              //     Constants.navigatorKey.currentContext!);
              AppNavigation.navigatorPopUntil(
                  context, AppRoutes.mainMenuScreenRoute);

              AppNavigation.navigateTo(Constants.navigatorKey.currentContext!,
                  AppRoutes.bookingScreenRoute,
                  arguments:
                      BookingRoutingArgument(Status: AppStrings.pending));
            },
          );
      },
    );
  }
}
