// import 'package:elpistoken/utils/app_colors.dart';
// import 'package:elpistoken/utils/asset_path.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';


// class UserAvatar extends StatelessWidget {
//   const UserAvatar(
//       {super.key,
//       this.onTap,
//       required this.radius,
//       this.avatarBorderColor = AppColors.gradient_1,
//        this.userImage,
//       this.hasActiveIcon = false});
//   final double radius;
//   final Color avatarBorderColor;
//   final String? userImage;
//   final bool hasActiveIcon;
//   final Function()? onTap;
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         GestureDetector(
//           onTap: onTap ??
//               () {
//                 Get.toNamed(Paths.USER_SCREEN_ROUTE);
//               },
//           child: Container(
//             padding: const EdgeInsets.all(2),
//             decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 border: Border.all(color: avatarBorderColor)),
//             child: userImage == null
//                 ? CircleAvatar(
//                     radius: radius.sp,
//                     backgroundImage: AssetImage(AssetPath.USER_IMAGE_1),
//                   )
//                 : CircleAvatar(
//                     radius: radius.sp,
//                     backgroundImage: NetworkImage(
//                         NetworkStrings.IMAGE_BASE_URL + userImage!),
//                   ),
//           ),
//         ),
//         hasActiveIcon
//             ? Positioned(
//                 bottom: 0,
//                 right: 0,
//                 child: Container(
//                   padding: const EdgeInsets.all(4).r,
//                   decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: AppColors.BLACK_COLOR,
//                       border: Border.all(color: AppColors.BLACK_COLOR)),
//                 ))
//             : const SizedBox()
//       ],
//     );
//   }
// }
