// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:ezhandy_user/module/auth/controller/auth_controller.dart';
// import 'package:ezhandy_user/module/core/home/controller/home_controller.dart';
// import 'package:ezhandy_user/utils/app_padding.dart';
// import 'package:ezhandy_user/utils/app_strings.dart';
// import 'package:ezhandy_user/utils/asset_path.dart';
// import 'package:ezhandy_user/utils/constant.dart';
// import 'package:ezhandy_user/utils/enums.dart';
// import 'package:ezhandy_user/utils/routes/app_navigation.dart';
// import 'package:ezhandy_user/utils/routes/app_route.dart';
// import 'package:ezhandy_user/widgets/button_widgets/custom_button.dart';
// import 'package:ezhandy_user/widgets/logo_and_backgrounds/background.dart';
// import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';

// // ignore: must_be_immutable
// class CommonSuccessScreen extends StatelessWidget {
//   String buttonText, mainText;
//   void Function()? onclick;
//   bool isBack;
//   CommonSuccessScreen(
//       {required this.buttonText,
//       required this.mainText,
//       this.onclick,
//       this.isBack = false,
//       super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BackgroundImage(
//         is_registration: false,
//         child: Padding(
//           padding: EdgeInsets.symmetric(
//               horizontal: AppPadding.defaultHorizontalPadding12),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Image.asset(AssetPath.checkPopIcon, scale: 2.5.sp),
//               20.verticalSpace,
//               CustomText(
//                   text: mainText ?? AppStrings.bestWishes, is_alignLeft: false),
//               20.verticalSpace,
//               btnWidget(context),
//               if (isBack) 20.verticalSpace,
//               if (isBack) btnHomeWidget(context),
//             ],
//           ),
//         ));
//   }

//   Widget btnWidget(BuildContext context) {
//     return CustomButton(
//       onclick:

//           //  () {
//           //   AppNavigation.navigateTo(context, AppRoutes.eventDetailsScreenRoute);
//           // },
//           onclick,
//       // ??
//       //     () {
//       //       AppNavigation.navigatorPop(context);
//       //     },
//       isAuth: false,
//       text: buttonText.toUpperCase(),
//     );
//   }

//   Widget btnHomeWidget(BuildContext context) {
//     return CustomButton(
//       onclick: () {
//         if (AuthController.i.role.value == RoleType.single.name) {
//           HomeController.i.selectedTab.value = 0;
//         } else {
//           HomeController.i.selectedTab.value = 1;
//         }
//         AppNavigation.navigatorPopUntil(Constants.navigatorKey.currentContext!,
//             AppRoutes.userMainMenuScreenRoute);
//       },

//       // ??
//       //     () {
//       //       AppNavigation.navigatorPop(context);
//       //     },
//       isAuth: false,
//       text: "Home".toUpperCase(),
//     );
//   }
// }
