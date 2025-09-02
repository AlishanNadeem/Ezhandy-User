// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:ezhandy_user/utils/app_strings.dart';
// import 'package:ezhandy_user/utils/asset_path.dart';
// import 'package:ezhandy_user/utils/routes/app_navigation.dart';
// import 'package:ezhandy_user/utils/routes/app_route.dart';
// import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';
// import 'package:ezhandy_user/widgets/toast_dialogs_sheet/custom_bottom_sheet.dart';

// // ignore: must_be_immutable
// class PrivatePublicBottomSheet extends StatefulWidget {
//   PrivatePublicBottomSheet({super.key});

//   @override
//   State<PrivatePublicBottomSheet> createState() => _PrivatePublicBottomSheetState();
// }

// class _PrivatePublicBottomSheetState extends State<PrivatePublicBottomSheet> {
//   // SfRangeValues _values = SfRangeValues(2, 6);

//   @override
//   Widget build(BuildContext context) {
//     return CustomBottomSheet(
//       isPadding: false,
//       isTopPadding: false,
//       showCross: true,
//       height: 0.2.sh,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           singleRowWidget(
//               image: AssetPath.lockSettingsIcon,
//               title: AppStrings.private,
//               ontap: () {
//                 AppNavigation.navigateReplacementNamed(context, AppRoutes.createEventScreenRoute);
//               }),
//           10.verticalSpace,
//           Divider(),
//           10.verticalSpace,
//           singleRowWidget(
//               image: AssetPath.publicIcon,
//               title: AppStrings.public,
//               ontap: () {
//                 AppNavigation.navigateReplacementNamed(context, AppRoutes.createEventScreenRoute);
//               }),
//         ],
//       ),
//     );
//   }

//   GestureDetector singleRowWidget({void Function()? ontap, required String image, required String title}) {
//     return GestureDetector(
//       onTap: ontap,
//       child: Row(
//         children: [
//           30.horizontalSpace,
//           Image.asset(
//             image,
//             // scale: 3.sp,
//             width: 20.w,
//             height: 20.h,
//           ),
//           20.horizontalSpace,
//           CustomText(
//             text: title,
//             fontSize: 18.sp,
//           ),
//         ],
//       ),
//     );
//   }
// }
