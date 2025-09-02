import 'dart:io';
import 'package:ezhandy_user/module/auth/controller/auth_controller.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/utils/app_padding.dart';
import 'package:ezhandy_user/utils/app_strings.dart';
import 'package:ezhandy_user/utils/asset_path.dart';
import 'package:ezhandy_user/utils/routes/app_navigation.dart';
import 'package:ezhandy_user/utils/routes/app_route.dart';
import 'package:ezhandy_user/widgets/button_widgets/custom_button.dart';
import 'package:ezhandy_user/widgets/logo_and_backgrounds/app_logo.dart';
import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';
import 'package:entry/entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashSliderScreen extends StatefulWidget {
  const SplashSliderScreen({super.key});

  @override
  State<SplashSliderScreen> createState() => _SplashSliderScreenState();
}

class _SplashSliderScreenState extends State<SplashSliderScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> splashData = [
    {
      "title": AppStrings.everySecondCounts,
      "desc": AppStrings.respondFaster,
      "image": AssetPath.splash1Image,
    },
    {
      "title": AppStrings.stayConnectedWhen,
      "desc": AppStrings.coordinateSeamless,
      "image": AssetPath.splash2Image,
    },
    {
      "title": AppStrings.stayConnectedWhen,
      "desc": AppStrings.coordinateSeamless,
      "image": AssetPath.splash3Image,
    },
  ];

  void _onNext() {
    if (_currentPage < splashData.length - 1) {
      _pageController.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else {
      AppNavigation.navigateToRemovingAll(context, AppRoutes.loginScreenRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? SafeArea(child: scaffoldWidget())
        : scaffoldWidget();
  }

  Scaffold scaffoldWidget() {
    return Scaffold(
      body: Container(
        width: 1.sw,
        height: 1.sh,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(splashData[_currentPage]["image"]!),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: splashData.length,
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                },
                itemBuilder: (context, index) => splashPage(
                  splashData[index]["title"]!,
                  splashData[index]["desc"]!,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                splashData.length,
                (index) => sliderWidget(
                  isCurrent: index == _currentPage,
                  color: index == _currentPage
                      ? AppColors.orange
                      : AppColors.white,
                ),
              ),
            ),
            Row(
              children: [
                12.horizontalSpace,
                GestureDetector(
                  onTap: () {
                    AuthController.i.isLoginSignUp.value = false;
                    AppNavigation.navigateToRemovingAll(
                        context, AppRoutes.mainMenuScreenRoute);
                  },
                  child: CustomText(
                    text: AppStrings.skip,
                    color: AppColors.white,
                  ),
                ),
                const Spacer(),
                buttonWidget(),
                12.horizontalSpace
              ],
            ),
            25.verticalSpace
          ],
        ),
      ),
    );
  }

  Widget splashPage(String title, String desc) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.padding20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CustomText(
            text: title,
            fontSize: 30.sp,
            color: AppColors.white,
            is_alignLeft: false,
          ),
          15.verticalSpace,
          CustomText(
            text: desc,
            color: AppColors.white,
            is_alignLeft: false,
          ),
          15.verticalSpace,
        ],
      ),
    );
  }

  Container sliderWidget({required Color color, bool isCurrent = false}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3.w),
      height: 5.h,
      width: 20.w,
      decoration: BoxDecoration(
        borderRadius: isCurrent ? BorderRadius.circular(10.r) : null,
        shape: isCurrent ? BoxShape.rectangle : BoxShape.circle,
        color: color,
      ),
    );
  }

  Widget buttonWidget() {
    return GestureDetector(
      onTap: _onNext,
      child: Image.asset(
        AssetPath.forwardIcon,
        width: 60.w,
        height: 60.h,
      ),
    );
  }
}
