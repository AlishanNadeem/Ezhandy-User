import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ezhandy_user/module/auth/create_new_password/widget/change_password_form.dart';
import 'package:ezhandy_user/utils/app_strings.dart';
import 'package:ezhandy_user/utils/asset_path.dart';
import 'package:ezhandy_user/widgets/logo_and_backgrounds/background.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordPasswordState();
}

class _ChangePasswordPasswordState extends State<ChangePassword> {
  bool? check1 = false;
  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
      leading: AssetPath.backIcon,
      onclickLead: () {
        Get.back();
      },
      // appBarheight: 50.h,
      title: AppStrings.changePassword,
      child: ChangePasswordForm(),
    );
  }
}
