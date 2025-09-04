import 'package:ezhandy_user/utils/app_dialogs.dart';
import 'package:ezhandy_user/utils/app_padding.dart';
import 'package:ezhandy_user/utils/routes/app_navigation.dart';
import 'package:ezhandy_user/utils/routes/app_route.dart';
import 'package:ezhandy_user/widgets/Container/custom_container.dart';
import 'package:ezhandy_user/widgets/button_widgets/custom_button.dart';
import 'package:ezhandy_user/widgets/logo_and_backgrounds/background.dart';
import 'package:ezhandy_user/widgets/profile_widget/user_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/utils/app_strings.dart';
import 'package:ezhandy_user/utils/asset_path.dart';
import 'package:ezhandy_user/widgets/Slideable/slideable.dart';
import 'package:ezhandy_user/widgets/dropdown/custom_dropdown.dart';
import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';

class AffiliateEarning extends StatefulWidget {
  const AffiliateEarning({super.key});

  @override
  State<AffiliateEarning> createState() => _AffiliateEarningState();
}

class _AffiliateEarningState extends State<AffiliateEarning> {
  String? filterStartValue;
  // var filterList = ["All", "Weekly", "Monthly"];
  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
        leading: AssetPath.backIcon,
        onclickLead: () {
          Get.back();
        },
        title: AppStrings.affiliateEarning,
        appBarheight: 50,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.padding12),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      20.verticalSpace,
                      CustomText(
                          text: AppStrings.yourReferralCode,
                          // fontFamily: AppStrings.montserrat,
                          // color: AppColors.blueDark,
                          is_alignLeft: false,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold),
                      10.verticalSpace,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: CustomContainer(
                            borderColor: AppColors.orange,
                            isPadding: false,
                            radius: 35.r,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  CustomText(
                                      text: AppStrings.dummyRefCode,
                                      // is_alignLeft: false,
                                      color: AppColors.orange,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w600),
                                  20.horizontalSpace,
                                  CustomButton(
                                    borderRadius: 35.r,
                                    width: 80.w,
                                    text: "Copy",
                                  )
                                ],
                              ),
                            )),
                      ),
                      20.verticalSpace,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 90.w),
                        child: CustomContainer(
                            borderColor: AppColors.orange,
                            child: Column(
                              children: [
                                CustomText(
                                  text: AppStrings.dummyAmount,
                                  color: AppColors.orange,
                                  is_alignLeft: false,
                                ),
                                CustomText(
                                  text: AppStrings.totalEarnings,
                                  is_alignLeft: false,
                                  // color: AppColors.orange,
                                )
                              ],
                            )),
                      ),
                      20.verticalSpace,
                      ListView.separated(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          // final item = notifications[index];
                          return singleWidget(
                            // ontap: () {
                            //   // AppNavigation.navigateTo(context, AppRoutes.chatScreenRoute,
                            //   //     arguments: ChatRoutingArgument(isBooking: true));
                            // },
                            // time: "1 min ago",
                            // des: "Hello everyone",
                            image: AssetPath.userIcon,
                            lastMes: AppStrings.lorem5,
                            name: AppStrings.dummyName,
                          );
                        },
                        separatorBuilder: (context, index) {
                          return 20.verticalSpace;
                        },
                      ),
                      25.verticalSpace,
                    ],
                  ),
                ),
              ),
              CustomButton(
                text: AppStrings.withdraw,
                onclick: () {
                  AppDialogs.showSuccessDialog(context,
                      description: AppStrings.amountToBankAccount,
                      title: AppStrings.withdraw+"!",
                      image: AssetPath.bankIcon,
                      isDoneShow: false,
                      btnTxt1: AppStrings.cancel,
                      onTap1: () {
                        AppNavigation.navigatorPop(context);
                       
                      },
                      btnTxt2: AppStrings.confirm,
                      onTap2: () {
                        AppNavigation.navigatorPop(context);
                        //  AppDialogs.showSuccessDialog(
                        //   context,
                        //   description: AppStrings.oneOfOurRepresentative,
                        //   title: AppStrings.refundRequestSubmitted,
                        //   btnTxt1: AppStrings.goToHome,
                        //   onTap1: () {
                        //     AppNavigation.navigatorPopUntil(
                        //         context, AppRoutes.mainMenuScreenRoute);
                        //   },
                        // );
                      });
                },
              ),
              25.verticalSpace
            ],
          ),
        ));
  }

  Widget singleWidget({ name, image, lastMes}) {
    return CustomContainer(
      isPadding: false,
      // onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.only(
            top: AppPadding.padding14,
            bottom: AppPadding.padding14,
            left: AppPadding.padding14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            UserImageWidget(),
            5.horizontalSpace,
            Expanded(
              flex: 6,
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: name,
                    // color: AppColors.orange,
                    fontWeight: FontWeight.w500,
                    // fontSize: 10.sp,
                  ),
                  // CustomText(
                  //   text: des,
                  //   // color: AppColors.orange,
                  //   // fontWeight: FontWeight.w500,
                  //   maxLines: 1,

                  //   fontSize: 12.sp,
                  // ),
                  CustomText(
                    text: lastMes,
                    // color: AppColors.orange,
                    // fontWeight: FontWeight.w500,
                    maxLines: 1,
                    fontSize: 12.sp,
                    // fontSize: 10.sp,
                  ),
                ],
              ),
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: AppColors.orange,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35.r),
                      bottomLeft: Radius.circular(35.r))),
              child: CustomText(
                text: "\$254",
                color: AppColors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
