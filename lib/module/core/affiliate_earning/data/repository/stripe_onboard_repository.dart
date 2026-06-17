import 'dart:developer';

import 'package:ezhandy_user/dio_client/dio_client.dart';
import 'package:ezhandy_user/module/auth/controller/auth_controller.dart';
import 'package:ezhandy_user/utils/app_dialogs.dart';
import 'package:ezhandy_user/utils/checkout_browser.dart';
import 'package:ezhandy_user/utils/listeners.dart';
import 'package:ezhandy_user/utils/network_strings.dart';
import 'package:ezhandy_user/utils/routes/app_route.dart';
import 'package:flutter/material.dart';

class StripeOnboardRepository extends ResponseListener {
  BuildContext? context;
  String? _accountId;

  void startOnboarding(BuildContext currentContext) async {
    context = currentContext;

    final response = await DioClient().postRequest(
      endPoint: NetworkStrings.stripeOnboardEndpoint,
      isHeaderRequire: true,
      responseListener: this,
    );

    DioClient().validateResponse(
      response: response,
      responseListener: this,
    );
  }

  String? _extractOnboardingUrl(dynamic response) {
    final data = response['data'];
    if (data is! Map) return null;

    final url = data['onboardingUrl'];
    return url is String && url.trim().isNotEmpty ? url.trim() : null;
  }

  String? _extractAccountId(dynamic response) {
    final data = response['data'];
    if (data is! Map) return null;

    final accountId = data['accountId'];
    return accountId is String && accountId.trim().isNotEmpty
        ? accountId.trim()
        : null;
  }

  void _persistStripeAccountId() {
    final accountId = _accountId;
    if (accountId == null || accountId.isEmpty) return;

    final user = AuthController.i.appUser.value.data?.userModel;
    if (user == null) return;

    user.stripeAccountId = accountId;
    AuthController.i.appUser.refresh();
  }

  @override
  void onSuccess({response}) {
    log(response.toString());

    final onboardingUrl = _extractOnboardingUrl(response);
    if (onboardingUrl == null) {
      AppDialogs.showToast(message: 'Unable to start Stripe onboarding');
      return;
    }

    _accountId = _extractAccountId(response);

    CheckoutBrowser.open(
      context!,
      checkoutUrl: onboardingUrl,
      successUrl: NetworkStrings.stripeOnboardSuccessUrl,
      cancelUrl: NetworkStrings.stripeOnboardCancelUrl,
      successRoute: AppRoutes.affiliateEarningScreenRoute,
      onSuccess: _persistStripeAccountId,
    );
  }
}
