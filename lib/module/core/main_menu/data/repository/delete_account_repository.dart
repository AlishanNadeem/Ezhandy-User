import 'package:ezhandy_user/dio_client/dio_client.dart';
import 'package:ezhandy_user/utils/constant.dart';
import 'package:ezhandy_user/utils/listeners.dart';
import 'package:ezhandy_user/utils/network_strings.dart';
import 'package:ezhandy_user/utils/routes/app_navigation.dart';
import 'package:ezhandy_user/utils/routes/app_route.dart';
import 'package:ezhandy_user/utils/session_clear.dart';
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
    await SessionClear.clearApiCaches(clearAllPrefs: true);

    final navContext = context ?? Constants.navigatorKey.currentContext;
    if (navContext != null) {
      AppNavigation.navigateToRemovingAll(
        navContext,
        AppRoutes.loginScreenRoute,
      );
    }
  }
}
