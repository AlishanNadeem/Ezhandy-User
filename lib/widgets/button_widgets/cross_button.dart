// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/utils/app_shadows.dart';

class CrossButton extends StatelessWidget {
  void Function()? onTap;
  Color? iconColor, circleColor;
  CrossButton({this.onTap, this.circleColor, this.iconColor, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap ??
            () {
              Get.back();
            },
        child: Container(
          padding: EdgeInsets.all(3.r),
          decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: AppShadows.shadow2, color: circleColor ?? AppColors.white),
          child: Icon(
            Icons.close,
            color: iconColor ?? AppColors.green,
            size: 20.sp,
          ),
        ));
  }
}
