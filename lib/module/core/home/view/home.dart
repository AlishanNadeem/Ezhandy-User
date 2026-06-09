import 'package:ezhandy_user/module/auth/controller/auth_controller.dart';
import 'package:ezhandy_user/module/core/all_services/routing_arguments/service_routing_arguments.dart';
import 'package:ezhandy_user/module/core/main_menu/main_menu_user.dart';
import 'package:ezhandy_user/utils/app_padding.dart';
import 'package:ezhandy_user/utils/enums.dart';
import 'package:ezhandy_user/utils/utils.dart';
import 'package:ezhandy_user/widgets/button_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/utils/app_dialogs.dart';
import 'package:ezhandy_user/utils/app_strings.dart';
import 'package:ezhandy_user/utils/asset_path.dart';
import 'package:ezhandy_user/utils/network_strings.dart';
import 'package:ezhandy_user/utils/routes/app_navigation.dart';
import 'package:ezhandy_user/utils/routes/app_route.dart';
import 'package:ezhandy_user/widgets/Container/image_with_text_container.dart';
import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';

import 'package:ezhandy_user/module/core/home/controller/home_controller.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

 late HomeController _homeController;

  @override
  void initState() {
    super.initState();
    _homeController = Get.put(HomeController()); 
    print("🏠 Home initState called");
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final greeting = _getGreeting(now.hour);
    return Expanded(
      child: Column(
        children: [
          // 10.verticalSpace,
          appbarWidget(greeting, context),
          20.verticalSpace,
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  adWidget(),
                  10.verticalSpace,
                  ourServicesSeeAllRow(context),
                  30.verticalSpace,
                  servicesRowWidget(),
                  30.verticalSpace,
                  CustomText(
                      text: AppStrings.select, fontWeight: FontWeight.bold),
                  20.verticalSpace,
                  selectTabsWidget(),
                  // 20.verticalSpace,
                  // searchTextField(),
                  20.verticalSpace,
                  earnWithUsWidget(), 25.verticalSpace,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row appbarWidget(String greeting, BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: (!AuthController.i.isLoginSignUp.value)
              ? () {
                  signinSignUpPopup();
                }
              : () {
                  globalkey.currentState!.openDrawer();
                },
          child: Image.asset(
            AssetPath.menuIcon,
            alignment: Alignment.centerLeft,
            scale: 4.sp,
            color: AppColors.black,
          ),
        ),
        10.horizontalSpace,
        if (!AuthController.i.isLoginSignUp.value) ...[
          Image.asset(
            AssetPath.homeUserIcon,
            width: 20.w,
            height: 20.h,
          ),
          10.horizontalSpace,
          GestureDetector(
            onTap: () {
              AppNavigation.navigateToRemovingAll(
                  context, AppRoutes.loginScreenRoute);
            },
            child: CustomText(
              text: AppStrings.logIn + "/ ",
              fontWeight: FontWeight.bold,
            ),
          ),
          GestureDetector(
            onTap: () {
              AppNavigation.navigateToRemovingAll(
                  context, AppRoutes.loginScreenRoute);
              AppNavigation.navigateTo(context, AppRoutes.signupScreenRoute);
            },
            child: CustomText(
              text: AppStrings.signUp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ] else ...[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(text: "$greeting 🔥", fontSize: 14.sp),
              CustomText(
                  text:
                      "${Utils.capitalizeWords(AuthController.i.appUser.value.data?.userModel?.fullName ?? "dummy")}",
                  fontFamily: AppStrings.montserrat,
                  // color: AppColors.blueDark,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold),
            ],
          ),
        ],
        Spacer(),
        notificationWidget(context)
      ],
    );
  }

  GestureDetector notificationWidget(BuildContext context) {
    return GestureDetector(
      onTap: () {
        !AuthController.i.isLoginSignUp.value
            ? signinSignUpPopup()
            : AppNavigation.navigateTo(
                context, AppRoutes.notificationScreenRoute);
      },
      child: Image.asset(AssetPath.bellIcon, width: 20.w, height: 20.h),
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

  Row earnWithUsWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 25.w),
            child: Column(children: [
              CustomText(
                text: AppStrings.earnWithUs,
                fontWeight: FontWeight.bold,
              ),
              CustomText(
                text: AppStrings.lorem5,
                color: AppColors.grey,
                maxLines: 4,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    right: AppPadding.padding18, top: AppPadding.padding10),
                child: CustomButton(
                    onclick: () {
                      !AuthController.i.isLoginSignUp.value
                          ? signinSignUpPopup()
                          : AppNavigation.navigateTo(
                              context, AppRoutes.affiliateEarningScreenRoute);

                      ;
                    },
                    height: 40.h,
                    borderRadius: 35.r,
                    text: AppStrings.clickHere),
              )
            ]),
          ),
        ),
        Image.asset(
          AssetPath.earningIcon,
          width: 0.45.sw,
          // height: 200.h,
        )
      ],
    );
  }

  Row selectTabsWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        tabWidget(
          ontap: () {
            !AuthController.i.isLoginSignUp.value
                ? signinSignUpPopup()
                : AppNavigation.navigateTo(
                    context, AppRoutes.listOfServicesScreenRoute,
                    arguments: ServiceRoutingArgument(
                        type: ServiceType.instant.name, isQuick: true));

            ;
          },
          image1: AssetPath.tab1Icon,
          image2: AssetPath.homeTimeIcon,
          text: AppStrings.instantBooking,
        ),
        tabWidget(
          ontap: () {
            !AuthController.i.isLoginSignUp.value
                ? signinSignUpPopup()
                : AppNavigation.navigateTo(
                    context, AppRoutes.listOfServicesScreenRoute,
                    arguments: ServiceRoutingArgument(
                        type: ServiceType.schedule.name, isQuick: false));
          },
          image1: AssetPath.tab2Icon,
          image2: AssetPath.homeCalendarIcon,
          text: AppStrings.scheduleABooking,
        ),
      ],
    );
  }

