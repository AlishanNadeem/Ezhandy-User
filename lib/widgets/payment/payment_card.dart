// import 'package:elpistoken/utils/app_colors.dart';
// import 'package:elpistoken/widgets/Container/custom_container.dart';
// import 'package:elpistoken/widgets/text_widgets/text_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class PaymentCard extends StatelessWidget {
//   String? groupValue;
//   String Value, iconPath, cardName;
//   void Function(String?)? onChanged;
//   PaymentCard(
//       {this.groupValue,
//       required this.onChanged,
//       required this.Value,
//       required this.iconPath,
//       required this.cardName,
//       super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 5.0.h),
//       child: CustomContainer(
//           isGradient: false,
//           isPadding: false,
//           // color: AppColors.WHITE_COLOR,
//           //   borderRadius: 15,
//           //   is_border: false,
//           child: Padding(
//             padding: EdgeInsets.only(left: 12.w, top: 5.h, bottom: 5.h),
//             child: Row(
//               children: [
//                 Image.asset(iconPath, scale: 3),
//                 SizedBox(width: 10.w),
//                 CustomText(
//                   text: cardName,
//                   color: AppColors.black,
//                 ),
//                 Spacer(),
//                 Padding(
//                     padding: EdgeInsets.zero,
//                     child: Radio(
//                         value: Value,
//                         groupValue: groupValue,
//                         onChanged: onChanged)),
//               ],
//             ),
//           )),
//     );
//   }
// }
