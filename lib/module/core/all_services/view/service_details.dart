import 'package:ezhandy_user/module/core/all_services/routing_arguments/service_routing_arguments.dart';
import 'package:ezhandy_user/utils/enums.dart';
import 'package:ezhandy_user/widgets/Container/custom_container.dart';
import 'package:ezhandy_user/widgets/profile_widget/user_image_widget.dart';
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

class ServiceDetails extends StatefulWidget {
  String? type;
  ServiceDetails({this.type, super.key});

  @override
  State<ServiceDetails> createState() => _ServiceDetailsState();
}

class _ServiceDetailsState extends State<ServiceDetails> {
  bool isFav = false;
  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
      leading: AssetPath.backIcon,
      onclickLead: () => Get.back(),
      title: AppStrings.serviceDetails,
      appBarheight: 50,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.padding12),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    profileRowWidget(),
                    15.verticalSpace,
                    singleContainer(
                      amount: 0 + 13,
                      index: 0,
                      isFav: isFav,
                      ontapLike: () {
                        setState(() {
                          isFav = !isFav;
                        });
                      },
                      onTap: () {
                        // AppNavigation.navigateTo(
                        //   context,
                        //   AppRoutes.servicesScreenRoute,
                        //   arguments: ServiceRoutingArgument(
                        //     serviceName: AppStrings.titleName,
                        //   ),
                        // );
                      },
                    ),
                    15.verticalSpace,
                    CustomText(
                      text: AppStrings.dummylorem,
                      fontWeight: FontWeight.w700,
                      fontSize: 16.sp,
                    ),
                    CustomText(
                      text: AppStrings.lorem5 + AppStrings.lorem5,
                    ),
                    15.verticalSpace,
                    Row(
                      children: [
                        keyValueWidget(
                            key: AppStrings.visitCharges,
                            value: "\$" + AppStrings.dummyAmount2),
                        10.horizontalSpace,
                        keyValueWidget(
                            key: AppStrings.hourlyRate,
                            value: "\$" + AppStrings.dummyAmount),
                      ],
                    ),
                    10.verticalSpace,
                    CustomText(
                      text:
                          "A minimum of 2 hours of service booking is mandatory.",
                      // fontWeight: FontWeight.w700,
                      color: AppColors.orange,
                      fontSize: 16.sp,
                    ),
                    10.verticalSpace,
                  ],
                ),
              ),
            ),
            CustomButton(
              text: widget.type == ServiceType.instant.name
                  ? AppStrings.bookQuickServices
                  : "Book Service",
              onclick: () {
                AppDialogs.showSuccessDialog(context,
                    description: widget.type == ServiceType.instant.name
                        ? AppStrings.bookQuiceServiceDetails
                        : AppStrings.bookServiceDetails,
                    // title: AppStrings.deleteAccount,
                    image: AssetPath.tumbIcon,
                    isDoneShow: false,
                    btnTxt1: AppStrings.yes,
                    onTap1: () {
                      AppNavigation.navigatorPop(context);
                      if (widget.type == ServiceType.instant.name) {
                        AppNavigation.navigateTo(
                            context, AppRoutes.serviceSelectionScreenRoute);
                      } else {
                        AppNavigation.navigateTo(
                            context, AppRoutes.scheduleBookingScreenRoute);
                      }
                    },
                    btnTxt2: AppStrings.no,
                    onTap2: () {
                      AppNavigation.navigatorPop(context);
                    });
              },
            ),
            25.verticalSpace,
          ],
        ),
      ),
    );
  }

  Widget singleContainer(
      {required VoidCallback onTap,
      required int index,
      amount,
      ontapLike,
      isFav}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 250.h,
        width: 1.sw, // fixed width for horizontal scrolling
        margin: EdgeInsets.only(bottom: 10.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            image: const DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(AssetPath.tempCleaningImage)

                // NetworkImage(
                //     "https://www.pristinehome.com.au/wp-content/uploads/2018/07/How-to-Choose-the-Best-House-Cleaning-Service.jpg")
                )),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.end,
          children: [
            10.verticalSpace,

            Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                  onTap: ontapLike,
                  child: Icon(
                    isFav
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    size: 30.sp,
                  )),
            ),
            // Icon(Icons.favorite_border_rounded),

            // Spacer(),
            // detailsContainer(),
          ],
        ),
      ),
    );
  }

  Widget keyValueWidget({required String value, required String key}) {
    return Expanded(
      child: CustomContainer(
        borderColor: AppColors.orange,
        child: Column(
          children: [
            CustomText(
              text: value,
              is_alignLeft: false,
              color: AppColors.orange,
            ),
            CustomText(
              text: key,
              is_alignLeft: false,
            ),
          ],
        ),
      ),
    );
  }

  Row profileRowWidget() {
    return Row(
      children: [
        UserImageWidget(),
        5.horizontalSpace,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: AppStrings.dummyName,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
            CustomText(
              text: AppStrings.dummylorem,
              // color: AppColors.orange,
            ),
          ],
        ),
        const Spacer(),
        CustomContainer(
            onTap: () {
              AppNavigation.navigateTo(context, AppRoutes.pastworkScreenRoute);
            },
            // margin: EdgeInsets.only(left: AppPadding.padding12),
            // padding: EdgeInsets.all(7.sp),
            // decoration: BoxDecoration(
            //   color: AppColors.orange,
            //   shape: BoxShape.circle,
            // ),
            bgColor: AppColors.orange,
            borderColor: AppColors.orange,
            radius: 35.r,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: AppPadding.padding12),
              child: CustomText(
                text: AppStrings.pastWork,
                color: AppColors.white,
              ),
            )),
      ],
    );
  }
}
