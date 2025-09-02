// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:ezhandy_user/utils/app_colors.dart';
// import 'package:ezhandy_user/utils/asset_path.dart';
// import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';

// // ignore: must_be_immutable
// class AddMore extends StatelessWidget {
//   void Function()? ontap;
//   double? height, width;
//   String? text, image;
//   Color? borderColor;
//   AddMore({this.ontap, this.height, this.width, this.borderColor, this.text, this.image, super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: ontap,
//       child: Container(
//         height: height?.h,
//         width: width?.w,
//         child: DottedBorder(
//           borderType: BorderType.RRect,
//           // padding: EdgeInsets.all(15.sp),
//           color: borderColor ?? AppColors.backButtonPurple,
//           radius: Radius.circular(8.sp),
//           dashPattern: [3, 5],
//           strokeWidth: 1,
//           child: Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(8.sp),
//               color: AppColors.white,
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Image.asset(
//                   image ?? AssetPath.uploadImageIcon,
//                   scale: 4.sp,
//                   color: borderColor ?? null,
//                 ),
//                 5.h.verticalSpace,
//                 CustomText(
//                   is_alignLeft: false,
//                   text: text,
//                   // color: AppColors.borderColor,
//                   fontSize: 12.sp,
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
