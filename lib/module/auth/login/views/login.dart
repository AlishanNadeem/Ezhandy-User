import 'dart:developer';

import 'package:ezhandy_user/module/auth/login/widgets/sign_in_form.dart';
import 'package:ezhandy_user/widgets/logo_and_backgrounds/background.dart';
import 'package:flutter/material.dart';

class LogIn extends StatefulWidget {
  // final String? type;
  LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
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
      // appBarheight: 50.h,
      child: SignInForm(keyboardVisible: keyboardVisible),
    );
  }
}
