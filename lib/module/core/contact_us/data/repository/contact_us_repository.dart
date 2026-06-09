import 'dart:developer';

import 'package:ezhandy_user/dio_client/dio_client.dart';
import 'package:ezhandy_user/utils/app_dialogs.dart';
import 'package:ezhandy_user/utils/app_strings.dart';
import 'package:ezhandy_user/utils/constant.dart';
import 'package:ezhandy_user/utils/listeners.dart';
import 'package:ezhandy_user/utils/network_strings.dart';
import 'package:ezhandy_user/utils/routes/app_navigation.dart';
import 'package:ezhandy_user/utils/routes/app_route.dart';
import 'package:flutter/material.dart';

class ContactUsRepository extends ResponseListener {
  BuildContext? context;

  void submitQueryRepo(
    BuildContext currentContext, {
    required String subject,
    required String message,
  }) async {
    context = currentContext;

    Map<String, dynamic> rawData = {
      "subject": subject,
      "message": message,
    };

    var response = await DioClient().postRequest(
      endPoint: NetworkStrings.queriesEndpoint,
      data: rawData,
      responseListener: this,
      isHeaderRequire: true,
    );

    DioClient().validateResponse(
      response: response,
      responseListener: this,
      message: true,
    );
  }

  @override
  void onSuccess({response}) {
    log(response.toString());
    AppDialogs.showSuccessDialog(
      context,
      description: AppStrings.yourMessageHasBeenSubmittedSuccessfully,
      title: AppStrings.congratulation,
      btnTxt1: AppStrings.ok,
      onTap1: () {
        AppNavigation.navigatorPopUntil(
          Constants.navigatorKey.currentContext!,
          AppRoutes.mainMenuScreenRoute,
        );
      },
    );
  }
}
