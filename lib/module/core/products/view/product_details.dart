import 'package:carousel_slider/carousel_slider.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
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

class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  List<String> imagePathList = [
    "https://images.unsplash.com/photo-1607870411590-d5e9e06da09a?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8aGFtbWVyfGVufDB8fDB8fHww",
    "https://media.istockphoto.com/id/620730254/photo/plastic-bucket-with-cleaning-supplies-in-home.jpg?s=612x612&w=0&k=20&c=ZOAEoE4M6QoIwduuXL16H-shGbI5MOl6thkoMmV9BnA=",
    "https://plus.unsplash.com/premium_photo-1683141410787-c4dbd2220487?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8cGx1bWJpbmd8ZW58MHx8MHx8fDA%3D",
    "https://media.istockphoto.com/id/476886690/photo/chainsaw.jpg?s=612x612&w=0&k=20&c=0cSv-LUd0DEibKNe24wFj-PvKlmksAkG13IotMrYE6Y=",

    // AssetPath.tempRestaurant,
    // AssetPath.tempRestaurant,
    // AssetPath.tempRestaurant,
    // AssetPath.tempRestaurant,
  ];

  int _current = 0;
  // bool requestSent = false;
  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
      extendBodyBehindAppBar: true,
      // is_registration: false,
      title: AppStrings.productDetails,
      titleColor: AppColors.white,
      leading: AssetPath.backIcon,
      onclickLead: () {
        Get.back();
      },
      // appBarheight: 50,
      child:
          // Column(
          //   children: [
          // Stack(
          //   children: [
          //     Positioned(
          //       top: 0,
          //       left: 0,
          //       right: 0,
          //       child:
          Column(
        children: [
          slider_container(),
          detailsContainerWidget(),
        ],
      ),
      // ),
      // Positioned(top: 190.h, left: 0, right: 0, child: slider_dots()),

      //   ],
      // ),
      // ],
      // ),
    );
  }

  Widget detailsContainerWidget() {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.padding14),
          child: Column(
            children: [
              30.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: "Hammers",
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                  ),
                  CustomText(
                      text: "\$ 15.00",
                      fontWeight: FontWeight.w500,
                      fontSize: 18.sp,
                      color: AppColors.orange),
                ],
              ),
              10.verticalSpace,
              // rateReviewRow(context),
              // Divider(),
              CustomText(
                  text: "Hammers (claw, sledge, ball-peen, rubber mallet)"),
              10.verticalSpace,
              CustomText(text: "CITY: USA ABC"),
              10.verticalSpace,
              CustomText(
                text: AppStrings.description,
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
              ),
              10.verticalSpace,
              CustomText(
                text: AppStrings.lorem5,
                // color: AppColors.iconGrey,
              ),
              20.verticalSpace,

              CustomText(text: "Seller Details:",fontWeight: FontWeight.bold,fontSize: 18.sp,),
              Divider(),
              // 10.verticalSpace,
              detailsRow(
                  image: AssetPath.profileCircleIcon,
                  title: AppStrings.dummyName),
              10.verticalSpace,
              detailsRow(
                  image: AssetPath.callIcon,
                  title: AppStrings.dummyPhoneNUmber),
              10.verticalSpace,
              detailsRow(
                  image: AssetPath.emailIcon, title: AppStrings.dummyEmail),
              10.verticalSpace,
              detailsRow(
                  image: AssetPath.locationIcon, title: AppStrings.dummyAddress),
              // 10.verticalSpace,
              // detailsRow(
              //     image: AssetPath.emailIcon, title: AppStrings.dummyAddress),
              // 10.verticalSpace,
              // detailsRow(image: AssetPath.calendarIcon, title: "Mon To Sun"),
              // 10.verticalSpace,
              // detailsRow(
              //     image: AssetPath.timeIcon, title: "09:00 AM TO 10.00 PM"),
              // 10.verticalSpace,
              // detailsRow(image: AssetPath.linkIcon, title: AppStrings.dummyLink),
              // CustomText(text: AppStrings.interests, fontSize: 20.sp),
              // 10.verticalSpace,
              // interestWidget(),
              // Divider(),
