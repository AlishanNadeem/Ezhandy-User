// import 'package:ezhandy_user/utils/app_padding.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:ezhandy_user/module/auth/content/routing_arguments/content_routing_arguments.dart';
// import 'package:ezhandy_user/utils/app_colors.dart';
// import 'package:ezhandy_user/utils/app_dialogs.dart';
// import 'package:ezhandy_user/utils/app_strings.dart';
// import 'package:ezhandy_user/utils/asset_path.dart';
// import 'package:ezhandy_user/utils/enums.dart';
// import 'package:ezhandy_user/utils/routes/app_navigation.dart';
// import 'package:ezhandy_user/utils/routes/app_route.dart';
// import 'package:ezhandy_user/widgets/logo_and_backgrounds/app_logo.dart';
// import 'package:ezhandy_user/widgets/profile_widget/user_image_widget.dart';
// import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';

// class Menu extends StatefulWidget {
//   const Menu({super.key});

//   @override
//   State<Menu> createState() => _MenuState();
// }

// class _MenuState extends State<Menu> {
//   bool isExpanded = false;
//   final ExpansionTileController _controller = ExpansionTileController();
//   String selectedValue = "1 Minute"; // Default selected

//   List<VoidCallback> tapList = [];
//   @override
//   void initState() {
//     tapList = [
//       _myProfileTap,
//       _transcationHistoryTap,
//       _affiliateEarningTap,
//       _historyOfBookingsTap,
//       _favouritesTap,
//       _aboutUsTap,
//       _marketPlaceTap,
//       // _orderTap,
//       // _myOrderTap,
//       _contactUsTap,
//       _privacyPolicyTap,
//       _refundPolicyTap,
//       _signOutTap,
//       _deleteAccountTap,
//     ];
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Column(
//         children: [
//           10.verticalSpace,
//           AppLogo(),
//           10.verticalSpace,
//           profileHeader(),
//           30.verticalSpace,
//           Divider(
//             color: AppColors.blueDark,
//           ),
//           _menuListWidget(context),
//         ],
//       ),
//     );
//   }

//   Widget _menuListWidget(context) {
//     return Expanded(
//       child: ListView.separated(
//         shrinkWrap: true,
//         itemCount: AppStrings.menuList.length,
//         padding: EdgeInsets.zero,
//         itemBuilder: (BuildContext ctxt, int index) {
//           // if (index == 6) {
//           //   // Show ExpansionTile instead of normal row
//           //   return expansionWidget(context, index);
//           // } else {
//           // Normal tile
//           return Padding(
//             padding: EdgeInsets.symmetric(vertical: 10.h),
//             child: menuListTile(
//               isArrowShow: !(index == AppStrings.menuList.length - 1),
//               assetPath: AssetPath.menuIconList[index],
//               title: AppStrings.menuList[index],
//               onTap: tapList[index],
//             ),
//           );
//           // }
//         },
//         separatorBuilder: (BuildContext context, int index) {
//           return 5.verticalSpace;
//           // return Divider(color: AppColors.grey);
//         },
//       ),
//     );
//   }

//   Theme expansionWidget(context, int index) {
//     return Theme(
//       data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
//       child: ExpansionTile(
//         tilePadding: EdgeInsets.zero,
//         controller: _controller,
//         // collapsedIconColor: AppColors.green,
//         onExpansionChanged: (expanded) {
//           setState(() {
//             isExpanded = expanded;
//           });
//         },
//         trailing: AnimatedRotation(
//           duration: const Duration(milliseconds: 200),
//           turns: isExpanded ? 0.25 : 0, // rotate when expanded
//           child: const Icon(
//             Icons.arrow_forward_ios_rounded,
//             color: AppColors.orange,
//           ),
//         ),
//         leading: Image.asset(
//           AssetPath.menuIconList[index],
//           height: 30.h,
//           width: 30.w,
//           color: AppColors.orange,
//         ),
//         title: CustomText(
//           text: AppStrings.menuList[index],
//           fontSize: 16.sp,
//         ),
//         children: [
//           ListTile(
//             contentPadding: EdgeInsets.only(left: 70, right: 0),
//             title: const Text("Products"),
//             onTap: () {
//               setState(() {
//                 // selectedValue = item;
//                 isExpanded = false;
//               });
//               _controller.collapse();
//               AppNavigation.navigateTo(
//                   context, AppRoutes.marketPlaceScreenRoute);
//             },
//             trailing: const Icon(
//               Icons.arrow_forward_ios_rounded,
//               color: AppColors.orange,
//             ),
//           ),
//           ListTile(
//             contentPadding: EdgeInsets.only(left: 70, right: 0),
//             title: const Text("order"),
//             onTap: () {
//               setState(() {
//                 // selectedValue = item;
//                 isExpanded = false;
//               });
//               _controller.collapse();
//               AppNavigation.navigateTo(context, AppRoutes.ordersScreenRoute);
//             },
//             trailing: const Icon(
//               Icons.arrow_forward_ios_rounded,
//               color: AppColors.orange,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget menuListTile(
//       {required String title,
//       required String assetPath,
//       bool isArrowShow = false,
//       required VoidCallback onTap}) {
//     return GestureDetector(
//         onTap: onTap,
//         child: Row(
//           children: [
//             Image.asset(
//               assetPath,
//               height: 30.h,
//               width: 30.w,
//               // scale: 3.sp,
//               color: AppColors.orange,
//             ),
//             25.horizontalSpace,
//             CustomText(
//               text: title,
//               // color: AppColors.darkPink,
//               fontSize: 16.sp,
//               // maxLines: 2,
//               // textAlign: TextAlign.start,
//               // fontFamily: AppFonts.Jones_Bold,
//             ),
//             Spacer(),
//             isArrowShow
//                 ? Icon(
//                     Icons.arrow_forward_ios_rounded,
//                     color: AppColors.orange,
//                   )
//                 : SizedBox.shrink()
//           ],
//         ));
//   }

//   Row profileHeader() {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         // profileWidget(),
//         UserImageWidget(
//           size: 40.sp,
//         ),

//         10.horizontalSpace,
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             CustomText(
//               align: Alignment.center,
//               // fontWeight: FontWeight.bold,
//               fontSize: 20.sp,
//               text: AppStrings.dummyName,
//               color: AppColors.blueDark,

//               // "${Utils.capitalizeWords(AuthController.i.appUser.value.data?.firstName ?? "")} ${Utils.capitalizeWords(AuthController.i.appUser.value.data?.lastName ?? "")}",
//               // color: AppColors.WHITE_COLOR,
//             ),
//             CustomText(
//                 align: Alignment.center,
//                 // fontWeight: FontWeight.  ,
//                 fontSize: 14.sp,
//                 text: AppStrings.dummyEmail,
//                 color: AppColors.grey),
//           ],
//         ),
//       ],
//     );
//   }

//   void _myProfileTap() {
//     AppNavigation.navigateTo(context, AppRoutes.userProfileScreenRoute);
//   }

//   void _transcationHistoryTap() {
//     AppNavigation.navigateTo(context, AppRoutes.transactionHistoryScreenRoute);
//   }

//   void _affiliateEarningTap() {
//     AppNavigation.navigateTo(context, AppRoutes.affiliateEarningScreenRoute);
//   }

//   void _privacyPolicyTap() {
//     AppNavigation.navigateTo(context, AppRoutes.contentScreenRoute,
//         arguments: ContentRoutingArgument(
//             title: AppStrings.privacyPolicy, type: WebContentType.pp.name));
//   }

//   void _aboutUsTap() {
//     AppNavigation.navigateTo(context, AppRoutes.contentScreenRoute,
//         arguments: ContentRoutingArgument(
//             title: AppStrings.aboutUs, type: WebContentType.ap.name));
//   }

//   void _marketPlaceTap() {
//     AppNavigation.navigateTo(context, AppRoutes.marketPlaceScreenRoute);

//     // AppNavigation.navigateTo(context, AppRoutes.contentScreenRoute,
//     //     arguments: ContentRoutingArgument(
//     //         title: AppStrings.aboutUs, type: WebContentType.ap.name));
//   }

//   void _myOrderTap() {
//     // AppNavigation.navigateTo(context, AppRoutes.contentScreenRoute,
//     //     arguments: ContentRoutingArgument(
//     //         title: AppStrings.aboutUs, type: WebContentType.ap.name));
//   }
//   void _orderTap() {
//     // AppNavigation.navigateTo(context, AppRoutes.contentScreenRoute,
//     //     arguments: ContentRoutingArgument(
//     //         title: AppStrings.aboutUs, type: WebContentType.ap.name));
//   }

//   void _refundPolicyTap() {
//     AppNavigation.navigateTo(context, AppRoutes.contentScreenRoute,
//         arguments: ContentRoutingArgument(
//             title: AppStrings.refundPolicy, type: WebContentType.rp.name));
//   }

//   void _contactUsTap() {
//     AppNavigation.navigateTo(context, AppRoutes.contactUsScreenRoute);
//   }

//   void _historyOfBookingsTap() {
//     AppNavigation.navigateTo(context, AppRoutes.bookingHistoryScreenRoute);
//   }

//   void _favouritesTap() {
//     AppNavigation.navigateTo(context, AppRoutes.favouritesScreenRoute);
//   }

//   void _signOutTap() {
//     AppDialogs.showSuccessDialog(context,
//         description: AppStrings.confirmationDialogLogoutDescription,
//         title: AppStrings.logout,
//         image: AssetPath.alertIcon,
//         isDoneShow: false,
//         btnTxt1: AppStrings.no,
//         onTap1: () {
//           AppNavigation.navigatorPop(context);
//         },
//         btnTxt2: AppStrings.yes,
//         onTap2: () {
//           AppNavigation.navigateToRemovingAll(
//               context, AppRoutes.loginScreenRoute);
//         });
//   }

//   void _deleteAccountTap() {
//     AppDialogs.showSuccessDialog(context,
//         description: AppStrings.areYouSureWantToDeleteThisAccount,
//         title: AppStrings.deleteAccount,
//         image: AssetPath.alertIcon,
//         isDoneShow: false,
//         btnTxt1: AppStrings.no,
//         onTap1: () {
//           AppNavigation.navigatorPop(context);
//         },
//         btnTxt2: AppStrings.yes,
//         onTap2: () {
//           AppNavigation.navigatorPop(context);
//           AppDialogs.showSuccessDialog(
//             context,
//             description: AppStrings.accountDeleteSuccessfully,
//             title: AppStrings.congratulation,
//             btnTxt1: AppStrings.ok,
//             onTap1: () {
//               AppNavigation.navigateToRemovingAll(
//                   context, AppRoutes.loginScreenRoute);
//             },
//           );
//         });
//   }
// }
