// import 'dart:developer';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';
// import 'package:ezhandy_user/dio_client/dio_client.dart';
// import 'package:ezhandy_user/module/auth/AppUser/model/app_user.dart';
// import 'package:ezhandy_user/module/auth/controller/auth_controller.dart';
// import 'package:ezhandy_user/module/auth/verification/routing_arguments/otp_verification_routing_arguments.dart';
// import 'package:ezhandy_user/services/firebase_messaging_service.dart';
// import 'package:ezhandy_user/utils/app_dialogs.dart';
// import 'package:ezhandy_user/utils/app_strings.dart';
// import 'package:ezhandy_user/utils/constant.dart';
// // import 'package:ezhandy_user/utils/enums.dart';
// import 'package:ezhandy_user/utils/listeners.dart';
// import 'package:ezhandy_user/utils/network_strings.dart';
// import 'package:ezhandy_user/utils/routes/app_navigation.dart';
// import 'package:ezhandy_user/utils/routes/app_route.dart';
// import 'package:http_parser/http_parser.dart';
// import 'dart:convert' as convert;

// import 'package:ezhandy_user/utils/listeners.dart';
// import 'package:ezhandy_user/utils/shared_preference.dart';

// class CreateProfileRepository extends ResponseListener {
//   // String? Email, Password;
//   bool IsEdit = false;
//   BuildContext? Context;
//   void createProfileRepo(BuildContext context,
//       {String? gender,
//       String? height,
//       String? weight,
//       String? dateOfBirth,
//       int? referralId,
//       String? otherReferral,
//       String? selectedOz,
//       File? media,
//       required bool isEdit}) async {
//     MultipartFile? mediaList;

//     if (media != null) {
//       MultipartFile file = await MultipartFile.fromFile(
//         media.path,
//         contentType: MediaType('image', 'png'),
//       );
//       log(file.toString() + " ye hey file multipart");
//       mediaList = file;
//     }

//     FormData rawData = media == null
//         ? FormData.fromMap({
//             "gender": gender,
//             "height": height,
//             "weight": weight,
//             "dateOfBirth": dateOfBirth,
//             "referralId": referralId,
//             "otherReferral": otherReferral,
//             // "selectedOz": selectedOz,

//             // "fcmToken": await FirebaseMessagingService().getToken(),
//           })
//         : FormData.fromMap({
//             "gender": gender,
//             "height": height,
//             "weight": weight,
//             "dateOfBirth": dateOfBirth,
//             "referralId": referralId,
//             "otherReferral": otherReferral,
//             // "selectedOz": selectedOz,
//             // "fcmToken": await FirebaseMessagingService().getToken(),
//             "image": mediaList,
//           });
//     if (isEdit == true) {
//       rawData.fields.add(MapEntry(
//         "selectedOz",
//         selectedOz!,
//       ));
//     }
//     // String currentTimeZone = await FlutterNativeTimezone.getLocalTimezone();

//     // Email = email;
//     IsEdit = isEdit;
//     Context = context;
//     print(
//         "rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr${rawData.fields}   image ${rawData.files}");
//     // log("Device Token : " + await FirebaseMessagingService().getToken().toString());
//     var response = await DioClient().postRequest(
//         endPoint: NetworkStrings.editProfileEndpoint,
//         data: rawData,
//         responseListener: this,
//         isHeaderRequire: true);

//     DioClient().validateResponse(
//         response: response, responseListener: this, message: true);
//   }

//   @override
//   void onSuccess({response}) {
//     log(response.toString());
//     log(response.toString());
//     AppUser a = AppUser.fromJson(response);
//     AuthController.i.appUser.value = a;

//     SharedPreference().setUser(user: convert.jsonEncode(a));
//     SharedPreference().setBearerToken(token: a.data?.accessToken);
//     // AppNavigation.navigateToRemovingAll(
//     //     Context!, AppRoutes.mainMenuScreenRoute);

//     if (IsEdit) {
//       AppDialogs.showSuccessDialog(
//         Context,
//         description: AppStrings.profileUpdatedSuccessful,
//         title: AppStrings.congratulation,
//         btnTxt1: AppStrings.ok,
//         onTap1: () {
//           AppNavigation.navigatorPopUntil(
//               Constants.navigatorKey.currentContext!,
//               AppRoutes.userProfileScreenRoute);
//         },
//       );
//     } else {
//       AppNavigation.navigateToRemovingAll(
//           Context, AppRoutes.mainMenuScreenRoute);
//     }
//     // AppNavigation.navigateReplacementNamed(
//     //     Context!, AppRoutes.otpVerificationScreenRoute,
//     //     arguments: OtpVerificationRoutingArgument(
//     //         type: OtpType.signup.name, emailAndPhone: Email));
//   }
// }