//
              // 10.verticalSpace,
              // btnWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Padding detailsRow({required String image, required String title}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            image,
            width: 20.w,
            height: 20.h,
            color: AppColors.orange,
          ),
          10.horizontalSpace,
          CustomText(
            text: title,
            // color: AppColors.fontColor,
          ),
        ],
      ),
    );
  }

  // Row rateReviewRow(context) {
  //   return Row(
  //     children: [
  //       Icon(Icons.star,
  //           // size: 30.sp,
  //           color: Colors.amberAccent[400]),
  //       GestureDetector(
  //         onTap: () {
  //           ///rating screen
  //           AppNavigation.navigateTo(context, AppRoutes.ratingScreenRoute);
  //         },
  //         child: CustomText(
  //           text: "4.5 " + AppStrings.rating,
  //           fontWeight: FontWeight.w400,
  //           textDecoration: TextDecoration.underline,
  //         ),
  //       ),
  //       20.horizontalSpace,
  //       GestureDetector(
  //         onTap: () {
  //           ///rating screen
  //           // AppNavigation.navigateTo(context, AppRoutes.writeReviewScreenRoute, arguments: ReviewRoutingArgument(isViewOnly: true));
  //         },
  //         child: CustomText(
  //           text: "300 " + AppStrings.reviews,
  //           fontWeight: FontWeight.w400,
  //           textDecoration: TextDecoration.underline,
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget btnWidget() {
    return CustomButton(
      // isAuth: false,
      onclick: () {
        // setState(() {
        // requestSent = !requestSent;
        // });
        // validateGender(genderValue);
        // validateCountry(countryValue);
        // // validateCity(cityValue);
        // // validateState(stateValue);
        // if (FormKey.currentState!.validate()) {
        AppNavigation.navigateTo(context, AppRoutes.addToCartScreenRoute);
        // }
      },
      // is_spaceBetween: requestSent ? false : true,
      // btnimg: requestSent ? AssetPath.checkIcon : null,
      text: AppStrings.checkout,
    );
  }

  Wrap interestWidget() {
    return Wrap(
        alignment: WrapAlignment
            .start, // Align children to the left (start of the row)
        crossAxisAlignment: WrapCrossAlignment.start,
        spacing: 30,
        runSpacing: 8,
        children: List.generate(AppStrings.bottomBarList.length, (index) {
          return singleInterestWidget(
              image: AssetPath.menuIconList[index],
              title: AppStrings.bottomBarList[index]);
        }));
  }

  Widget singleInterestWidget({required String image, required String title}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          image,
          scale: 3.sp,
        ),
        10.horizontalSpace,
        Text(AppStrings.gaming),
      ],
    );
  }

  Widget slider_container() {
    return Stack(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            enlargeCenterPage: true,
            viewportFraction: 1,
            // enlargeFactor: 0.14,
            // aspectRatio: 2.0,
            height: 0.3.sh,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
          items: imagePathList.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return GestureDetector(
                    onTap: () {
                      // Utils.onTapViewImage(
                      //   context: context,
                      //   image: i,
                      //   mediaType: MediaPathType.network.name,
                      //   // mediaType: MediaPathType.asset.name,
                      // );
                    },
                    child:
                        //  OtherUserProfileWidget(isRadius: false, bottomPadding: 60.h, isHeart: false, image: i));
                        Container(
                      // width: 1.sw,
                      decoration: BoxDecoration(
                          // border: Border.all(width: 1, color: AppColors.green),
                          color: AppColors.transparent,
                          // borderRadius: BorderRadius.circular(10.sp),
                          image: DecorationImage(
                              image: NetworkImage(i), fit: BoxFit.cover)),
                      //     child: slider_dots()
                    ));
              },
            );
          }).toList(),
        ),
        Positioned(bottom: 10, right: 0, left: 0, child: slider_dots())
      ],
    );
  }

  Widget slider_dots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: imagePathList.asMap().entries.map((entry) {
        return GestureDetector(
          child: Container(
            width: 20.0.w,
            height: 5.0.h,
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
            decoration: BoxDecoration(
                // shape: BoxShape.circle,
                border: Border.all(
                    color: _current == entry.key
                        ? AppColors.transparent
                        : AppColors.white),
                borderRadius: BorderRadius.circular(5.sp),
                color:
                    _current == entry.key ? AppColors.orange : AppColors.white),
          ),
        );
      }).toList(),
    );
  }
}
