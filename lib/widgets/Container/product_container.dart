// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:ezhandy_user/utils/app_colors.dart';
// import 'package:ezhandy_user/utils/asset_path.dart';
// import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';

// class ProductContainer extends StatefulWidget {
//   final String name;
//   final String image;
//   final String description;
//   final num price;
//   double? height, width;
//   bool isGradient, isHeartShow, isHeart;

//   ProductContainer({
//     this.height,
//     this.width,
//     this.isGradient = true,
//     this.isHeartShow = true,
//     this.isHeart = false,
//     required this.name,
//     required this.image,
//     required this.description,
//     required this.price,
//   });

//   @override
//   State<ProductContainer> createState() => _ProductContainerState();
// }

// class _ProductContainerState extends State<ProductContainer> {
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Container(
//           height: widget.height ?? 210.h,
//           width: widget.width ?? 217.w,
//           padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(15),
//               color: AppColors.white,
//               gradient: widget.isGradient
//                   ? LinearGradient(
//                       begin: Alignment.topCenter,
//                       end: Alignment.bottomCenter,
//                       colors: [
//                         Color(0xffE9C3FF),
//                         Color(0xffF6F6F6),
//                       ],
//                     )
//                   : null,
//               border: Border.all(color: Color(0xff7272FF))),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               20.verticalSpace,
//               Center(
//                 child: Image.asset(
//                   AssetPath.tempImage1,
//                   height: 90.h,
//                   width: 1.sw,
//                 ),
//               ),
//               10.verticalSpace,
//               CustomText(text: widget.name, fontWeight: FontWeight.w500, fontSize: 14.sp, color: Color(0xff4A4A4A)),
//               // 2.verticalSpace,
//               CustomText(text: widget.description, fontWeight: FontWeight.w500, fontSize: 14.sp, color: Color(0xff4A4A4A)),
//               // 1.verticalSpace,
//               CustomText(text: "\$${widget.price.toStringAsFixed(2)}", color: Color(0xff4A4A4A), fontSize: 14.sp, fontWeight: FontWeight.w300)
//             ],
//           ),
//         ),
//         Visibility(
//           visible: widget.isHeartShow,
//           child: Positioned(
//             top: 15,
//             right: 20,
//             child: GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     widget.isHeart = !widget.isHeart;
//                   });
//                 },
//                 child: Icon(widget.isHeart ? Icons.favorite : Icons.favorite_border,
//                     color: widget.isHeart ? AppColors.darkRed : Color(0xff7272FF), size: 24)),
//           ),
//         ),
//       ],
//     );
//   }
// }
