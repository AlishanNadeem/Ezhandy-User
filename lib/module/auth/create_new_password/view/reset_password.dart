import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ezhandy_user/module/auth/create_new_password/widget/reset_password_form.dart';
import 'package:ezhandy_user/utils/asset_path.dart';
import 'package:ezhandy_user/widgets/logo_and_backgrounds/background.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  bool? check1 = false;
  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
      leading: AssetPath.backIcon,
      onclickLead: () {
        Get.back();
      },
      // appBarheight: 50.h,
      // title: AppStrings.resetPassword,
      // is_registration: true,
      child: const ResetPasswordForm(),
    );
  }
}
