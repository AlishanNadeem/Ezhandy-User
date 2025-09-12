import 'package:ezhandy_user/module/core/booking/routing_arguments/booking_routing_arguments.dart';
import 'package:ezhandy_user/utils/app_dialogs.dart';
import 'package:ezhandy_user/utils/app_padding.dart';
import 'package:ezhandy_user/utils/constant.dart';
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

class ChoosePaymentMethod extends StatefulWidget {
  // String? serviceName;
  ChoosePaymentMethod({super.key});

  @override
  State<ChoosePaymentMethod> createState() => _ChoosePaymentMethodState();
}

class _ChoosePaymentMethodState extends State<ChoosePaymentMethod> {
  String methodValue = AppStrings.creditCard;

  // String? filterStartValue;

  // bool isLike=false;
  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
        leading: AssetPath.backIcon,
        onclickLead: () {
          Get.back();
        },
        title: AppStrings.choosePaymentMethod,
        appBarheight: 50,
        child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppPadding.padding12),
            child: Column(children: [
              20.verticalSpace,
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: AppPadding.padding12),
                child: CheckBoxWidget(
                    isChecked: methodValue == AppStrings.creditCard,
                    ontapCheck: () {
                      setState(() {
                        methodValue = AppStrings.creditCard;
                      });
                    },
                    title: AppStrings.creditCard),
              ),
              Divider(
                thickness: 1,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: AppPadding.padding12),
                child: CheckBoxWidget(
                    isChecked: methodValue == AppStrings.googlePlay,
                    ontapCheck: () {
                      setState(() {
                        methodValue = AppStrings.googlePlay;
                      });
                    },
                    title: AppStrings.googlePlay),
              ),
              Divider(
                thickness: 1,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: AppPadding.padding12),
                child: CheckBoxWidget(
                    isChecked: methodValue == AppStrings.applePay,
                    ontapCheck: () {
                      setState(() {
                        methodValue = AppStrings.applePay;
                      });
                    },
                    title: AppStrings.applePay),
              ),
              Divider(
                thickness: 1,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: AppPadding.padding12),
                child: CheckBoxWidget(
                    isChecked: methodValue == AppStrings.affirm,
                    ontapCheck: () {
                      setState(() {
                        methodValue = AppStrings.affirm;
                      });
                    },
                    title: AppStrings.affirm),
              ),
              Divider(
                thickness: 1,
              ),
              20.verticalSpace,
              btnWidget(context),
            ])));
  }

  CustomButton btnWidget(BuildContext context) {
    return CustomButton(
      text: AppStrings.next,
      onclick: () {
        if (methodValue == AppStrings.affirm) {
          AppNavigation.navigateTo(
            context,
            AppRoutes.signInWithAffirmScreenRoute,
          );
        } else {
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
        }
      },
    );
  }
}
