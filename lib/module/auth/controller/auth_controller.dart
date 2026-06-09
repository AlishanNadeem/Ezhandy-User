import 'dart:io';

// import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:ezhandy_user/module/auth/AppUser/model/app_user.dart';
import 'package:ezhandy_user/module/auth/create_new_password/data/repository/change_pass_repository.dart';
import 'package:ezhandy_user/module/auth/create_new_password/data/repository/reset_password_repository.dart';
import 'package:ezhandy_user/module/auth/forgot_password/data/repository/forgot_password_repository.dart';
import 'package:ezhandy_user/module/auth/login/data/repository/sign_in_repository.dart';
import 'package:ezhandy_user/module/auth/signup/data/repository/sign_up_repository.dart';
import 'package:ezhandy_user/module/auth/verification/data/repository/resend_code_repository.dart';
import 'package:ezhandy_user/module/auth/verification/data/repository/verification_repository.dart';
import 'package:ezhandy_user/module/core/main_menu/data/repository/delete_account_repository.dart';
import 'package:ezhandy_user/module/core/main_menu/data/repository/logout_repository.dart';
import 'package:ezhandy_user/module/core/profile/data/repository/edit_profile_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

// import 'package:ezhandy_user/module/auth/AppUser/model/app_user.dart';
// import 'package:ezhandy_user/module/auth/create_new_password/data/repository/create_new_password_repository.dart';
// import 'package:ezhandy_user/module/auth/forgot_password/data/repository/forgot_password_repository.dart';
// import 'package:ezhandy_user/module/auth/horse_profile/data/repository/create_post_repository.dart';
// import 'package:ezhandy_user/module/auth/horse_profile/data/repository/get_horse_profile_repository.dart';
// import 'package:ezhandy_user/module/auth/horse_profile/model/horse_model.dart';
// import 'package:ezhandy_user/module/auth/login/data/repository/sign_in_repository.dart';
// import 'package:ezhandy_user/module/auth/pre_login/data/social_login_repository.dart';
// import 'package:ezhandy_user/module/auth/profile/data/repository/create_profile_repository.dart';
// import 'package:ezhandy_user/module/auth/signup/data/repository/sign_up_repository.dart';
// import 'package:ezhandy_user/module/auth/verification/data/repository/resend_code_repository.dart';
// import 'package:ezhandy_user/module/auth/verification/data/repository/verification_repository.dart';
// import 'package:ezhandy_user/module/core/home/main_menu/data/repository/logout_repository.dart';
// import 'package:ezhandy_user/module/core/settings/data/repository/delete_account_repository.dart';
// import 'package:ezhandy_user/module/core/settings/data/repository/get_content_repository.dart';
// import 'package:ezhandy_user/module/core/settings/data/repository/notification_repository.dart';
// import 'package:ezhandy_user/module/core/settings/model/content_model.dart';

class AuthController extends GetxController {
  static AuthController get i => Get.find();

  var appUser = AppUser().obs;
  // Rx<CountDownController> countDownController = CountDownController().obs;
  // RxList<HorseModelData?> horseList = RxList<HorseModelData?>();
  // Rx<HorseModelData> horseDetail = HorseModelData().obs;
  // Rx<ContentModelData> contentDetail = ContentModelData().obs;
  Rx<CountDownController> countDownController = CountDownController().obs;
  RxBool isTimeComplete = false.obs;

  // RxString role = ''.obs;
  // RxString social = "".obs;
  // RxBool isTimeComplete = false.obs;
  RxBool isLoginSignUp = true.obs;

  /////-------------------Get API Loader-----------------/////
  // RxBool horseApi = false.obs;

  // void socialLoginFunction(
  //   context, {
  //   String? social_token,
  //   String? social_type,
  //   String? firstName,
  //   String? lastName,
  // }) {
  //   SocialLoginRepository().socialLoginFunction(
  //     context,
  //     social_token: social_token,
  //     social_type: social_type,
  //     firstName: firstName,
  //     lastName: lastName,
  //   );
  // }

  void signIn(BuildContext context, {String? email, String? password}) {
    SignInRepository().signInRepo(context, email: email, password: password);
  }

  void signUp(
    BuildContext context, {
    String? email,
    String? password,
    String? userName,
    String? phone,
    String? referredBy,
    File? media,
  }) {
    SignUpRepository().signUpRepo(context,
        email: email,
        password: password,
        userName: userName,
        phone: phone,
        referredBy: referredBy,
        media: media);
  }

  void verifyUser({
    String? email,
    String? code,
    String? type,
    BuildContext? context,
  }) {
    VerificationRepository()
        .verifyUserRepo(context, email: email, code: code, type: type);
  }

  void resendCode({String? email}) {
    ResendCodeRepository().resendCodeRepo(email: email);
  }

  void forgotPassword(BuildContext context,
      {String? email, bool? isResendCode}) {
    ForgotPasswordRepository()
        .forgotPasswordRepo(context, email: email, isResendCode: isResendCode);
  }

  void createNewPassword(context, {String? password, String? email}) {
    CreateNewPasswordRepository()
        .createNewPasswordRepo(context, email: email, password: password);
  }

  void changePassword(
    context, {
    String? newPassword,
    String? currentPassword,
  }) {
    ChangePasswordRepository().changePasswordRepo(context,
        newPassword: newPassword, currentPassword: currentPassword);
  }

  void editProfile(
      {String? name, String? phone, File? media, BuildContext? context}) {
    EditProfileRepository()
        .editProfileRepo(context!, media: media, name: name, phone: phone);
  }

  // void createHorseProfile(
  //   dynamic context, {
  //   int? horseId,
  //   dynamic index,
  //   String? horseName,
  //   String? registrationNumber,
  //   String? height,
  //   String? weight,
  //   String? dob,
  //   String? feed,
  //   String? maintenanceSupplements,
  //   // String? scheduledTime,
  //   // String? scheduledDate,
  //   // String? type,
  //   // String? volume,
  //   List<dynamic>? performanceSupplements,
  //   List<HorseModelDataHorseImages>? media,
  //   List<int>? deletedMediaList,
  //   List<int?>? deletedperformanceSupplementsIdsList,
  // }) {
  //   CreateHorseProfileRepository().createHorseProfileRepo(
  //     context,
  //     index: index,
  //     dob: dob,
  //     deletedMediaList: deletedMediaList,
  //     feed: feed,
  //     height: height,
  //     horseId: horseId,
  //     horseName: horseName,
  //     maintenanceSupplements: maintenanceSupplements,
  //     media: media,
  //     registrationNumber: registrationNumber,
  //     performanceSupplements: performanceSupplements,
  //     performanceSupplementsIds: deletedperformanceSupplementsIdsList,
  //     // scheduledTime: scheduledTime,
  //     // type: type,
  //     // volume: volume,
  //     weight: weight,
  //   );
  // }

  // void horseProfile() {
  //   GetHorseProfileRepository().horseProfileRepo();
  // }

  // void getContent() {
  //   GetContentRepository().getContentRepo();
  // }

  // void pushNotification() {
  //   NotificationRepository().notificationRepo();
  // }

  void deleteAccount(context) {
    DeleteAccountRepository().deleteAccountRepo(context);
  }

  void logout(context) {
    LogoutRepository().logoutRepo(context);
  }
}
