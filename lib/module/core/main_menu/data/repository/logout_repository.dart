// ignore: unused_import
import 'dart:convert' as convert;
import 'package:ezhandy_user/module/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ezhandy_user/dio_client/dio_client.dart';
import 'package:ezhandy_user/module/auth/controller/social_login_controller.dart';
import 'package:ezhandy_user/utils/listeners.dart';
import 'package:ezhandy_user/utils/network_strings.dart';
import 'package:ezhandy_user/utils/routes/app_navigation.dart';
import 'package:ezhandy_user/utils/routes/app_route.dart';
import 'package:ezhandy_user/utils/session_clear.dart';

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
    await SessionClear.clearApiCaches();
    AppNavigation.navigateToRemovingAll(Context!, AppRoutes.loginScreenRoute);
  }

  @override
  void onFailure({response}) async {
    // Still clear local cache even if logout API fails.
    await SessionClear.clearApiCaches();
    if (Context != null) {
      AppNavigation.navigateToRemovingAll(Context!, AppRoutes.loginScreenRoute);
    }
  }
}
