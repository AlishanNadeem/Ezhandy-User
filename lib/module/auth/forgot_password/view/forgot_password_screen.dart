import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:ezhandy_user/module/auth/forgot_password/Widget/forgot_pass_form.dart';
import 'package:ezhandy_user/utils/asset_path.dart';
import 'package:ezhandy_user/widgets/logo_and_backgrounds/background.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
      leading: AssetPath.backIcon,
      onclickLead: () {
        Get.back();
      },
      appBarheight: 50.h,
      // title: AppStrings.forgotPassword,
      // is_registration: true,
      //----------------Form----------------
      child: ForgotPassForm(),
    );
  }
}
