import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ezhandy_user/module/auth/content/routing_arguments/content_routing_arguments.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/utils/app_strings.dart';
import 'package:ezhandy_user/utils/enums.dart';
import 'package:ezhandy_user/utils/routes/app_navigation.dart';
import 'package:ezhandy_user/utils/routes/app_route.dart';

class TermsPrivacyTextWidget extends StatelessWidget {
  const TermsPrivacyTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      width: 1.sw,
      child: Text.rich(
        TextSpan(
            style: TextStyle(
                color: AppColors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500),
            text: AppStrings.userAgreement,
            children: [
              TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      AppNavigation.navigateTo(
                          context, AppRoutes.contentScreenRoute,
                          arguments: ContentRoutingArgument(
                              title: AppStrings.termsAndConditions,
                              type: WebContentType.tc.name,
                             ));
                      // Get.toNamed(Paths.CONTENT_SCREEN_ROUTE,
                      // arguments: AppStrings.termsAndConditions);
                    },
                  style: const TextStyle(
                    color: AppColors.white,
                    fontFamily: AppStrings.montserrat,
                    fontWeight: FontWeight.bold,
                    // fontStyle: FontStyle.italic,
                    fontSize: 14,
                    // decoration: TextDecoration.underline
                  ),
                  text: AppStrings.termsAndConditions),
              const TextSpan(text: " | "),
              TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      AppNavigation.navigateTo(
                          context, AppRoutes.contentScreenRoute,
                          arguments: ContentRoutingArgument(
                              title: AppStrings.privacyPolicy,
                              type: WebContentType.pp.name,
                              ));
                      //          Get.toNamed(Paths.CONTENT_SCREEN_ROUTE,
                      // arguments: AppStrings.privacyPolicy);
                    },
                  style: const TextStyle(
                    color: AppColors.white,
                    fontFamily: AppStrings.montserrat,
                    fontWeight: FontWeight.bold,
                    // fontStyle: FontStyle.italic,
                    fontSize: 14,
                    // decoration: TextDecoration.underline
                  ),
                  text: AppStrings.privacyPolicy),
            ]),
        textAlign: TextAlign.center,
      ),
    );
  }
}
