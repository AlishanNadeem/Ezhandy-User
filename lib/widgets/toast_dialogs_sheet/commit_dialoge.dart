// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:ezhandy_user/utils/app_colors.dart';
// import 'package:ezhandy_user/utils/app_strings.dart';
// import 'package:ezhandy_user/utils/asset_path.dart';
// import 'package:ezhandy_user/utils/routes/app_navigation.dart';
// import 'package:ezhandy_user/widgets/button_widgets/custom_button.dart';
// import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';
// import 'package:ezhandy_user/widgets/toast_dialogs_sheet/custom_dialoge.dart';

// // ignore: must_be_immutable
// class CommitDialog extends StatelessWidget {
//   void Function()? onTap;
//   String name, bt1, bt2;
//   String? title;
//   CommitDialog({this.title, required this.bt1, required this.bt2, required this.name, this.onTap, super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: CustomDialogs(
//           onTap: () {
//             AppNavigation.navigatorPop(context);
//           },
//           isCross: true,
//           backgroundColor: AppColors.white,
//           // Heading: title,
//           child: Column(
//             children: [
//               // 30.h.verticalSpace,
//               // imageWidget(),
//               20.h.verticalSpace,
//               textWidget(),
//               40.h.verticalSpace,
//               Row(
//                 children: [
//                   15.w.horizontalSpace,
//                   Expanded(
//                     child: CustomButton(
//                         color: AppColors.black,
//                         height: 45.h,
//                         onclick: () {
//                           AppNavigation.navigatorPop(context);
//                         },
//                         fontWeight: FontWeight.normal,
//                         text: bt1),
//                   ),
//                   15.w.horizontalSpace,
//                   Expanded(
//                     child: CustomButton(
//                       height: 45.h,
//                       // isAuth: false,
//                       color: AppColors.black,
//                       // textcolor: AppColors.black,
//                       text: bt2,
//                       onclick: onTap,
//                       fontWeight: FontWeight.normal,
//                     ),
//                   ),
//                   15.w.horizontalSpace,
//                 ],
//               ),
//               15.h.verticalSpace,
//             ],
//           )),
//     );
//   }

//   Image imageWidget() {
//     return Image.asset(
//       AssetPath.circleCheckIcon,
//       scale: 4.sp,
//       // color: AppColors.backButtonPurple,
//     );
//   }

//   CustomText textWidget() {
//     return CustomText(
//       text: AppStrings.areYouSureYouWantToCommitTitle + name,
//       is_alignLeft: false,
//     );
//   }
// }
