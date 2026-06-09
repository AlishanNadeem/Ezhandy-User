import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:ezhandy_user/dio_client/dio_client.dart';
import 'package:ezhandy_user/module/auth/AppUser/model/app_user.dart';
import 'package:ezhandy_user/module/auth/controller/auth_controller.dart';
import 'package:ezhandy_user/module/auth/verification/routing_arguments/otp_verification_routing_arguments.dart';
import 'package:ezhandy_user/services/firebase_messaging_service.dart';
import 'package:ezhandy_user/utils/app_dialogs.dart';
import 'package:ezhandy_user/utils/app_strings.dart';
import 'package:ezhandy_user/utils/constant.dart';
// import 'package:ezhandy_user/utils/enums.dart';
import 'package:ezhandy_user/utils/listeners.dart';
import 'package:ezhandy_user/utils/network_strings.dart';
import 'package:ezhandy_user/utils/routes/app_navigation.dart';
import 'package:ezhandy_user/utils/routes/app_route.dart';
import 'package:http_parser/http_parser.dart';
import 'dart:convert' as convert;

import 'package:ezhandy_user/utils/listeners.dart';
import 'package:ezhandy_user/utils/shared_preference.dart';

class EditProfileRepository extends ResponseListener {
  // String? Email, Password;
  // bool IsEdit = false;
  BuildContext? Context;
  void editProfileRepo(BuildContext context,
      {String? name, String? phone, File? media}) async {
    MultipartFile? mediaList;

    if (media != null) {
      MultipartFile file = await MultipartFile.fromFile(
        media.path,
        contentType: MediaType('image', 'png'),
      );
      log(file.toString() + " ye hey file multipart");
      mediaList = file;
    }

    Map<String, dynamic> data = {
      "fullName": name,
      "mobileNumber": phone,
      "profileImage": media == null ? null : mediaList,
    };

    /// ✅ remove null & empty string
    data.removeWhere((key, value) =>
        value == null ||
        (value is String && value.trim().isEmpty) ||
        (value is List && value.isEmpty));

    FormData rawData = FormData.fromMap(data);
    // Email = email;
    // IsEdit = isEdit;
    Context = context;
    print(
        "rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr${rawData.fields}   image ${rawData.files}");
    // log("Device Token : " + await FirebaseMessagingService().getToken().toString());
    var response = await DioClient().putRequest(
        endPoint: NetworkStrings.editProfileEndpoint +
            "/${AuthController.i.appUser.value.data?.userModel?.sub}",
        data: rawData,
        responseListener: this,
        isHeaderRequire: true);

    DioClient().validateResponse(
        response: response, responseListener: this, message: true);
  }

  @override
  void onSuccess({response}) {
    log(response.toString());
    log(response.toString());
    // AppUser a = AppUser.fromJson(response);
    AuthController.i.appUser.value.data?.userModel?.fullName =
        response['data']['user']['fullName'];
    AuthController.i.appUser.value.data?.userModel?.mobileNumber =
        response['data']['user']['mobileNumberp'];
    AuthController.i.appUser.value.data?.userModel?.profileImage =
        response['data']['user']['profileImage'];

    SharedPreference()
        .setUser(user: convert.jsonEncode(AuthController.i.appUser.value));
    SharedPreference().setBearerToken(
        token: AuthController.i.appUser.value.data?.accessToken);
    // AppNavigation.navigateToRemovingAll(
    //     Context!, AppRoutes.mainMenuScreenRoute);

    AppDialogs.showSuccessDialog(
      Context,
      description: AppStrings.profileUpdatedSuccessful,
      title: AppStrings.congratulation,
      btnTxt1: AppStrings.ok,
      onTap1: () {
        AppNavigation.navigatorPopUntil(Constants.navigatorKey.currentContext!,
            AppRoutes.userProfileScreenRoute);
      },
    );
    AuthController.i.appUser.refresh();
    // AppNavigation.navigateReplacementNamed(
    //     Context!, AppRoutes.otpVerificationScreenRoute,
    //     arguments: OtpVerificationRoutingArgument(
    //         type: OtpType.signup.name, emailAndPhone: Email));
  }
}
