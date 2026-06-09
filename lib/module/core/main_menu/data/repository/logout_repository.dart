// ignore: unused_import
import 'dart:convert' as convert;
import 'package:ezhandy_user/module/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ezhandy_user/dio_client/dio_client.dart';
import 'package:ezhandy_user/module/auth/controller/auth_controller.dart';
import 'package:ezhandy_user/module/auth/controller/social_login_controller.dart';
import 'package:ezhandy_user/module/core/home/controller/home_controller.dart';
import 'package:ezhandy_user/utils/listeners.dart';
import 'package:ezhandy_user/utils/network_strings.dart';
import 'package:ezhandy_user/utils/routes/app_navigation.dart';
import 'package:ezhandy_user/utils/routes/app_route.dart';
import 'package:ezhandy_user/utils/shared_preference.dart';
import 'package:ezhandy_user/utils/listeners.dart';

class LogoutRepository extends ResponseListener {
  BuildContext? Context;

  void logoutRepo(context) async {
    Context = context;
    var response = await DioClient().postRequest(
        endPoint: NetworkStrings.logoutEndpoint,
        responseListener: this,
        isHeaderRequire: true);

    DioClient().validateResponse(
        response: response, responseListener: this, message: true);
  }

  @override
  void onSuccess({response}) async {
    // SocialAuthGetX().firebaseUserSignOut();
    final prefs = SharedPreference();
    await prefs.sharedPreference;
    prefs.clearSessionOnly(); // AuthController.i.horseList.clear();
    HomeController.i.selectedTab.value = 0;
    // HomeController.i.clearAllData();
    AppNavigation.navigateToRemovingAll(Context!, AppRoutes.loginScreenRoute);
    // Get.delete<HomeController>();
  }
}
