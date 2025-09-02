// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:ezhandy_user/utils/app_colors.dart';
// import 'package:ezhandy_user/utils/asset_path.dart';
// import 'package:ezhandy_user/widgets/Container/custom_container.dart';
// import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';

// class GroupActivityContainer extends StatelessWidget {
//   String? image, name, description;
//   void Function()? ontap;
//   // bool isDetail;
//   GroupActivityContainer({this.ontap, this.name, this.image, this.description, super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: ontap,
//       child: CustomContainer(
//         isPadding: false,
//         radius: 15.r,
//         width: 1.sw,
//         isGradient: true,
//         gradient: LinearGradient(
//           begin: Alignment.centerLeft,
//           end: Alignment.centerRight,
//           transform: GradientRotation(25),
//           colors: [
//             AppColors.gradient_1,
//             AppColors.gradient_1,
//             AppColors.white,
//           ],
//         ),
//         child: Padding(
//           padding: EdgeInsets.all(10.r),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 width: 80.w,
//                 height: 80.h,
//                 decoration: BoxDecoration(
//                   color: AppColors.white,
//                   borderRadius: BorderRadius.circular(15.r),
//                   image: DecorationImage(
//                     image: AssetImage(image ?? AssetPath.tempImage1),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               10.horizontalSpace, // Space between image and text
//               Expanded(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     CustomText(
//                       text: name,
//                       fontSize: 16.sp,
//                       fontWeight: FontWeight.w500,
//                     ),
//                     SizedBox(height: 5.h),
//                     CustomText(
//                       text: description,
//                       maxLines: 2,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
