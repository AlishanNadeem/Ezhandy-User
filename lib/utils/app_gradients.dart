import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AppGradients {
  AppGradients._();

  // static LinearGradient dialogGradient = const LinearGradient(
  //   begin: Alignment.centerLeft,
  //   end: Alignment.centerRight,
  //   transform: GradientRotation(25),
  //   colors: [AppColors.gradient_3, AppColors.gradient_2, AppColors.gradient_1],
  // );
  static LinearGradient buttonGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    transform: GradientRotation(25),
    colors: [
      AppColors.black,
      AppColors.black,
    ],
  );
  static LinearGradient filterGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    transform: GradientRotation(25),
    colors: [
      AppColors.black.withOpacity(0.9),
      AppColors.black.withOpacity(0.9),
      AppColors.black.withOpacity(0.9),
    ],
  );
  static LinearGradient backgroundGradient = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    transform: GradientRotation(25),
    colors: [
      AppColors.black,
      AppColors.black,
    ],
  );
  static LinearGradient userCardGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0x001E2125),
      Color(0x001E2125),
      Color.fromARGB(255, 60, 26, 81).withOpacity(.8),
    ],
  );

  // static LinearGradient bookingBarGradient = const LinearGradient(
  //   begin: Alignment.topCenter,
  //   end: Alignment.bottomCenter,
  //   // transform: GradientRotation(25),
  //   colors: [
  //     AppColors.gradient_3,
  //     // AppColors.gradient_2,
  //     AppColors.gradient_1,
  //   ],
  // );
  // static LinearGradient redGradient = const LinearGradient(
  //   begin: Alignment.topCenter,
  //   end: Alignment.bottomCenter,
  //   colors: [AppColors.lightRed, AppColors.darkRed],
  // );
}
