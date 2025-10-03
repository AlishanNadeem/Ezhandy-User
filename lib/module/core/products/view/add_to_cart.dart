import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/utils/app_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
// import 'package:ezhandy_user/module/core/rating_review/routing_arguments/review_routing_arguments.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/utils/app_padding.dart';
import 'package:ezhandy_user/utils/app_strings.dart';
import 'package:ezhandy_user/utils/asset_path.dart';
import 'package:ezhandy_user/utils/enums.dart';
import 'package:ezhandy_user/utils/routes/app_navigation.dart';
import 'package:ezhandy_user/utils/routes/app_route.dart';
import 'package:ezhandy_user/utils/utils.dart';
import 'package:ezhandy_user/widgets/Container/custom_container.dart';
import 'package:ezhandy_user/widgets/button_widgets/custom_button.dart';
import 'package:ezhandy_user/widgets/logo_and_backgrounds/background.dart';
import 'package:ezhandy_user/widgets/profile_widget/other_user_profile_widget.dart';
import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';

class AddToCart extends StatefulWidget {
  const AddToCart({super.key});

  @override
  State<AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  List<String> imagePathList = [
    "https://images.unsplash.com/photo-1607870411590-d5e9e06da09a?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8aGFtbWVyfGVufDB8fDB8fHww",
    "https://media.istockphoto.com/id/620730254/photo/plastic-bucket-with-cleaning-supplies-in-home.jpg?s=612x612&w=0&k=20&c=ZOAEoE4M6QoIwduuXL16H-shGbI5MOl6thkoMmV9BnA=",
    "https://plus.unsplash.com/premium_photo-1683141410787-c4dbd2220487?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8cGx1bWJpbmd8ZW58MHx8MHx8fDA%3D",
    "https://media.istockphoto.com/id/476886690/photo/chainsaw.jpg?s=612x612&w=0&k=20&c=0cSv-LUd0DEibKNe24wFj-PvKlmksAkG13IotMrYE6Y=",
  ];

  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
      title: AppStrings.addToCart,
      leading: AssetPath.backIcon,
      onclickLead: () {
        Get.back();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.padding14),
        child: Column(
          children: [
            20.verticalSpace,
            myProductsWidget(),
            btnWidget(),
            Platform.isAndroid ? 25.verticalSpace : 25.verticalSpace,
          ],
        ),
      ),
    );
  }

  Widget myProductsWidget() {
    return Expanded(
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: 15,
        padding: EdgeInsets.only(bottom: AppPadding.padding12),
        itemBuilder: (BuildContext ctxt, int index) {
          return CustomContainer(
              child: Row(
            crossAxisAlignment: CrossAxisAlignment.end, // center middle column
            children: [
              Container(
                width: 100.w,
                height: 100.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  image: DecorationImage(
                    image: NetworkImage(
                      (index % 2 == 0)
                          ? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRvkwjZwZRu4oZI77vfJ8-HBpILp4KL-gPX5w&s"
                          : "https://plus.unsplash.com/premium_photo-1664035152480-b13ff54094f5?q=80&w=764&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              10.horizontalSpace,

              /// Middle Column (center vertically)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment:
                      MainAxisAlignment.start, // 👈 centers vertically
                  children: [
                    CustomText(
                      text: "Hammers",
                      fontWeight: FontWeight.bold,
                    ),
                    CustomText(text: "\$ 10.00"),
                    CustomText(
                      text: AppStrings.lorem3,
                      fontSize: 12.sp,
                      maxLines: 2,
                      // overflow: TextOverflow.ellipsis,
                    ),
                    20.verticalSpace
                  ],
                ),
              ),

              /// Right Side Text (stick to bottom)
              Align(
                alignment: Alignment.bottomCenter, // 👈 push to bottom
                child: CustomText(text: AppStrings.dummyDate),
              ),
            ],
          ));
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(height: 10.h);
        },
      ),
    );
  }

  Widget btnWidget() {
    return CustomButton(
      // isAuth: false,
      onclick: () {
        AppDialogs.showSuccessDialog(
          context,
          description: "Payment done successfully",
          title: AppStrings.congratulation,
          btnTxt1: AppStrings.ok,
          onTap1: () {
            // AppNavigation.navigatorPop(
            //     Constants.navigatorKey.currentContext!);
            AppNavigation.navigatorPopUntil(
                context, AppRoutes.marketPlaceScreenRoute);

            // AppNavigation.navigateTo(Constants.navigatorKey.currentContext!,
            //     AppRoutes.bookingScreenRoute,
            //     arguments:
            //         BookingRoutingArgument(Status: AppStrings.pending));
          },
        );
        // setState(() {
        // requestSent = !requestSent;
        // });
        // validateGender(genderValue);
        // validateCountry(countryValue);
        // // validateCity(cityValue);
        // // validateState(stateValue);
        // if (FormKey.currentState!.validate()) {
        // AppNavigation.navigateTo(
        //   context,
        //   AppRoutes.bookReservationScreenRoute,
        // );
        // }
      },
      // is_spaceBetween: requestSent ? false : true,
      // btnimg: requestSent ? AssetPath.checkIcon : null,
      text: AppStrings.payNow,
    );
  }
}
