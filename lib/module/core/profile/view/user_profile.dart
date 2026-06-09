import 'package:ezhandy_user/module/auth/controller/auth_controller.dart';
import 'package:ezhandy_user/utils/constant.dart';
import 'package:ezhandy_user/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/utils/app_dialogs.dart';
import 'package:ezhandy_user/utils/app_padding.dart';
import 'package:ezhandy_user/utils/app_strings.dart';
import 'package:ezhandy_user/utils/asset_path.dart';
import 'package:ezhandy_user/utils/routes/app_navigation.dart';
import 'package:ezhandy_user/utils/routes/app_route.dart';
import 'package:ezhandy_user/widgets/button_widgets/custom_button.dart';
import 'package:ezhandy_user/widgets/logo_and_backgrounds/background.dart';
import 'package:ezhandy_user/widgets/profile_widget/profile_picture_widget.dart';
import 'package:ezhandy_user/widgets/row/two_text_row.dart';
import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';
import 'package:ezhandy_user/utils/network_strings.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
        leading: AssetPath.backIcon,
        onclickLead: () {
          Get.back();
        },
        title: AppStrings.myProfile,
        appBarheight: 50,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.padding12),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Obx(() {
                    return Column(
                      children: [
                        20.verticalSpace,
                        profileWidget(),
                        20.verticalSpace,
                        TwoTextRow(
                            secondColor: AppColors.black,
                            firstText: AppStrings.name,
                            secondText: Utils.capitalizeWords(AuthController.i
                                    .appUser.value.data?.userModel?.fullName ??
                                "")),
                        Divider(color: AppColors.blueDark),
                        10.verticalSpace,
                        TwoTextRow(
                          secondColor: AppColors.black,
                          firstText: AppStrings.phoneNumber,
                          secondText: Constants
                              .maskTextInputFormatterPhoneUSWithCode
                              .maskText(AuthController.i.appUser.value.data
                                      ?.userModel?.mobileNumber ??
                                  "1234567890"),
                        ),
                        Divider(color: AppColors.blueDark),
                        10.verticalSpace,
                        TwoTextRow(
                            secondColor: AppColors.black,
                            firstText: AppStrings.emailAddress,
                            secondText:AuthController.i.appUser.value.data
                                      ?.userModel?.email ??""),
                        // Divider(color: AppColors.blueDark),
                        // 10.verticalSpace,
                        // TwoTextRow(secondColor: AppColors.black,
                        //     firstText: AppStrings.referralCode, secondText: "Football"),
                        // Divider(color: AppColors.blueDark),
                        // 10.verticalSpace,
                        // TwoTextRow(secondColor: AppColors.black,
                        //     firstText: AppStrings.status, secondText: "High"),
                      ],
                    );
                  }),
                ),
              ),
              40.verticalSpace,
              CustomButton(
                text: AppStrings.editProfile,
                onclick: () {
                  AppNavigation.navigateTo(
                      context, AppRoutes.editProfileScreenRoute);
                },
              ),
              20.verticalSpace,
              GestureDetector(
                onTap: () {
                  AppNavigation.navigateTo(
                      context, AppRoutes.changePasswordScreenRoute);
                },
                child: CustomText(
                    text: AppStrings.changePassword,
                    is_alignLeft: false,
                    textDecoration: TextDecoration.underline,
                    // color: AppColors.blueDark,
                    fontSize: 18.sp),
              ),
              20.verticalSpace,
              GestureDetector(
                onTap: () {
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
                },
                child: CustomText(
                    text: AppStrings.deleteAccount,
                    is_alignLeft: false,
                    textDecoration: TextDecoration.underline,
                    color: AppColors.red,
                    fontSize: 18.sp),
              ),
              25.verticalSpace
            ],
          ),
        ));
  }

  ProfilePictureWidget profileWidget() {
    return ProfilePictureWidget(
      // showUpload: widget.type == ProfileType.edit.name,
      // upload_icon:
      //     args == AppStrings.CREATE_PROFILE ? false : true,
      is_pickImage: false,

      // is_pickImage:
      //     args == AppStrings.CREATE_PROFILE ? true : false,
      // setFile: _setFile,
      profileImageUrl: "${NetworkStrings.IMAGE_BASE_URL}${AuthController.i.appUser.value.data?.userModel?.profileImage ?? ''}",
      // profileImage: _profileImage,
      assetPath:
      //     // args == AppStrings.CREATE_PROFILE
            //  ?
              null,
      //     // :
      //     AssetPath.tempImage1,
      // borderWidth:
      // args == AppStrings.CREATE_PROFILE ? null :
      // 5,
    );
  }
}
