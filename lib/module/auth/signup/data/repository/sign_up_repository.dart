import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:ezhandy_user/dio_client/dio_client.dart';
import 'package:ezhandy_user/module/auth/verification/routing_arguments/otp_verification_routing_arguments.dart';
import 'package:ezhandy_user/services/firebase_messaging_service.dart';
import 'package:ezhandy_user/utils/enums.dart';
import 'package:ezhandy_user/utils/listeners.dart';
import 'package:ezhandy_user/utils/network_strings.dart';
import 'package:ezhandy_user/utils/routes/app_navigation.dart';
import 'package:ezhandy_user/utils/routes/app_route.dart';
import 'package:http_parser/http_parser.dart';
import 'dart:convert' as convert;

class SignUpRepository extends ResponseListener {
  String? Email, Password,Phone;
  BuildContext? Context;
  void signUpRepo(
    BuildContext context, {
    String? email,
    String? password,
    String? userName,
    String? phone,
    String? referredBy,
    File? media,
  }) async {
    MultipartFile? mediaList;

    if (media != null) {
      MultipartFile file = await MultipartFile.fromFile(
        media.path,
        contentType: MediaType('image', 'png'),
      );
      log(file.toString() + " ye hey file multipart");
      mediaList = file;
    }

    FormData rawData = media == null
        ? FormData.fromMap({
            "fullName": userName,
            "email": email,
            // "roleId": 1,
            // "address": address,
            "password": password,
            "mobileNumber": phone==""?null:phone,
            "referredBy": referredBy,
            // "fcmToken": await FirebaseMessagingService().getToken(),
          })
        : FormData.fromMap({
            "fullName": userName,
            "email": email,
            // "roleId": 1,
            // "address": address,
            "password": password,
            "mobileNumber": phone==""?null:phone,
            "referredBy": referredBy,
            // "fcmToken": await FirebaseMessagingService().getToken(),
            "profileImage": mediaList,
          });

    // String currentTimeZone = await FlutterNativeTimezone.getLocalTimezone();

    Email = email;
    Phone = phone;
    Password = password;
    Context = context;
    print(
        "rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr${rawData.fields}   image ${rawData.files}");
    // log("Device Token : " + await FirebaseMessagingService().getToken().toString());
    var response = await DioClient().postRequest(
      endPoint: NetworkStrings.signupEndpoint,
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

    // AppNavigation.navigateReplacementNamed(
    //     Context!, AppRoutes.otpVerificationScreenRoute,
    //     arguments: OtpVerificationRoutingArgument(
    //         type: OtpType.signup.name, emailAndPhone: Email));

    AppNavigation.navigateTo(
        Context!, AppRoutes.otpVerificationScreenRoute,
        arguments: OtpVerificationRoutingArgument(
            type: OtpType.signup.name, emailAndPhone: Email,phone: Phone));

//  AppNavigation.navigateTo(Context!, AppRoutes.otpVerificationScreenRoute,
//           arguments: OtpVerificationRoutingArgument(
//               type: OtpType.forget.name, emailAndPhone: Email, text: Email));
   
    // var obj = AppUser.fromJson(response);
    // AuthController.i.appUser.value = obj;

    // log(AuthController.i.appUser.value.data!.authorization.toString());
    // log(AuthController.i.appUser.value.data!.authorization.toString());
    // // HomeController.i.department();
    // AppNavigation.navigateReplacementNamed(
    //     Context!, AppRoutes.createProfileScreenRoute);
  }
}
