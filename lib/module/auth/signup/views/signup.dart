import 'dart:developer';

import 'package:ezhandy_user/module/auth/signup/widgets/sign_up_form.dart';
import 'package:ezhandy_user/widgets/logo_and_backgrounds/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUp extends StatefulWidget {
  // final String? type;
  SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool keyboardVisible = false;
  @override
  Widget build(BuildContext context) {
    keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    log(keyboardVisible.toString());
    return BackgroundImage(
      // is_registration: true,
      // leading: AssetPath.backIcon,
      // onclickLead: () {
      //   Get.back();
      // },
      // title: AppStrings.login,
      appBarheight: 50.h,
      child: SignUpForm(keyboardVisible: keyboardVisible),
    );
  }
}
