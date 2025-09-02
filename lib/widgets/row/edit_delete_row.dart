import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/utils/app_strings.dart';
import 'package:ezhandy_user/widgets/button_widgets/custom_button.dart';

// ignore: must_be_immutable
class EditDeleteRow extends StatelessWidget {
  String? button1, button2;
  dynamic Function()? ontapButton2, ontapButton1;
  EditDeleteRow({
    super.key,
    this.button1,
    this.button2,
    required this.ontapButton2,
    required this.ontapButton1,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        10.w.horizontalSpace,
        Expanded(
            child: CustomButton(
          onclick: ontapButton1,
          height: 45.h,
          text: button1 ?? AppStrings.edit,
          color: AppColors.black,
          textcolor: AppColors.black,
        )),
        10.w.horizontalSpace,
        Expanded(
            child: CustomButton(
          onclick: ontapButton2,
          text: button2 ?? AppStrings.delete,
          height: 45.h,
          // color: AppColors.pink,
          // textcolor: AppColors.black,
        )),
        10.w.horizontalSpace,
      ],
    );
  }
}
