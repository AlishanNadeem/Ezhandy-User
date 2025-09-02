import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AppShadows {
  AppShadows._();
  static List<BoxShadow> shadow1 = [
    BoxShadow(
      color: AppColors.black.withOpacity(0.1),
      spreadRadius: 2,
      blurRadius: 8,
      offset: Offset(2, 9),
    ),
  ];
  static List<BoxShadow> shadow2 = [
    BoxShadow(
      color: AppColors.grey.withOpacity(0.3),
      spreadRadius: 2,
      blurRadius: 8,
      offset: Offset(2, 5),
    )
  ];
  // static List<BoxShadow> shadow2 = [BoxShadow(color: AppColors.gradient_1.withOpacity(0.2), spreadRadius: 5, blurRadius: 10)];
  // static List<BoxShadow> shadow3 = [BoxShadow(color: AppColors.fontColor.withOpacity(0.6), spreadRadius: 0, blurRadius: 10)];
  // static List<BoxShadow> shadow4 = [
  //   BoxShadow(
  //     color: Color.fromARGB(255, 212, 212, 212).withOpacity(0.5), // You can change the shadow color here
  //     spreadRadius: 5,
  //     blurRadius: 7,
  //     offset: Offset(0, 3), // changes position of shadow
  //   ),
  // ];
  // static List<BoxShadow> shadow5 = [
  //   BoxShadow(
  //     color: Color.fromARGB(255, 212, 212, 212).withOpacity(0.5),
  //     spreadRadius: 0,
  //     blurRadius: 7,
  //     offset: Offset(3, 3), // This offset will create a shadow on the right and bottom sides
  //   ),
  // ];

  // static getBoxShadowListByColor({
  //   Color? color,
  //   double? spreadRadius,
  //   double? blurRadius,
  //   Offset? offset,
  // }) {
  //   return [
  //     BoxShadow(
  //         blurStyle: BlurStyle.inner,
  //         offset: offset ?? const Offset(2, 2),
  //         color: (color ?? Colors.black).withOpacity(.1),
  //         spreadRadius: spreadRadius ?? 2,
  //         blurRadius: blurRadius ?? 5)
  //   ];
  // }

  // static getBoxShadowByColor({
  //   Color? color,
  //   double? spreadRadius,
  //   double? blurRadius,
  //   Offset? offset,
  // }) {
  //   return BoxShadow(
  //       blurStyle: BlurStyle.inner,
  //       offset: offset ?? const Offset(-5, 1),
  //       color: (color ?? Colors.black).withOpacity(.1),
  //       spreadRadius: spreadRadius ?? 2,
  //       blurRadius: blurRadius ?? 5);
  // }

  // static List<BoxShadow> allSidesShadow({
  //   double? spreadRadius,
  //   double? blurRadius,
  //   Color? color,
  // }) {
  //   return [
  //     getBoxShadowByColor(
  //       offset: const Offset(0, 1),
  //       blurRadius: blurRadius,
  //       spreadRadius: spreadRadius,
  //       color: color,
  //     ),
  //     getBoxShadowByColor(
  //       offset: const Offset(0, -1),
  //       blurRadius: blurRadius,
  //       spreadRadius: spreadRadius,
  //       color: color,
  //     ),
  //     getBoxShadowByColor(
  //       offset: const Offset(1, 0),
  //       blurRadius: blurRadius,
  //       spreadRadius: spreadRadius,
  //       color: color,
  //     ),
  //     getBoxShadowByColor(
  //       offset: const Offset(-1, 0),
  //       blurRadius: blurRadius,
  //       spreadRadius: spreadRadius,
  //       color: color,
  //     ),
  // ];
  // }
}
