import 'dart:developer';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:ezhandy_user/dio_client/dio_client.dart';
import 'package:ezhandy_user/module/auth/controller/auth_controller.dart';
import 'package:ezhandy_user/module/auth/verification/routing_arguments/otp_verification_routing_arguments.dart';
import 'package:ezhandy_user/utils/enums.dart';
import 'package:ezhandy_user/utils/listeners.dart';
import 'package:ezhandy_user/utils/network_strings.dart';
import 'package:ezhandy_user/utils/routes/app_navigation.dart';
import 'package:ezhandy_user/utils/routes/app_route.dart';
import 'package:flutter/material.dart';

class ForgotPasswordRepository {
  void forgotPasswordRepo(
    BuildContext context, {
    String? email,
    bool? isResendCode,
  }) async {
    final shouldNavigateToOtp = isResendCode != true;

    final response = await DioClient().postRequest(
      endPoint: NetworkStrings.forgotPassEndpoint,
      data: {"email": email},
      isLoader: true,
    );

    if (!context.mounted) return;

    await DioClient().validateResponse(
      response: response,
      responseListener: CallbackResponseListener(
        onSuccessCallback: (res) {
          log(res.toString());
          if (shouldNavigateToOtp) {
            AuthController.i.countDownController.value = CountDownController();
            AuthController.i.isTimeComplete.value = false;
            if (!context.mounted) return;
            AppNavigation.navigateTo(
              context,
              AppRoutes.otpVerificationScreenRoute,
              arguments: OtpVerificationRoutingArgument(
                type: OtpType.forget.name,
                emailAndPhone: email,
                text: email,
              ),
            );
          } else {
            AuthController.i.countDownController.value.restart();
            AuthController.i.isTimeComplete.value = false;
          }
        },
        onFailureCallback: (res) => log(res.toString()),
      ),
      message: true,
    );
  }
}