Widget servicesRowWidget() {
  return Obx(() {
    // Loading state - API not yet responded
    if (_homeController.isLoading.value) {
      return Center(child: CircularProgressIndicator());
    }

if (_homeController.servicesList.isEmpty) {
  return SizedBox(
    width: double.infinity,
    child: CustomText(
      text: "No services found",
      color: AppColors.greyLight,
      is_alignLeft: false,  // ← centers it
    ),
  );
}

    // Show data
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: _homeController.servicesList.take(5).map((service) {
        return imageTextWidget(
          ontap: () {
            !AuthController.i.isLoginSignUp.value
                ? signinSignUpPopup()
                : AppNavigation.navigateTo(
                    context, AppRoutes.servicesScreenRoute,
                    arguments: ServiceRoutingArgument(
                        serviceName: service['name'],
                        type: ServiceType.instant.name));
          },
          text: service['name'] ?? '',
          image: _serviceIconUrl(service),
        );
      }).toList(),
    );
  });
}

  Container adWidget() {
    return Container(
      width: 1.sw,
      height: 150.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          image: DecorationImage(
              image: AssetImage(AssetPath.adImage), fit: BoxFit.cover)),
    );
  }

  Widget imageTextWidget({image, text, ontap}) {
    return GestureDetector(
      onTap: ontap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 30.r,
            backgroundImage: NetworkImage(
              image,
            ),
            // child: Image.network(
            //   image,
            //   width: 30.w,
            //   height: 30.h,
            //   fit: BoxFit.cover,
            // ),
          ),
          10.verticalSpace,
          CustomText(
            text: text,
            fontWeight: FontWeight.bold,
          )
        ],
      ),
    );
  }

  Widget tabWidget({image1, image2, text, ontap}) {
    return GestureDetector(
      onTap: ontap,
      child: Column(
        children: [
          Image.asset(
            image1,
            width: 0.45.sw,
            // height: 120.h,
          ),
          10.verticalSpace,
          Row(
            children: [
              Image.asset(
                image2,
                width: 15.w,
                height: 15.h,
              ),
              5.horizontalSpace,
              CustomText(
                text: text,
                fontWeight: FontWeight.bold,
                fontSize: 10.sp,
              ),
            ],
          )
        ],
      ),
    );
  }

  Row ourServicesSeeAllRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
            text: AppStrings.ourServices,
            fontWeight: FontWeight.bold,
            fontSize: 16.sp),
        GestureDetector(
            onTap: () {
              AppNavigation.navigateTo(
                  context, AppRoutes.listOfServicesScreenRoute,
                  arguments: ServiceRoutingArgument(
                      type: ServiceType.instant.name, isQuick: true));
            },
            child: CustomText(
              text: AppStrings.seeAll,
              color: AppColors.orange,
            )),
      ],
    );
  }

  // Widget tabWidget() {
  //   return Expanded(
  //     child: GridView.builder(
  //       padding: EdgeInsets.zero,
  //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //         crossAxisCount: 2,
  //         crossAxisSpacing: 15,
  //         mainAxisSpacing: 10.0,
  //         childAspectRatio: 1.3, // Adjust as needed
  //       ),
  //       itemCount: AssetPath.homeTabsIconList.length,
  //       shrinkWrap: true, // Fixes height issue
  //       // physics: NeverScrollableScrollPhysics(), // Disables GridView scrolling
  //       itemBuilder: (context, index) {
  //         return ImageWithTextContainer(
  //             onTap: () {
  //               if (index == 1 && isSubscribe == false) {
  //                 setState(() {
  //                   isSubscribe = true;
  //                 });
  //                 AppDialogs.showSuccessDialog(
  //                   context,
  //                   description: AppStrings.subscriptionRequiredMessage,
  //                   title: AppStrings.subscription,
  //                   isDoneShow: false,
  //                   btnTxt1: AppStrings.cancel,
  //                   btnTxt2: AppStrings.buyNow,
  //                   onTap1: () {
  //                     AppNavigation.navigatorPop(context);
  //                   },
  //                   onTap2: () {
  //                     AppNavigation.navigateTo(
  //                         context, AppRoutes.subscriptionScreenRoute);
  //                   },
  //                 );
  //               } else {
  //                 AppNavigation.navigateTo(context, navigationList[index]);
  //               }
  //             },
  //             image: AssetPath.homeTabsIconList[index],
  //             text: AppStrings.homeTabsList[index]);
  //       },
  //     ),
  //   );
  // }

  // Widget searchTextField() {
  //   return CustomTextField(
  //     label: false,
  //     prefxicon: AssetPath.searchIcon,
  //     hint: AppStrings.searchAnything,
  //     inputFormatters: [LengthLimitingTextInputFormatter(35)],
  //     // controller: firstNameController,
  //   );
  // }

  String _getGreeting(int hour) {
    if (hour >= 5 && hour < 12) return "Good Morning";
    if (hour >= 12 && hour < 17) return "Good Afternoon";
    if (hour >= 17 && hour < 21) return "Good Evening";
    return "Good Night";
  }

  /// Builds full icon URL from API `iconImagePath` + [NetworkStrings.IMAGE_BASE_URL].
  String _serviceIconUrl(dynamic service) {
    final path = service['iconImagePath']?.toString() ?? '';
    if (path.isEmpty) return '';
    if (path.startsWith('http://') || path.startsWith('https://')) {
      return path;
    }
    return '${NetworkStrings.IMAGE_BASE_URL}$path';
  }
}
