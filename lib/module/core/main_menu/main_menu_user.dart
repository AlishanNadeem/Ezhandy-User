import 'dart:io';
import 'package:ezhandy_user/module/auth/controller/auth_controller.dart';
import 'package:ezhandy_user/module/core/booking/view/my_booking.dart';
import 'package:ezhandy_user/module/core/chat/view/messages.dart';
import 'package:ezhandy_user/module/core/community/view/community.dart';
import 'package:ezhandy_user/module/core/home/view/home.dart';
import 'package:ezhandy_user/module/core/main_menu/drawer_screen.dart';
import 'package:ezhandy_user/module/core/menu/view/menu.dart';
import 'package:ezhandy_user/utils/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ezhandy_user/module/core/controller/home_controller.dart';
import 'package:ezhandy_user/utils/app_dialogs.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/utils/app_padding.dart';
import 'package:ezhandy_user/utils/app_strings.dart';
import 'package:ezhandy_user/utils/asset_path.dart';
import 'package:ezhandy_user/utils/routes/app_navigation.dart';
import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';
  GlobalKey<ScaffoldState> globalkey = new GlobalKey<ScaffoldState>();

class MainMenu extends StatefulWidget {
  // int selectedTab;
  MainMenu(
      {
      // required this.selectedTab
      // ,
      Key? key})
      : super(key: key);

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  // int indexProfile = 4;
  // AuthController.i.appUser.value.data!.role == "User" ? 3 : 0;
  // String title = AppStrings.home;
  final List<Widget> _widgetOptions = [
    // ChatUserScreen(),
    Home(),
    // NotificationScreen(),
    // Menu()
    // Container(),
    MessagesScreen(),
    MyBooking(),
    // Menu(),
    CommunityScreen(),
  ];

  @override
  void initState() {
    HomeController.i.selectedTab.value = 0;

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    Future<bool> _onWillPop() async {
      return (await AppDialogs.showSuccessDialog(context,
              description: AppStrings.exitDialogueTitle,
              // title: AppStrings.logout,
              image: AssetPath.alertIcon,
              isDoneShow: false,
              btnTxt1: AppStrings.no,
              onTap1: () {
                AppNavigation.navigatorPop(context);
              },
              btnTxt2: AppStrings.yes,
              onTap2: () {
                exit(0);
              })) ??
          false;
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Obx(() {
        return GestureDetector(
            onTap: () {
              // FocusScope.of(context).unfocus();
            },
            child: Container(
              width: 1.sw,
              height: 1.sh,
              color: AppColors.white,
              child: Platform.isAndroid
                  ? SafeArea(
                      child: withoutSafeArea(),
                    )
                  : withoutSafeArea(),
            ));
      }),
    );
  }

