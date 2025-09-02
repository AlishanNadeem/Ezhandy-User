// // ignore_for_file: must_be_immutable

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:ezhandy_user/utils/app_colors.dart';
// import 'package:ezhandy_user/utils/app_gradients.dart';
// import 'package:ezhandy_user/utils/app_padding.dart';
// import 'package:ezhandy_user/utils/app_shadows.dart';
// import 'package:ezhandy_user/utils/app_strings.dart';
// import 'package:ezhandy_user/utils/asset_path.dart';
// import 'package:ezhandy_user/widgets/Container/shadow_container.dart';
// import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';

// class OtherUserProfileWidget extends StatefulWidget {
//   bool isRadius, isHeartShow, isHeart;
//   double? bottomPadding;
//   String? image;

//   OtherUserProfileWidget({this.image, this.bottomPadding, this.isRadius = true, this.isHeartShow = true, this.isHeart = false, super.key});

//   @override
//   State<OtherUserProfileWidget> createState() => _OtherUserProfileWidgetState();
// }

// class _OtherUserProfileWidgetState extends State<OtherUserProfileWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       height: 0.55.sh,
//       decoration: BoxDecoration(
//         gradient: AppGradients.backgroundGradient,
//         borderRadius: widget.isRadius ? BorderRadius.circular(20.r) : BorderRadius.zero,
//         boxShadow: AppShadows.shadow2,
//         border: Border.all(color: AppColors.white, width: 2),
//         image: DecorationImage(
//           image: AssetImage(widget.image ?? AssetPath.tempImage1),
//           fit: BoxFit.cover,
//         ),
//       ),
//       child: Stack(
//         // mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           ShadowContainer(),
//           nameWidget(),
//           heartWidget(),
//         ],
//       ),
//     );
//   }

//   Widget heartWidget() {
//     return Visibility(
//       visible: widget.isHeartShow,
//       child: Positioned(
//         right: 30.w,
//         bottom: widget.bottomPadding != null ? (widget.bottomPadding ?? 0 + 20) : 40.h,
//         child: GestureDetector(
//           onTap: () {
//             setState(() {
//               widget.isHeart = !widget.isHeart;
//             });
//           },
//           child: Icon(
//             widget.isHeart ? Icons.favorite : Icons.favorite_outline,
//             size: 40.sp,
//             color: AppColors.black,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget nameWidget() {
//     return Positioned(
//       bottom: widget.bottomPadding ?? 20.h,
//       child: Padding(
//         padding: const EdgeInsets.all(AppPadding.padding12),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           // mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             CustomText(
//               text: AppStrings.dummyName,
//               color: AppColors.white,
//               fontWeight: FontWeight.bold,
//               fontSize: 24.sp,
//             ),
//             CustomText(
//               text: AppStrings.dummyName,
//               color: AppColors.white,
//               // fontWeight: FontWeight.bold,
//               // fontSize: 16.sp,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
