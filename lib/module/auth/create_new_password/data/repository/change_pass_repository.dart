import 'package:ezhandy_user/utils/app_dialogs.dart';
import 'package:ezhandy_user/utils/app_strings.dart';
import 'package:ezhandy_user/utils/constant.dart';
import 'package:ezhandy_user/utils/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:ezhandy_user/dio_client/dio_client.dart';
import 'package:ezhandy_user/utils/listeners.dart';
import 'package:ezhandy_user/utils/network_strings.dart';
import 'package:ezhandy_user/utils/routes/app_navigation.dart';
import 'package:ezhandy_user/utils/listeners.dart';

class ChangePasswordRepository extends ResponseListener {
  BuildContext? Context;
  void changePasswordRepo(context,
      {String? newPassword, String? currentPassword}) async {
    Context = context;
    Map<String, dynamic> rawData = {
      "currentPassword": currentPassword,
      "newPassword": newPassword,
    };

    var response = await DioClient().postRequest(
        endPoint: NetworkStrings.changePasswordEndpoint,
        // data: rawData,
        isHeaderRequire: true,
        responseListener: this,
        data: rawData);

    DioClient().validateResponse(
        response: response, responseListener: this, message: true);
  }

  @override
  void onSuccess({response}) {
    AppDialogs.showSuccessDialog(
      Context,
      description: AppStrings.passwordHasBeenUpdated,
      title: AppStrings.congratulation,
      btnTxt1: AppStrings.ok,
      onTap1: () {
        AppNavigation.navigatorPopUntil(Constants.navigatorKey.currentContext!,
            AppRoutes.userProfileScreenRoute);
      },
    );

      
  }
}
