// ignore_for_file: must_be_immutable

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ezhandy_user/module/auth/verification/widget/otp_verification_form.dart';
import 'package:ezhandy_user/utils/asset_path.dart';
import 'package:ezhandy_user/widgets/logo_and_backgrounds/background.dart';

class OTPVerification extends StatefulWidget {
  // final bool? isFromPhoneNumber;
  String? emailAndPhone;
  String? type;
  String? text;

  // String? initialCountry;
  OTPVerification({Key? key, this.type
  , required this.emailAndPhone
  , required this.text
  }) : super(key: key);

  @override
  State<OTPVerification> createState() => _OTPVerificationState();
}

class _OTPVerificationState extends State<OTPVerification> {
  int _duration = 59;

  bool isTimeComplete = false;

  bool keyboardVisible = false;
  @override
  Widget build(BuildContext context) {
    keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    log(keyboardVisible.toString());
    return BackgroundImage(
        // is_registration: true,
        leading: AssetPath.backIcon,
        onclickLead: () {
          Get.back();
          isTimeComplete = true;
        },
        // title: AppStrings.otp,
        // appBarheight: 50.h,
        child: OtpVerificationForm(
          type: widget.type!,
          iso_code: "",
          country_code: "",
          emailAndPhone: widget.emailAndPhone,
          text: widget.text,
          duration: _duration,
          isTimeComplete: isTimeComplete,
          user_id: " ",
          phone_verication: " ",
          keyboardVisible: keyboardVisible,
        ));
  }
}
