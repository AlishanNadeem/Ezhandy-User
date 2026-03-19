import 'dart:developer';

import 'package:ezhandy_user/utils/listeners.dart';
import 'package:ezhandy_user/module/auth/controller/auth_controller.dart';
import 'package:ezhandy_user/utils/listeners.dart';
import 'package:flutter/material.dart';
import 'package:ezhandy_user/dio_client/dio_client.dart';
import 'package:ezhandy_user/module/auth/verification/routing_arguments/otp_verification_routing_arguments.dart';
import 'package:ezhandy_user/utils/enums.dart';
import 'package:ezhandy_user/utils/listeners.dart';
import 'package:ezhandy_user/utils/network_strings.dart';
import 'package:ezhandy_user/utils/routes/app_navigation.dart';
import 'package:ezhandy_user/utils/routes/app_route.dart';

class ForgotPasswordRepository extends ResponseListener {
  BuildContext? Context;
  String? Email;
  bool? IsResendCode;

  void forgotPasswordRepo(context, {String? email, bool? isResendCode}) async {
    Map<String, dynamic> rawData = {"email": email};
    Email = email;
    IsResendCode = isResendCode;
    Context = context;
    var response = await DioClient().postRequest(
        endPoint: NetworkStrings.forgotPassEndpoint,
        data: rawData,
        responseListener: this);

    DioClient().validateResponse(
        response: response, responseListener: this, message: true);
  }

  @override
  void onSuccess({response}) {
    log(response.toString());
       AuthController.i.countDownController.value.start();

    if (!IsResendCode!) {
      AppNavigation.navigateTo(Context!, AppRoutes.otpVerificationScreenRoute,
          arguments: OtpVerificationRoutingArgument(
              type: OtpType.forget.name, emailAndPhone: Email, text: Email));
    }
  }
}
