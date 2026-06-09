import 'dart:developer';
import 'dart:convert' as convert;

import 'package:ezhandy_user/utils/app_dialogs.dart';
import 'package:ezhandy_user/utils/app_strings.dart';
import 'package:ezhandy_user/utils/asset_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ezhandy_user/dio_client/dio_client.dart';
import 'package:ezhandy_user/module/auth/controller/auth_controller.dart';
import 'package:ezhandy_user/module/auth/controller/social_login_controller.dart';
import 'package:ezhandy_user/module/core/home/controller/home_controller.dart';
import 'package:ezhandy_user/utils/constant.dart';
import 'package:ezhandy_user/utils/listeners.dart';
import 'package:ezhandy_user/utils/network_strings.dart';
import 'package:ezhandy_user/utils/routes/app_navigation.dart';
import 'package:ezhandy_user/utils/routes/app_route.dart';
import 'package:ezhandy_user/utils/shared_preference.dart';
import 'package:ezhandy_user/utils/listeners.dart';

class DeleteAccountRepository extends ResponseListener {
  BuildContext? Context;
  void deleteAccountRepo(context) async {
    Context = context;
    // print(await FirebaseMessagingService().getToken(),);
    // Map<String, dynamic> rawData = {
    //   "reason": reason,
    // };
    var response = await DioClient().deleteRequest(
        endPoint: NetworkStrings.deleteAccountEndpoint,
        // data: rawData,
        responseListener: this,
        isHeaderRequire: true);

    DioClient().validateResponse(
        response: response, responseListener: this, message: true);
  }

  @override
  void onSuccess({response}) {
    // SocialAuthGetX().firebaseUserSignOut();
    SharedPreference().clear();
    // AuthController.i.horseList.clear();
    HomeController.i.selectedTab.value = 0;
    // HomeController.i.clearAllData();

    AppDialogs.showSuccessDialog(
      Context,
      description: AppStrings.accountDeleteSuccessfully,
      title: AppStrings.congratulation,
      btnTxt1: AppStrings.ok,
      onTap1: () {
        AppNavigation.navigateToRemovingAll(
            Constants.navigatorKey.currentContext, AppRoutes.loginScreenRoute);
      },
    );
  }
}
                                                                                                       