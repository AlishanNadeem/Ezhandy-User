// // ignore_for_file: must_be_immutable

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:fuel_delivery_app/Utils/app_color.dart';
// import 'package:fuel_delivery_app/Widgets/text_widgets/text_widget.dart';

// class IconTextRow extends StatelessWidget {
//   String iconPath, text;
//   IconTextRow({required this.iconPath, required this.text, super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Row(children: [
//       SizedBox(
//         width: 15.w,
//         height: 15.h,
//         child: Image.asset(iconPath),
//       ),
//       SizedBox(width: 10.w),
//       Expanded(
//         child: CustomText(text: text, color: AppColors.GREY_TEXT_COLOR),
//       ),
//     ]);
//   }
// }
