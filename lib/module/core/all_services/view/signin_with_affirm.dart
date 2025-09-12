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

class SignInWithAffirm extends StatefulWidget {
  // String? serviceName;
  SignInWithAffirm({super.key});

  @override
  State<SignInWithAffirm> createState() => _SignInWithAffirmState();
}

class _SignInWithAffirmState extends State<SignInWithAffirm> {
  String methodValue=AppStrings.creditCard;
  final TextEditingController phoneController = TextEditingController();

  // String? filterStartValue;

  // bool isLike=false;
  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
        leading: AssetPath.backIcon,
        onclickLead: () {
          Get.back();
        },
        title: AppStrings.signInWithAffirm,
        appBarheight: 50,
        child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppPadding.padding12),
            child: Column(children: [
              20.verticalSpace,
              CustomText(text: AppStrings.enterMobileNumberToGetStart),
              20.verticalSpace,
              CustomText(text: AppStrings.phoneNumber),
              20.verticalSpace,
              _phoneNumberTextField(),
              20.verticalSpace,
              CustomText(text: AppStrings.receiveSms),

              20.verticalSpace,

           
              20.verticalSpace,
              btnWidget(context),
            ])));
  }
  Widget _phoneNumberTextField() {
    return CustomTextField(
      hint: AppStrings.enterPhoneNumber,
      divider: false,
      // prefxicon: AssetPath.callIcon,
      label: false,
      keyboardType: TextInputType.number,
      inputFormatters: [Constants.maskTextInputFormatterPhoneUSWithCode],
      controller: phoneController,
      // validator: (value) => value?.validateEmpty(AppStrings.phon),
      // error_text: error_email,
    );
  }
  CustomButton btnWidget(BuildContext context) {
    return CustomButton(
      text: AppStrings.continu,
      onclick: () {
        AppNavigation.navigateTo(
          context,
          AppRoutes.selectAPaymentPlanScreenRoute,
        );
      },
    );
  }
}
