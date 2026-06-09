import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/utils/app_gradients.dart';
import 'package:ezhandy_user/utils/app_padding.dart';

// ignore: must_be_immutable
class CustomContainer extends StatelessWidget {
  Widget child;
  bool isPadding, isGradient;
  Color? bgColor, borderColor;
  List<BoxShadow>? boxShadow;
  double? radius, height, width;
  Gradient? gradient;void Function()? onTap;
  CustomContainer({
    required this.child,
    this.isPadding = true,
    this.isGradient = false,
    this.borderColor,
    this.gradient,
    this.bgColor,
    this.height,
    this.width,
    this.radius,
    this.boxShadow,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final box = Container(
      height: height,
      width: width,
      padding:
          isPadding ? EdgeInsets.all(AppPadding.padding12) : EdgeInsets.zero,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 10.sp),
          color: bgColor ?? AppColors.white,
          border: Border.all(color: borderColor ?? AppColors.greyBorder),
          gradient:
              isGradient ? gradient ?? AppGradients.buttonGradient : null,
          boxShadow: boxShadow),
      child: child,
    );
    if (onTap != null) {
      return GestureDetector(onTap: onTap, child: box);
    }
    return box;
  }
}
