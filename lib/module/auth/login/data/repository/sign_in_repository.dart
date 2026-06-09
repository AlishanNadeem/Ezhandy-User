import 'dart:developer';
import 'dart:io';
import 'package:ezhandy_user/module/auth/AppUser/model/app_user.dart';
import 'package:ezhandy_user/module/auth/controller/auth_controller.dart';
import 'package:ezhandy_user/module/core/home/controller/home_controller.dart';
import 'package:ezhandy_user/utils/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ezhandy_user/dio_client/dio_client.dart';
import 'package:ezhandy_user/module/auth/verification/routing_arguments/otp_verification_routing_arguments.dart';
import 'package:ezhandy_user/services/firebase_messaging_service.dart';
import 'package:ezhandy_user/utils/app_strings.dart';
import 'package:ezhandy_user/utils/enums.dart';
import 'package:ezhandy_user/utils/listeners.dart';
import 'package:ezhandy_user/utils/network_strings.dart';
import 'package:ezhandy_user/utils/routes/app_navigation.dart';
import 'package:ezhandy_user/utils/routes/app_route.dart';
import 'dart:convert' as convert;

import 'package:ezhandy_user/utils/listeners.dart';

class SignInRepository extends ResponseListener {
  String? Email, Password;
  BuildContext? Context;
  void signInRepo(
    BuildContext context, {
    String? email,
    String? password,
  }) async {
    // String currentTimeZone = await FlutterNativeTimezone.getLocalTimezone();
    Map<String, dynamic> rawData = {
      "email": email,
      "password": password,
      "fcmToken": await FirebaseMessagingService().getToken(),
    };
    Email = email;
    Password = password;
    Context = context;
    print("rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr$rawData");
    // log("Device Token : " + await FirebaseMessagingService().getToken().toString());
    var response = await DioClient().postRequest(
      endPoint: NetworkStrings.signinEndpoint,
      data: rawData,
      responseListener: this,
    );

    DioClient().validateResponse(
        response: response, responseListener: this, message: true);
  }

  @override
  void onSuccess({response}) {
    log(response.toString());
    log(response.toString());

    AppUser a = AppUser.fromJson(response);
    //     AuthController.i.appUser.value = a;
    //     SharedPreference().setUser(user: convert.jsonEncode(a));
    //     SharedPreference().setBearerToken(token: a.data?.accessToken);

    //     // AppNavigation.navigateToRemovingAll(context, AppRoutes.userMainMenuScreenRoute);

    //     AppNavigation.navigateToRemovingAll(
    //         Context!, AppRoutes.mainMenuScreenRoute);

    // log("----------  a is ${convert.jsonEncode(a)}");
    if (response['data']['isEmailVerified'] == false ||
        a.data!.userModel?.isEmailVerified == 0) {
      AppNavigation.navigateReplacementNamed(
          Context!, AppRoutes.otpVerificationScreenRoute,
          arguments: OtpVerificationRoutingArgument(
              type: OtpType.signup.name, emailAndPhone: Email));
    } else {
      AuthController.i.appUser.value = a;
      SharedPreference().setUser(user: convert.jsonEncode(a));
      SharedPreference().setBearerToken(token: a.data?.accessToken);
      log((a.data?.accessToken).toString());
      AppNavigation.navigateToRemovingAll(
          Context, AppRoutes.mainMenuScreenRoute);
    }
  }
}
