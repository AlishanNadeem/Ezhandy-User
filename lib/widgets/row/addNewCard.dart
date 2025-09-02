// // ignore_for_file: must_be_immutable

// import 'package:elpistoken/utils/app_colors.dart';
// import 'package:elpistoken/utils/app_strings.dart';
// import 'package:elpistoken/widgets/text_widgets/text_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class AddNewCard extends StatelessWidget {
//   void Function()? onTap;
//   AddNewCard({this.onTap, super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
//         Container(
//           padding: EdgeInsets.symmetric(vertical: 3.sp, horizontal: 5.sp),
//           decoration: const BoxDecoration(
//               color: AppColors.gradient_1, shape: BoxShape.circle),
//           child: const Center(
//             child: Icon(Icons.add, color: AppColors.black, size: 12),
//           ),
//         ),
//         SizedBox(width: 5.w),
//         CustomText(
//             text: AppStrings.addNewCard,
//             textDecoration: TextDecoration.underline,
//             color: AppColors.green)
//       ]),
//     );
//   }
// }
