// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:ezhandy_user/utils/app_colors.dart';
// import 'package:ezhandy_user/utils/app_strings.dart';
// import 'package:ezhandy_user/widgets/Container/custom_container.dart';
// import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';

// class UserCard extends StatelessWidget {
//   void Function()? onLikeTap;
//   bool isHeart;
//   String image;
//   String? name, address;
//   double? height, width;
//   UserCard({required this.image, this.height, this.width, required this.isHeart, this.onLikeTap, this.name, this.address, super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: height,
//       width: width,
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10.r),
//           border: Border.all(color: AppColors.backButtonPurple),
//           image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover)),
//       child: Align(
//         alignment: Alignment.bottomCenter,
//         child: CustomContainer(
//             isPadding: false,
//             radius: 10.r,
//             width: 1.sw,
//             isGradient: true,
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [nameWidget(), heartWidget(ontap: onLikeTap, isHeart: isHeart)],
//               ),
//             )),
//       ),
//     );
//   }

//   Widget heartWidget({void Function()? ontap, required bool isHeart}) {
//     return GestureDetector(
//       onTap: ontap,
//       child: Icon(
//         isHeart ? Icons.favorite : Icons.favorite_border,
//         size: 20.sp,
//         color: isHeart ? AppColors.darkRed : AppColors.white,
//       ),
//     );
//   }

//   Widget nameWidget() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         CustomText(
//           text: name ?? AppStrings.dummyName,
//           color: AppColors.white,
//           fontWeight: FontWeight.bold,
//           // fontSize: 18.sp,
//         ),
//         CustomText(
//           text: address ?? AppStrings.dummyName,
//           color: AppColors.white,
//           // fontWeight: FontWeight.bold,
//           fontSize: 12.sp,
//         ),
//       ],
//     );
//   }
// }
