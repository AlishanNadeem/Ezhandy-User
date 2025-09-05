import 'package:ezhandy_user/module/core/all_services/routing_arguments/service_routing_arguments.dart';
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

class ProviderProfile extends StatefulWidget {
  const ProviderProfile({super.key});

  @override
  State<ProviderProfile> createState() => _ProviderProfileState();
}

class _ProviderProfileState extends State<ProviderProfile> {
  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
      leading: AssetPath.backIcon,
      onclickLead: () => Get.back(),
      title: AppStrings.providerProfile,
      appBarheight: 50,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.padding12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              profileRowWidget(),
              15.verticalSpace,
              CustomText(
                text: AppStrings.aboutUs,
                fontWeight: FontWeight.w700,
                fontSize: 16.sp,
              ),
              CustomText(
                text: AppStrings.lorem5 + AppStrings.lorem5,
              ),
              15.verticalSpace,
              Row(
                children: [
                  keyValueWidget(key: AppStrings.experience, value: "21Y"),
                  10.horizontalSpace,
                  keyValueWidget(key: AppStrings.language, value: "English"),
                  10.horizontalSpace,
                  keyValueWidget(key: AppStrings.gender, value: "Male"),
                ],
              ),
              15.verticalSpace,
              CustomText(
                text: AppStrings.certificateDetails,
                fontWeight: FontWeight.w700,
                fontSize: 16.sp,
              ),
              10.verticalSpace,
              CustomText(
                text: "${AppStrings.insituteName}:",
                color: AppColors.orange,
              ),
              CustomText(text: AppStrings.lorem1),
              10.verticalSpace,
              CustomText(
                text: "${AppStrings.certificateTitle}:",
                color: AppColors.orange,
              ),
              CustomText(text: AppStrings.lorem1),
              10.verticalSpace,
              ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: Image.asset(
                  AssetPath.certificateImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  // height: 180.h,
                ),
              ),
              10.verticalSpace,
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      text: AppStrings.services,
                      onclick: () {
                        // AppNavigation.navigateTo(
                        //   context,
                        //   AppRoutes.MyAppointmentScreenRoute,
                        // );
                      },
                    ),
                  ),
                  10.horizontalSpace,
                  Expanded(
                    child: CustomButton(
                      text: AppStrings.reviews,
                      borderColor: AppColors.orange,
                      color: AppColors.white,
                      textcolor: AppColors.black,
                      onclick: () {
                        AppNavigation.navigateTo(
                          context,
                          AppRoutes.ratingScreenRoute,
                        );
                      },
                    ),
                  ),
                ],
              ),
              10.verticalSpace,
              SizedBox(
                height: 0.3.sh,
                child: ListView.separated(
                  padding: EdgeInsets.only(bottom: AppPadding.padding25),
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return singleContainer(amount: index+13,
                      index: index,
                      onTap: () {
                        // AppNavigation.navigateTo(
                        //   context,
                        //   AppRoutes.servicesScreenRoute,
                        //   arguments: ServiceRoutingArgument(
                        //     serviceName: AppStrings.titleName,
                        //   ),
                        // );
                      },
                    );
                  },
                  separatorBuilder: (context, index) => 20.horizontalSpace,
                ),
              ),
              25.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  Widget singleContainer(
      {required VoidCallback onTap, required int index, amount}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 0.95.sw, // fixed width for horizontal scrolling
        margin: EdgeInsets.only(bottom: 10.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          image: const DecorationImage(
            fit: BoxFit.cover,
             image: 
                
                AssetImage(AssetPath.tempCleaningImage)
                
                // NetworkImage(
                //     "https://www.pristinehome.com.au/wp-content/uploads/2018/07/How-to-Choose-the-Best-House-Cleaning-Service.jpg")
                    )),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.end,
          children: [
            10.verticalSpace,
            Row(
              children: [
                SizedBox(),
                Spacer(),
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: AppColors.orange,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35.r),
                      bottomLeft: Radius.circular(35.r),
                    ),
                  ),
                  child: CustomText(
                    text: "\$$amount",
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
            Spacer(),
            detailsContainer(),
          ],
        ),
      ),
    );
  }

  Widget detailsContainer() {
    return Padding(
      padding: EdgeInsets.all(AppPadding.padding12),
      child: CustomContainer(
        child: Row(
          children: [
            Image.asset(
              AssetPath.cleaningIcon,
              width: 30.w,
              height: 30.h,
            ),
            10.horizontalSpace,
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(text: AppStrings.titleName),
                  5.verticalSpace,
                  CustomText(
                    text: AppStrings.lorem5,
                    maxLines: 3,
                    // overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
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
              text: AppStrings.activeNow,
              color: AppColors.orange,
            ),
          ],
        ),
        const Spacer(),
        Container(
          margin: EdgeInsets.only(left: AppPadding.padding12),
          padding: EdgeInsets.all(7.sp),
          decoration: BoxDecoration(
            color: AppColors.orange,
            shape: BoxShape.circle,
          ),
          child: Image.asset(
            AssetPath.heartFillIcon,
            color: AppColors.white,
            width: 18.w,
            height: 18.h,
          ),
        ),
      ],
    );
  }
}
