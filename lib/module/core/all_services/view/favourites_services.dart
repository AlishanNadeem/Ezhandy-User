import 'package:ezhandy_user/module/core/all_services/routing_arguments/service_routing_arguments.dart';
import 'package:ezhandy_user/utils/app_padding.dart';
import 'package:ezhandy_user/utils/enums.dart';
import 'package:ezhandy_user/utils/routes/app_navigation.dart';
import 'package:ezhandy_user/utils/routes/app_route.dart';
import 'package:ezhandy_user/widgets/Container/custom_container.dart';
import 'package:ezhandy_user/widgets/logo_and_backgrounds/background.dart';
import 'package:ezhandy_user/widgets/text_fields/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/utils/app_strings.dart';
import 'package:ezhandy_user/utils/asset_path.dart';
import 'package:ezhandy_user/widgets/Slideable/slideable.dart';
import 'package:ezhandy_user/widgets/dropdown/custom_dropdown.dart';
import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';

class FavouritesServices extends StatefulWidget {
  const FavouritesServices({super.key});

  @override
  State<FavouritesServices> createState() => _FavouritesServicesState();
}

class _FavouritesServicesState extends State<FavouritesServices> {
  bool isFav = true;

  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
        leading: AssetPath.backIcon,
        onclickLead: () {
          Get.back();
        },
        // appBarheight: 50.h,
        title: AppStrings.myFavorites,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.padding12),
          child: ListView.separated(
            padding: EdgeInsets.only(
                top: AppPadding.padding20, bottom: AppPadding.padding25),
            shrinkWrap: true,
            itemCount: 20,
            itemBuilder: (context, index) {
              // final item = notifications[index];
              return singleContainer(
                amount: index + 13,
                index: index,
                isFav: isFav,
                ontapLike: () {
                  setState(() {
                    // isFav=!isFav;
                  });
                },
                onTap: () {
                  AppNavigation.navigateTo(
                    context,
                    AppRoutes.serviceDetailsScreenRoute,
                    arguments: ServiceRoutingArgument(
                      type: ServiceType.instant.name,
                    ),
                  );
                },
              );
            },
            separatorBuilder: (context, index) {
              return 10.verticalSpace;
            },
          ),
        ));
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
        width: 1.sw,
        height: 200.h, // fixed width for horizontal scrolling
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
            Row(
              children: [
                GestureDetector(
                    onTap: ontapLike,
                    child: Icon(
                      isFav
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded,
                      size: 30.sp,
                    )),
                // Icon(Icons.favorite_border_rounded),

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
}
