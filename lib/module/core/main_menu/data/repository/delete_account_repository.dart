import 'package:ezhandy_user/dio_client/dio_client.dart';
import 'package:ezhandy_user/module/auth/AppUser/model/app_user.dart';
import 'package:ezhandy_user/module/auth/controller/auth_controller.dart';
import 'package:ezhandy_user/module/core/home/controller/home_controller.dart';
import 'package:ezhandy_user/utils/app_dialogs.dart';
import 'package:ezhandy_user/utils/app_strings.dart';
import 'package:ezhandy_user/utils/constant.dart';
import 'package:ezhandy_user/utils/listeners.dart';
import 'package:ezhandy_user/utils/network_strings.dart';
import 'package:ezhandy_user/utils/routes/app_navigation.dart';
import 'package:ezhandy_user/utils/routes/app_route.dart';
import 'package:ezhandy_user/utils/shared_preference.dart';
import 'package:flutter/material.dart';

class DeleteAccountRepository extends ResponseListener {
  BuildContext? context;

  void deleteAccountRepo(BuildContext currentContext) async {
    context = currentContext;

    final response = await DioClient().deleteRequest(
      endPoint: NetworkStrings.deleteAccountEndpoint,
      responseListener: this,
      isHeaderRequire: true,
    );

    DioClient().validateResponse(
      response: response,
      responseListener: this,
      message: true,
    );
  }

  @override
  void onSuccess({response}) async {
    await _logoutCompletely();

    AppDialogs.showToast(message: AppStrings.accountDeleteSuccessfully);

    final navContext = context ?? Constants.navigatorKey.currentContext;
    if (navContext != null) {
      AppNavigation.navigateToRemovingAll(
        navContext,
        AppRoutes.loginScreenRoute,
      );
    }
  }

  Future<void> _logoutCompletely() async {
    final prefs = SharedPreference();
    await prefs.sharedPreference;
    prefs.clear();

    AuthController.i.appUser.value = AppUser();
    HomeController.i.selectedTab.value = 0;
  }
}
