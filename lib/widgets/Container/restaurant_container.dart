// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:ezhandy_user/utils/app_colors.dart';
// import 'package:ezhandy_user/utils/app_strings.dart';
// import 'package:ezhandy_user/utils/asset_path.dart';
// import 'package:ezhandy_user/widgets/Container/custom_container.dart';
// import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';

// class RestaurantContainer extends StatelessWidget {
//   String? image, name, address, opens, time;
//   RestaurantContainer({this.address, this.image, this.name, this.opens, this.time, super.key});

//   @override
//   Widget build(BuildContext context) {
//     return CustomContainer(
//       isPadding: false,
//       radius: 15.r,
//       width: 1.sw,
//       isGradient: true,
//       gradient: LinearGradient(
//         begin: Alignment.centerLeft,
//         end: Alignment.centerRight,
//         transform: GradientRotation(25),
//         colors: [
//           AppColors.gradient_1,
//           AppColors.gradient_1,
//           AppColors.white,
//         ],
//       ),
//       child: Padding(
//         padding: EdgeInsets.all(10.r),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               width: 80.w,
//               height: 80.h,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(15.r),
//                 image: DecorationImage(
//                   image: AssetImage(image ?? AssetPath.tempImage1),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             10.horizontalSpace, // Space between image and text
//             Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 CustomText(text: name ?? AppStrings.dummyRestaurantName),
//                 CustomText(text: address ?? AppStrings.dummyAddress, color: AppColors.fontColor),
//                 SizedBox(height: 10.h), // Instead of Spacer()
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     CustomText(text: opens ?? "Mon To Sun", color: AppColors.fontColor),
//                     SizedBox(width: 20.w), // Instead of Spacer()
//                     CustomText(text: time ?? "09:00 AM To 10:00 PM", color: AppColors.fontColor),
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