  Scaffold withoutSafeArea() {
    return Scaffold(
      extendBodyBehindAppBar: false,
      key: globalkey,
      drawer: DrawerScreen(),
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.padding12),
        child: Column(
          children: [
            Platform.isAndroid ? 10.verticalSpace : 50.verticalSpace,
            _widgetOptions.elementAt(HomeController.i.selectedTab.value),
          ],
        ),
      ),
      bottomNavigationBar: bottom_navigation_bar(),
    );
  }

  Widget bottom_navigation_bar() {
    return Container(
        margin: EdgeInsets.only(
            left: AppPadding.padding12,
            right: AppPadding.padding12,
            bottom: Platform.isAndroid ? AppPadding.padding12 : 25.h),
        height: 0.09.sh,
        decoration: BoxDecoration(
            color: AppColors.orange,
            borderRadius: BorderRadius.circular(40.sp),
            boxShadow: [
              BoxShadow(
                  spreadRadius: 5,
                  blurRadius: 10,
                  color: const Color.fromARGB(255, 17, 16, 16).withOpacity(0.2))
            ]),
        child: committedUserNavigationWidget());
  }

  Row committedUserNavigationWidget() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      5.horizontalSpace,
      GestureDetector(
          onTap: () {
            if (!AuthController.i.isLoginSignUp.value) {
              signinSignUpPopup();
            } else {
              setState(() {
                HomeController.i.selectedTab.value = 0;
                // title = AppStrings.committedUserList[HomeController.i.selectedTab.value];
                // AppStrings.home;
                // SocketService.instance?.dispose();
                // HomeController.i.allOrderList.clear();
                // HomeController.i.allOrderList.refresh();
              });
            }
          },
          child: bottom_items(
              0,
              HomeController.i.selectedTab.value == 0
                  ? AssetPath.bottomBarFillIconList[0]
                  : AssetPath.bottomBarIconList[0],
              AppStrings.bottomBarList[0])),
      GestureDetector(
          onTap: () {
            if (!AuthController.i.isLoginSignUp.value) {
              signinSignUpPopup();
            } else {
              setState(() {
                HomeController.i.selectedTab.value = 1;
                // title = AppStrings.committedUserList[HomeController.i.selectedTab.value];
              });
            }
          },
          child: bottom_items(
              1,
              HomeController.i.selectedTab.value == 1
                  ? AssetPath.bottomBarFillIconList[1]
                  : AssetPath.bottomBarIconList[1],
              AppStrings.bottomBarList[1])),
      GestureDetector(
          onTap: () {
            if (!AuthController.i.isLoginSignUp.value) {
              signinSignUpPopup();
            } else {
              setState(() {
                HomeController.i.selectedTab.value = 2;
                // title = AppStrings.committedUserList[HomeController.i.selectedTab.value];
              });
            }
          },
          child: bottom_items(
              2,
              HomeController.i.selectedTab.value == 2
                  ? AssetPath.bottomBarFillIconList[2]
                  : AssetPath.bottomBarIconList[2],
              AppStrings.bottomBarList[2])),
      GestureDetector(
          onTap: () {
            if (!AuthController.i.isLoginSignUp.value) {
              signinSignUpPopup();
            } else {
              setState(() {
                HomeController.i.selectedTab.value = 3;
                // title = AppStrings.committedUserList[HomeController.i.selectedTab.value];
              });
            }
          },
          child: bottom_items(
              3,
              HomeController.i.selectedTab.value == 3
                  ? AssetPath.bottomBarFillIconList[3]
                  : AssetPath.bottomBarIconList[3],
              AppStrings.bottomBarList[3])),
      5.horizontalSpace,
    ]);
  }

  Widget bottom_items(inIndex, iconSelected, text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15.h),
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      decoration: BoxDecoration(
          color: HomeController.i.selectedTab.value == inIndex
              ? AppColors.white
              : null,
          borderRadius: BorderRadius.circular(35.r)),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Image.asset(
          iconSelected,
          width: 20.w,
          height: 20.h,
          // scale: 3.5.sp,
          // color: HomeController.i.selectedTab.value == inIndex
          //     ? AppColors.blueDark
          //     : null
        ),
        10.horizontalSpace,
        Visibility(
          visible: HomeController.i.selectedTab.value == inIndex,
          child: CustomText(
              // fontWeight: HomeController.i.selectedTab.value == inIndex
              //     ? FontWeight.bold
              //     : null,
              color: AppColors.black,
              text: text),
        ),
      ]),
    );
  }

  void signinSignUpPopup() {
    AppDialogs.showSuccessDialog(
      context,
      barrierDismissible: true,
      description: AppStrings.inOrderToAccessThis,
      // title: AppStrings.deleteDocument,
      image: AssetPath.tumbIcon,
      isDoneShow: false,
      btnTxt1: AppStrings.logIn.toUpperCase(),
      onTap1: () {
        AppNavigation.navigateToRemovingAll(
            context, AppRoutes.loginScreenRoute);
      },
      btnTxt2: AppStrings.signUp.toUpperCase(),
      onTap2: () {
        AppNavigation.navigateToRemovingAll(
            context, AppRoutes.loginScreenRoute);
        AppNavigation.navigateTo(context, AppRoutes.signupScreenRoute);
        // AppNavigation.navigatorPop(context);
      },
    );
  }
}
