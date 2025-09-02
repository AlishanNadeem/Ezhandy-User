import 'package:ezhandy_user/utils/app_strings.dart';
import 'package:ezhandy_user/widgets/button_widgets/custom_button.dart';
import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ezhandy_user/widgets/Container/custom_container.dart';

// ignore: must_be_immutable
class TotalWithButtonRow extends StatelessWidget {
  String? totalAmount, buttonText;
  dynamic Function()? ontap;
  TotalWithButtonRow({this.totalAmount, this.buttonText, this.ontap, super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
        // boxShadow: AppShadows.shadow4,
        radius: 0,
        child: Row(
          children: [
            CustomText(text: AppStrings.total, fontWeight: FontWeight.w700, fontSize: 16.sp),
            20.w.horizontalSpace,
            CustomText(
                text: totalAmount ?? "\$63265.00",
                // fontWeight: FontWeight.bold,
                fontSize: 16.sp),
            // const Spacer(),
            60.w.horizontalSpace,
            Expanded(
                child: CustomButton(
              onclick: ontap,
              text: buttonText ?? "",
              height: 45.h,
            ))
          ],
        ));
  }
}
