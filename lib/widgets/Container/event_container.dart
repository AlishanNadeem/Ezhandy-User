// // ignore_for_file: must_be_immutable

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:ezhandy_user/utils/app_colors.dart';
// import 'package:ezhandy_user/widgets/Container/custom_container.dart';
// import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';

// class EventContainer extends StatelessWidget {
//   String image, eventName, eventTime, eventAddress;

//   bool isDetail, isStar;
//   void Function()? ontap;
//   EventContainer(
//       {super.key,
//       this.isDetail = false,
//       this.isStar = false,
//       this.ontap,
//       required this.image,
//       required this.eventAddress,
//       required this.eventName,
//       required this.eventTime});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: ontap,
//       child: CustomContainer(
//         isPadding: false,
//         radius: 8.r,
//         width: 1.sw,
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
//               width: 1.sw,
//               height: 160.h,
//               padding: EdgeInsets.all(10.sp),
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(8.r),
//                   image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover)),
//               child: isStar == true
//                   ? Align(
//                       alignment: Alignment.topRight,
//                       child: Icon(
//                         Icons.star,
//                         size: 30.sp,
//                         color: Colors.amberAccent[400],
//                       ),
//                     )
//                   : Visibility(
//                       visible: isDetail,
//                       child: CustomText(
//                         align: Alignment.topRight,
//                         text: "Pending",
//                         color: AppColors.white,
//                       ),
//                     ),
//             ),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
//               child: nameWidget(eventName: eventName, eventTime: eventTime, eventAddress: eventAddress),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Widget nameWidget({required String eventName, required String eventTime, required String eventAddress}) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             CustomText(
//               text: eventName,
//               fontWeight: FontWeight.bold,
//             ),
//             CustomText(
//               text: eventTime,
//               fontSize: 12.sp,
//             ),
//           ],
//         ),
//         CustomText(
//           text: eventAddress,
//           fontSize: 12.sp,
//         ),
//       ],
//     );
//   }
// }
