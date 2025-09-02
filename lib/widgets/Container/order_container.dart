// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:ezhandy_user/utils/app_colors.dart';
// import 'package:ezhandy_user/utils/app_strings.dart';
// import 'package:ezhandy_user/utils/asset_path.dart';
// import 'package:ezhandy_user/widgets/Container/custom_container.dart';
// import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';

// class OrderContainer extends StatelessWidget {
//   String? image, productName, amount, description, date, quantity;
//   void Function()? ontap;
//   bool isDetail;
//   OrderContainer(
//       {this.isDetail = false, this.ontap, this.productName, this.quantity, this.image, this.amount, this.description, this.date, super.key});

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
//                 color: AppColors.white,
//                 borderRadius: BorderRadius.circular(15.r),
//                 image: DecorationImage(
//                   image: AssetImage(image ?? AssetPath.tempImage1),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             10.horizontalSpace, // Space between image and text
//             Expanded(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       CustomText(text: productName, fontSize: 16.sp),
//                       const Spacer(), // Pushes amount to the right
//                       isDetail ? SizedBox.shrink() : CustomText(text: amount),
//                     ],
//                   ),
//                   SizedBox(height: 5.h),
//                   CustomText(
//                     text: description,
//                     maxLines: 1,
//                   ),
//                   SizedBox(height: 10.h),
//                   Row(
//                     children: [
//                       CustomText(text: isDetail ? amount : date),
//                       const Spacer(), // Pushes "View Details" to the right

//                       isDetail
//                           ? CustomText(text: "Qty: $quantity")
//                           : GestureDetector(
//                               onTap: ontap,
//                               child: CustomText(
//                                   text: AppStrings.viewDetails, color: AppColors.backButtonPurple, textDecoration: TextDecoration.underline)),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
