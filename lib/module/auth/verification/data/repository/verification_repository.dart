import 'dart:convert' as convert;
import 'dart:developer';
import 'dart:io';
import 'package:ezhandy_user/module/auth/AppUser/model/app_user.dart';
import 'package:flutter/material.dart';
import 'package:ezhandy_user/dio_client/dio_client.dart';
import 'package:ezhandy_user/module/auth/controller/auth_controller.dart';
import 'package:ezhandy_user/module/auth/create_new_password/routing_arguments/reset_password_routing_arguments.dart';
import 'package:ezhandy_user/services/firebase_messaging_service.dart';
import 'package:ezhandy_user/utils/enums.dart';
import 'package:ezhandy_user/utils/listeners.dart';
import 'package:ezhandy_user/utils/network_strings.dart';
import 'package:ezhandy_user/utils/routes/app_navigation.dart';
import 'package:ezhandy_user/utils/routes/app_route.dart';
import 'package:ezhandy_user/utils/shared_preference.dart';

class VerificationRepository extends ResponseListener {
  String? otpType, Email;
  BuildContext? Context;

  void verifyUserRepo(context,
      {String? email, String? code, String? type}) async {
    // print(await FirebaseMessagingService().getToken(),);
    Map<String, dynamic> rawData = {
      "email": email,
      "otp": code,
      // "user_device_type": Platform.isIOS ? "ios" : "android",
      // "user_device_token": await FirebaseMessagingService().getToken(),

      // "device_token": await FirebaseMessagingService().getToken(),
      // "device_type": Platform.isIOS ? AppStrings.IOS : AppStrings.ANDROID,
    };

    otpType = type;
    Email = email;
    Context = context;
    print("rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr$rawData");
    var response = await DioClient().postRequest(
      endPoint: otpType == OtpType.signup.name
          ? NetworkStrings.verificationEmailEndpoint
          : NetworkStrings.verificationResetPasswordEndpoint,
      data: rawData,
      responseListener: this,
    );

    DioClient().validateResponse(
        response: response, responseListener: this, message: true);
  }

  @override
  void onFailure({response}) {
    AuthController.i.isTimeComplete.value = true;
  }

  @override
  void onSuccess({response}) {
    log(response.toString());
    log(response.toString());

    if (otpType == OtpType.forget.name) {
      AppNavigation.navigateReplacementNamed(
          Context!, AppRoutes.resetPasswordScreenRoute,
          arguments: ResetPasswordRoutingArgument(email: Email ?? ""));
    } else {
      AppUser a = AppUser.fromJson(response);
      AuthController.i.appUser.value = a;
      
    SharedPreference().setUser(user: convert.jsonEncode(a));
    SharedPreference().setBearerToken(token: a.data?.accessToken);
  
      AuthController.i.isLoginSignUp.value = true;

      AppNavigation.navigateToRemovingAll(
          Context!, AppRoutes.mainMenuScreenRoute);
    }
  }
}
