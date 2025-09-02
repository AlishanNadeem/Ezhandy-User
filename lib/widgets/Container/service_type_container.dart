// import 'package:elpistoken/utils/app_colors.dart';
// import 'package:elpistoken/utils/app_gradients.dart';
// import 'package:elpistoken/utils/app_padding.dart';
// import 'package:elpistoken/utils/app_shadows.dart';
// import 'package:elpistoken/utils/app_strings.dart';
// import 'package:elpistoken/utils/asset_path.dart';
// import 'package:elpistoken/widgets/text_widgets/text_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class ServiceTypeContainer extends StatelessWidget {
//   bool isArrow;
//   String? title, description;
//   ServiceTypeContainer({
//     this.title,
//     this.description,
//     this.isArrow = true,
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(10),
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(8.sp),
//           // border: isGradient ? Border.all(color: AppColors.borderColor) : null,
//           // color: isGradient ? null : AppColors.white,
//           gradient: AppGradients.bookingBarGradient,
//           boxShadow: AppShadows.shadow2),
//       child: Row(
//         children: [
//           Container(
//               padding: EdgeInsets.all(20.sp),
//               decoration: BoxDecoration(
//                   color: AppColors.white,
//                   shape: BoxShape.circle,
//                   image: DecorationImage(
//                       image: AssetImage(AssetPath.carIcon), scale: 5.sp))),
//           10.horizontalSpace,
//           Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               CustomText(
//                 text: title,
//                 color: AppColors.white,
//                 fontWeight: FontWeight.bold,
//               ),
//               CustomText(
//                   text: description,
//                   color: AppColors.background,
//                   fontSize: 12.sp)
//             ],
//           ),
//           Spacer(),
//           Visibility(
//             visible: isArrow,
//             child: Icon(
//               Icons.arrow_forward_ios_rounded,
//               color: AppColors.background,
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
