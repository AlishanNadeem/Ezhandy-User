import 'package:ezhandy_user/utils/app_strings.dart';
import 'package:ezhandy_user/widgets/logo_and_backgrounds/app_logo.dart';
import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgotPasswordHeader extends StatelessWidget {
  const ForgotPasswordHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          AppLogo(scale: 3.sp),
          15.verticalSpace,
          CustomText(
            text: AppStrings.forgetPassword,
            is_alignLeft: false,
            fontSize: 23.sp,
            fontWeight: FontWeight.bold,
          ),
          8.verticalSpace,
          CustomText(
            text: AppStrings.forgetPasswordSubtitle,
            is_alignLeft: false,
          ),
        ],
      ),
    );
  }
}
