import 'package:ezhandy_user/module/auth/controller/auth_controller.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ezhandy_user/module/auth/content/routing_arguments/content_routing_arguments.dart';
// import 'package:ezhandy_user/module/auth/controller/auth_controller.dart';
import 'package:ezhandy_user/module/core/home/controller/home_controller.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/utils/app_dialogs.dart';
import 'package:ezhandy_user/utils/app_strings.dart';
import 'package:ezhandy_user/utils/asset_path.dart';
import 'package:ezhandy_user/utils/enums.dart';
import 'package:ezhandy_user/utils/routes/app_navigation.dart';
import 'package:ezhandy_user/utils/routes/app_route.dart';
import 'package:ezhandy_user/widgets/button_widgets/cross_button.dart';
import 'package:ezhandy_user/widgets/logo_and_backgrounds/app_logo.dart';
import 'package:ezhandy_user/widgets/profile_widget/profile_picture_widget.dart';
import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';

import 'package:ezhandy_user/utils/network_strings.dart';

// ignore: must_be_immutable
class DrawerScreen extends StatefulWidget {
  // int navBarIndex;
  DrawerScreen({
    Key? key,
  }) : super(key: key);
  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  List<VoidCallback> tapList = [];
  // List<VoidCallback> driverTapList = [];
  // List<VoidCallback> _counselorTapList = [];
  // late bool isStudent;
  // late bool isParent;
  // bool switchOff = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    tapList = [
   _myProfileTap,
      _transcationHistoryTap,
      _affiliateEarningTap,
      _historyOfBookingsTap,
      _favouritesTap,
      _aboutUsTap,
      _marketPlaceTap,
      // _orderTap,
      // _myOrderTap,
      _contactUsTap,
      _privacyPolicyTap,
      _refundPolicyTap,
      _signOutTap,
      _deleteAccountTap,
    ];
    // driverTapList = [
    //   _homeTap,
    //   _historyTap,
    //   _walletTap,
    //   _settingTap,
    // ];
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.transparent,
      surfaceTintColor: AppColors.transparent,
      shadowColor: AppColors.transparent,
      width: 0.8.sw,
      child:
          //  Stack(
          //   children: [
          Container(
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(25.sp),
                bottomRight: Radius.circular(25.sp))
            // image: DecorationImage(
            //     image: AssetImage(AssetPath.drawerBackgroundImage),
            //     fit: BoxFit.cover)
            ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 20.w),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.only(top: 20.h, right: 5.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // AppLogo(
                        //   assetPath: AssetPath.appLogoImage,
                        //   scale: 3.sp,

                        // ),
                        AppLogo(),

                        CrossButton(
                            circleColor: AppColors.orange,
                            iconColor: AppColors.white),
                      ],
                    ),
                  ),
                ),
                profileHeader(),
                30.verticalSpace,
                // goOfflineWidget(),
                // SizedBox(height: 20.h),
                Divider(color: AppColors.blueDark),
                _menuListWidget(context: context),
                // const Spacer(),
                // _logoutButton(),
                // SizedBox(height: 10.h),
                // const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Padding goOfflineWidget() {
  //   return Padding(
  //     padding: EdgeInsets.symmetric(horizontal: 20.w),
  //     child: Row(
  //       children: [
  //         AnimatedSwitch(
  //           switchButtonColor: AppColors.white,
  //           offColor: AppColors.iconGrey,
  //           onColor: AppColors.backButtonPurple,
  //           isSwitched: switchOff,
  //           onCallBack: (p0) {
  //             setState(() {
  //               switchOff = p0;
  //             });
  //           },
  //         ),
  //         15.horizontalSpace,
  //         CustomText(
  //           text: AppStrings.goOffline,
  //         ),
  //       ],
  //     ),
  //   );
  // }

  ProfilePictureWidget profileWidget() {
    return ProfilePictureWidget(
      size: 60.sp,
      // showUpload: widget.type == ProfileType.edit.name,
      // upload_icon:
      //     args == AppStrings.CREATE_PROFILE ? false : true,
      is_pickImage: false,

      // is_pickImage:
      //     args == AppStrings.CREATE_PROFILE ? true : false,
      // setFile: _setFile,
       profileImageUrl:
           "${AuthController.i.appUser.value.data?.userModel?.profileImage ?? ''}",
        // profileImage: _profileImage,
        assetPath:
            // args == AppStrings.CREATE_PROFILE
            //     ?
            null
      // borderWidth:
      // args == AppStrings.CREATE_PROFILE ? null :
      // 5,
    );
  }

  Row profileHeader() {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        profileWidget(),
        10.horizontalSpace,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
                // align: Alignment.center,
                fontWeight: FontWeight.w600,
                fontSize: 18.sp,
                text:
                    "${Utils.capitalizeWords(AuthController.i.appUser.value.data?.userModel?.fullName ?? "dummy")}"),
            CustomText(
              // align: Alignment.center,
              // fontWeight: FontWeight.w600,
              fontSize: 12.sp,
              text: AuthController.i.appUser.value.data?.userModel?.email,
            ),
          ],
        ),
      ],
    );
  }

  // Widget _onTapProfileName() {
  //   return GestureDetector(
  //     onTap: _navigateViewProfile,
  //     child: Column(
  //       children: [
  //         CustomSizeBox(height: 40.h),
  //         _profileAvator(),
  //         const CustomSizeBox(),
  //         _userName(),
  //       ],
  //     ),
  //   );
  // }

  // Widget _profileAvator() {
  //   return CustomViewProfileAvator(
  //     imagePath: AssetPaths.dummyUserIcon,
  //     placeHolderImage: AssetPaths.dummyUserIcon,
  //     borderWidth: 8.w,
  //     isFile: false,
  //   );
  // }

  // Widget _userName() {
  //   return CustomText(
  //     text: AppStrings.lisaMarie,
  //     fontSize: 16.sp,
  //     fontFamily: AppFonts.Jones_Bold,
  //   );
  // }

  Widget _menuListWidget({required BuildContext context}) {
    return Expanded(
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: AppStrings.menuList.length,
        padding: EdgeInsets.zero,
        itemBuilder: (BuildContext ctxt, int index) {
          return Padding(
              padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 0.w),
              child: menuListTile(
                  // context: context,
                  assetPath: AssetPath.menuIconList[index],
                  title: AppStrings.menuList[index],
                  index: index,
                  onTap:
                      //  AuthController.i.role == RoleType.driver.name
                      //     ? driverTapList[index]
                      //     :
                      tapList[index]));
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            height: 10.h,
          );
        },
      ),
    );
  }

  Widget menuListTile(
      {required String title,
      required String assetPath,
      required int index,
      required VoidCallback onTap}) {
    return GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Image.asset(
              assetPath,
              height: 20.h,
              width: 20.w,
              // scale: 3.sp,
              color: AppColors.orange,
            ),
            25.horizontalSpace,
            CustomText(
              text: title,
              color: null,
              // fontSize: 14.sp,
              // maxLines: 2,
              // textAlign: TextAlign.start,
              // fontFamily: AppFonts.Jones_Bold,
            ),
          ],
        ));
  }

  void _myProfileTap() {
    AppNavigation.navigatorPop(context);

    AppNavigation.navigateTo(context, AppRoutes.userProfileScreenRoute);
  }

  // void _myProfileTap() {
  //   AppNavigation.navigateTo(context, AppRoutes.userProfileScreenRoute);
  // }

  void _transcationHistoryTap() {    AppNavigation.navigatorPop(context);

    AppNavigation.navigateTo(context, AppRoutes.transactionHistoryScreenRoute);
  }

  void _affiliateEarningTap() {    AppNavigation.navigatorPop(context);

    AppNavigation.navigateTo(context, AppRoutes.affiliateEarningScreenRoute);
  }

  void _privacyPolicyTap() {    AppNavigation.navigatorPop(context);

    AppNavigation.navigateTo(context, AppRoutes.contentScreenRoute,
        arguments: ContentRoutingArgument(
            title: AppStrings.privacyPolicy, type: WebContentType.pp.name));
  }

  void _aboutUsTap() {    AppNavigation.navigatorPop(context);

    AppNavigation.navigateTo(context, AppRoutes.contentScreenRoute,
        arguments: ContentRoutingArgument(
            title: AppStrings.aboutUs, type: WebContentType.ap.name));
  }

  void _marketPlaceTap() {    AppNavigation.navigatorPop(context);

    AppNavigation.navigateTo(context, AppRoutes.marketPlaceScreenRoute);

    // AppNavigation.navigateTo(context, AppRoutes.contentScreenRoute,
    //     arguments: ContentRoutingArgument(
    //         title: AppStrings.aboutUs, type: WebContentType.ap.name));
  }

  void _myOrderTap() {    AppNavigation.navigatorPop(context);

    // AppNavigation.navigateTo(context, AppRoutes.contentScreenRoute,
    //     arguments: ContentRoutingArgument(
    //         title: AppStrings.aboutUs, type: WebContentType.ap.name));
  }
  void _orderTap() {    AppNavigation.navigatorPop(context);

    // AppNavigation.navigateTo(context, AppRoutes.contentScreenRoute,
    //     arguments: ContentRoutingArgument(
    //         title: AppStrings.aboutUs, type: WebContentType.ap.name));
  }

  void _refundPolicyTap() {    AppNavigation.navigatorPop(context);

    AppNavigation.navigateTo(context, AppRoutes.contentScreenRoute,
        arguments: ContentRoutingArgument(
            title: AppStrings.refundPolicy, type: WebContentType.rp.name));
  }

  void _contactUsTap() {    AppNavigation.navigatorPop(context);

    AppNavigation.navigateTo(context, AppRoutes.contactUsScreenRoute);
  }

  void _historyOfBookingsTap() {    AppNavigation.navigatorPop(context);

    AppNavigation.navigateTo(context, AppRoutes.bookingHistoryScreenRoute);
  }

  void _favouritesTap() {    AppNavigation.navigatorPop(context);

    AppNavigation.navigateTo(context, AppRoutes.favouritesScreenRoute);
  }

  void _signOutTap() {
    
          AppDialogs.showSuccessDialog(context,
              description: AppStrings.confirmationDialogLogoutDescription,
              title: AppStrings.logout,
              image: AssetPath.alertIcon,
              isDoneShow: false,
              btnTxt1: AppStrings.no,
              onTap1: () {
                AppNavigation.navigatorPop(context);
              },
              btnTxt2: AppStrings.yes,
              onTap2: () {
                AuthController.i.logout(context);

                // AppNavigation.navigateToRemovingAll(
                //     context, AppRoutes.loginScreenRoute);
              });
        
     
  }

  void _deleteAccountTap() {
    AppDialogs.showSuccessDialog(context,
        description: AppStrings.areYouSureWantToDeleteThisAccount,
        title: AppStrings.deleteAccount,
        image: AssetPath.alertIcon,
        isDoneShow: false,
        btnTxt1: AppStrings.no,
        onTap1: () {
          AppNavigation.navigatorPop(context);
        },
        btnTxt2: AppStrings.yes,
        onTap2: () {
          AppNavigation.navigatorPop(context);
          AppDialogs.showSuccessDialog(
            context,
            description: AppStrings.accountDeleteSuccessfully,
            title: AppStrings.congratulation,
            btnTxt1: AppStrings.ok,
            onTap1: () {
              AppNavigation.navigateToRemovingAll(
                  context, AppRoutes.loginScreenRoute);
            },
          );
        });
  }

  // void _homeTap() {
  //   AppNavigation.navigatorPop(context);
  //   HomeController.i.selectedTab.value = 0;
  //   // AppNavigation.navigateTo(context, AppRoutes.mainMenuScreenRoute);
  // }

  // void _privacyPolicyTap() {
  //   AppNavigation.navigatorPop(context);
  //   AppNavigation.navigateTo(context, AppRoutes.contentScreenRoute,
  //       arguments: ContentRoutingArgument(
  //           title: AppStrings.privacyPolicy, type: WebContentType.pp.name));
  // }

  // void _subscriptionTap() {
  //   AppNavigation.navigatorPop(context);
  //   AppNavigation.navigateTo(context, AppRoutes.subscriptionScreenRoute);
  // }

  // void _contactUsTap() {
  //   AppNavigation.navigatorPop(context);
  //   AppNavigation.navigateTo(context, AppRoutes.contactUsScreenRoute);
  // }

  // void _aboutUsTap() {
  //   AppNavigation.navigatorPop(context);
  //   AppNavigation.navigateTo(context, AppRoutes.contentScreenRoute,
  //       arguments: ContentRoutingArgument(
  //           title: AppStrings.aboutUs, type: WebContentType.ap.name));
  // }

  // Widget _logoutButton() {
  //   return Align(
  //     alignment: Alignment.topLeft,
  //     child: GestureDetector(
  //       onTap: () {
  //         AppDialogs.showSuccessDialog(context,
  //             description: AppStrings.confirmationDialogLogoutDescription,
  //             title: AppStrings.logout,
  //             image: AssetPath.checkCircleIcon,
  //             isDoneShow: false,
  //             btnTxt1: AppStrings.no,
  //             onTap1: () {
  //               AppNavigation.navigatorPop(context);
  //             },
  //             btnTxt2: AppStrings.yes,
  //             onTap2: () {
  //               AppNavigation.navigateToRemovingAll(
  //                   context, AppRoutes.loginScreenRoute);
  //             });
  //       },
  //       child: Container(
  //         padding: EdgeInsets.only(top: 14.h, bottom: 14.h),
  //         width: 180.w,
  //         // decoration: BoxDecoration(
  //         //     // color: AppColors.backButtonPurple,
  //         //     borderRadius: BorderRadius.only(
  //         //       topRight: Radius.circular(35.sp),
  //         //       bottomRight: Radius.circular(35.sp),
  //         //     )),
  //         child: Row(
  //           children: [
  //             // 20.horizontalSpace,
  //             Image.asset(
  //               AssetPath.logoutIcon,
  //               height: 20.h,
  //               width: 20.w,
  //             ),
  //             20.horizontalSpace,
  //             CustomText(
  //                 is_alignLeft: false,
  //                 text: AppStrings.logout,
  //                 color: AppColors.red,
  //                 fontSize: 18.sp),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // void _signOutTap() {
  //   AppDialogs.showSuccessDialog(context,
  //       description: AppStrings.confirmationDialogLogoutDescription,
  //       title: AppStrings.logout,
  //       image: AssetPath.logoutPopupIcon,
  //       isDoneShow: false,
  //       btnTxt1: AppStrings.no,
  //       onTap1: () {
  //         AppNavigation.navigatorPop(context);
  //       },
  //       btnTxt2: AppStrings.yes,
  //       onTap2: () {
  //         AppNavigation.navigateToRemovingAll(
  //             context, AppRoutes.loginScreenRoute);
  //       });
  // }

  // void _deleteAccountTap() {
  //   AppDialogs.showSuccessDialog(context,
  //       description: AppStrings.areYouSureWantToDeleteThisAccount,
  //       title: AppStrings.deleteAccount,
  //       image: AssetPath.deleteIcon,
  //       isDoneShow: false,
  //       btnTxt1: AppStrings.no,
  //       onTap1: () {
  //         AppNavigation.navigatorPop(context);
  //       },
  //       btnTxt2: AppStrings.yes,
  //       onTap2: () {
  //         AppNavigation.navigatorPop(context);
  //         AppDialogs.showSuccessDialog(
  //           context,
  //           description: AppStrings.accountDeleteSuccessfully,
  //           title: AppStrings.congratulation,
  //           btnTxt1: AppStrings.ok,
  //           onTap1: () {
  //             AppNavigation.navigateToRemovingAll(
  //                 context, AppRoutes.loginScreenRoute);
  //           },
  //         );
  //       });
  // }

  // /// Functions...

  // void _onTapBtn() {
  //   AppNavigation.navigateToRemovingAll(
  //       context, AppRouteName. dropShipperSelectionScreenRoute);
  //   AppDialogs.showToast(message: AppStrings.logoutSuccessful);
  // }

  // void _navigateViewProfile() {
  //   AppNavigation.navigateToRemovingAll(
  //       context, AppRouteName.mainMenuScreenRoute,
  //       arguments: MainMenuRoutingArguments(selectedIndex: 4));
  // }
}
