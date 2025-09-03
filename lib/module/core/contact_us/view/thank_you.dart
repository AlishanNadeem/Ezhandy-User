
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:turn_n_burn/utils/app_strings.dart';
// import 'package:turn_n_burn/utils/asset_path.dart';
// import 'package:turn_n_burn/utils/routes/app_navigation.dart';
// import 'package:turn_n_burn/widgets/button_widgets/custom_button.dart';
// import 'package:turn_n_burn/widgets/logo_and_backgrounds/background.dart';
// import 'package:turn_n_burn/widgets/text_widgets/text_widget.dart';

// class ThankYou extends StatefulWidget {
//   ThankYou({super.key});

//   @override
//   State<ThankYou> createState() => _ThankYouState();
// }

// class _ThankYouState extends State<ThankYou> {
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();

//   TextEditingController titleController = TextEditingController();
//   TextEditingController detailController = TextEditingController();
//   List documentList = [];
//   // @override
//   // void initState() {
//   //   if (widget.type == AddEditType.edit.name) {
//   //     fillController();
//   //   }
//   //   // TODO: implement initState
//   //   super.initState();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return BackgroundImage(
//         // leading: AssetPath.backIcon,
//         // onclickLead: () {
//         //   Get.back();
//         // },
//         // appBarheight: 50.h,
//         // title: AppStrings.helpFeedback,
//         child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Image.asset(
//           AssetPath.checkIcon,
//           scale: 4.sp,
//           // color: AppColors.white,
//         ),
//         10.verticalSpace,
//         CustomText(
//             text: AppStrings.thankYou,
//             // color: AppColors.black,
//             fontsize: 18.sp,
//             fontWeight: FontWeight.bold,
//             is_alignLeft: false),
//         5.verticalSpace,
//         CustomText(
//             text: AppStrings.yourFeedbackHasBeenSubmitted,
//             // color: AppColors.black,
//             fontsize: 14.sp,
//             is_alignLeft: false),
//         15.verticalSpace,
//         buttonRowWidget(),
//       ],
//     ));
//   }

//   Widget buttonRowWidget() {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 120.w),
//       child: CustomButton(
//         onclick: () {
//           AppNavigation.navigatorPop(context);
//         },
//         height: 45.h,
//         text: AppStrings.goBack,
//         // color: AppColors.lightPink,
//         // textcolor: AppColors.black,
//       ),
//     );
//   }
// }
