// // ignore_for_file: must_be_immutable

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:ezhandy_user/utils/app_colors.dart';
// import 'package:ezhandy_user/widgets/Container/custom_container.dart';
// import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';

// class RecommendationCard extends StatelessWidget {
//   String image, name, address;
//   double? width, height, imageHeight;
//   bool isStar;
//   void Function()? ontap;
//   RecommendationCard({
//     super.key,
//     this.isStar = false,
//     this.ontap,
//     this.width,
//     this.height,
//     this.imageHeight,
//     required this.image,
//     required this.address,
//     required this.name,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: ontap,
//       child: CustomContainer(
//         isPadding: false,
//         radius: 8.r,
//         width: width ?? 1.sw,
//         height: height,
//         isGradient: true,
//         gradient: LinearGradient(
//           begin: Alignment.centerLeft,
//           end: Alignment.centerRight,
//           transform: GradientRotation(25),
//           colors: [
//             AppColors.gradient_1,
//             AppColors.white,
//           ],
//         ),
//         child: Column(
//           children: [
//             Container(
//                 width: 1.sw,
//                 height: imageHeight ?? 160.h,
//                 padding: EdgeInsets.all(10.sp),
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(8.r),
//                     image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover)),
//                 child: Visibility(
//                   visible: isStar,
//                   child: Align(
//                     alignment: Alignment.topRight,
//                     child: Icon(
//                       Icons.star,
//                       size: 30.sp,
//                       color: Colors.amberAccent[400],
//                     ),
//                   ),
//                 )),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
//               child: nameWidget(eventName: name, eventAddress: address),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Widget nameWidget({required String eventName, required String eventAddress}) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         CustomText(
//           text: eventName,
//           fontWeight: FontWeight.bold,
//         ),
//         CustomText(
//           text: eventAddress,
//           fontSize: 12.sp,
//         ),
//       ],
//     );
//   }
// }
