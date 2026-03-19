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

class CreateNewPasswordRepository extends ResponseListener {
  BuildContext? Context;
  void createNewPasswordRepo(context, {String? password, String? email}) async {
    Context = context;
    Map<String, dynamic> rawData = {
      "email": email,
      "password": password,
    };

    var response = await DioClient().postRequest(
        endPoint: NetworkStrings.resetPassEndpoint,
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
      description: AppStrings.passwordUpdatedSuccessfully,
      title: AppStrings.passwordUpdated,
      btnTxt1: AppStrings.backToLogin,
      onTap1: () {
        AppNavigation.navigateToRemovingAll(
            Constants.navigatorKey.currentContext, AppRoutes.loginScreenRoute);
      },
    );
  }
}
