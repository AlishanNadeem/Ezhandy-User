import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ezhandy_user/module/auth/content/routing_arguments/content_routing_arguments.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/utils/app_dialogs.dart';
import 'package:ezhandy_user/utils/app_strings.dart';
import 'package:ezhandy_user/utils/asset_path.dart';
import 'package:ezhandy_user/utils/enums.dart';
import 'package:ezhandy_user/utils/routes/app_navigation.dart';
import 'package:ezhandy_user/utils/routes/app_route.dart';
import 'package:ezhandy_user/widgets/logo_and_backgrounds/app_logo.dart';
import 'package:ezhandy_user/widgets/profile_widget/user_image_widget.dart';
import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  List<VoidCallback> tapList = [];
  @override
  void initState() {
    tapList = [
      _myProfileTap,
      _transcationHistoryTap,
      _affiliateEarningTap,
      _historyOfBookingsTap,
      _favouritesTap,
      _aboutUsTap,
      _contactUsTap,
      _privacyPolicyTap,
      _refundPolicyTap,
      _signOutTap,
      _deleteAccountTap,
    ];
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          10.verticalSpace,
          AppLogo(),
          10.verticalSpace,
          profileHeader(),
          30.verticalSpace,
          Divider(
            color: AppColors.blueDark,
          ),
          _menuListWidget(context),
        ],
      ),
    );
  }

  Widget _menuListWidget(context) {
    return Expanded(
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: AppStrings.menuList.length,
        padding: EdgeInsets.zero,
        itemBuilder: (BuildContext ctxt, int index) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: menuListTile(
                isArrowShow: !(index == AppStrings.menuList.length - 1),
                // context: context,
                assetPath: AssetPath.menuIconList[index],
                title: AppStrings.menuList[index],
                onTap:
                    //  AuthController.i.role == RoleType.driver.name
                    //     ? driverTapList[index]
                    //     :
                    tapList[index]),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            color: AppColors.grey,
          );
        },
      ),
    );
  }

  Widget menuListTile(
      {required String title,
      required String assetPath,
      bool isArrowShow = false,
      required VoidCallback onTap}) {
    return GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Image.asset(
              assetPath,
              height: 30.h,
              width: 30.w,
              // scale: 3.sp,
              // color: AppColors.green,
            ),
            25.horizontalSpace,
            CustomText(
              text: title,
              // color: AppColors.darkPink,
              fontSize: 16.sp,
              // maxLines: 2,
              // textAlign: TextAlign.start,
              // fontFamily: AppFonts.Jones_Bold,
            ),
            Spacer(),
            isArrowShow
                ? Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: AppColors.orange,
                  )
                : SizedBox.shrink()
          ],
        ));
  }

  Row profileHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // profileWidget(),
        UserImageWidget(
          size: 40.sp,
        ),

        10.horizontalSpace,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              align: Alignment.center,
              // fontWeight: FontWeight.bold,
              fontSize: 20.sp,
              text: AppStrings.dummyName,
              color: AppColors.blueDark,

              // "${Utils.capitalizeWords(AuthController.i.appUser.value.data?.firstName ?? "")} ${Utils.capitalizeWords(AuthController.i.appUser.value.data?.lastName ?? "")}",
              // color: AppColors.WHITE_COLOR,
            ),
            CustomText(
                align: Alignment.center,
                // fontWeight: FontWeight.  ,
                fontSize: 14.sp,
                text: AppStrings.dummyEmail,
                color: AppColors.grey),
          ],
        ),
      ],
    );
  }

  void _myProfileTap() {
    AppNavigation.navigateTo(context, AppRoutes.userProfileScreenRoute);
  }

  void _transcationHistoryTap() {
    AppNavigation.navigateTo(context, AppRoutes.transactionHistoryScreenRoute);
  }

  void _affiliateEarningTap() {
    AppNavigation.navigateTo(context, AppRoutes.affiliateEarningScreenRoute);
  }

  void _privacyPolicyTap() {
    AppNavigation.navigateTo(context, AppRoutes.contentScreenRoute,
        arguments: ContentRoutingArgument(
            title: AppStrings.privacyPolicy, type: WebContentType.pp.name));
  }

  void _aboutUsTap() {
    AppNavigation.navigateTo(context, AppRoutes.contentScreenRoute,
        arguments: ContentRoutingArgument(
            title: AppStrings.aboutUs, type: WebContentType.ap.name));
  }

  void _refundPolicyTap() {
       AppNavigation.navigateTo(context, AppRoutes.contentScreenRoute,
        arguments: ContentRoutingArgument(
            title: AppStrings.refundPolicy, type: WebContentType.rp.name));
  }

  void _contactUsTap() {
    AppNavigation.navigateTo(context, AppRoutes.contactUsScreenRoute);
  }

  void _historyOfBookingsTap() {
    AppNavigation.navigateTo(context, AppRoutes.bookingHistoryScreenRoute);
  }
  void _favouritesTap() {
    // AppNavigation.navigateTo(context, AppRoutes.bookingHistoryScreenRoute);
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
          AppNavigation.navigateToRemovingAll(
              context, AppRoutes.loginScreenRoute);
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
}
