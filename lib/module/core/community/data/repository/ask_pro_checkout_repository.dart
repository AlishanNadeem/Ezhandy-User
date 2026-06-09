import 'dart:developer';

import 'package:ezhandy_user/dio_client/dio_client.dart';
import 'package:ezhandy_user/utils/app_dialogs.dart';
import 'package:ezhandy_user/utils/checkout_browser.dart';
import 'package:ezhandy_user/utils/listeners.dart';
import 'package:ezhandy_user/utils/network_strings.dart';
import 'package:flutter/material.dart';

class AskProCheckoutRepository extends ResponseListener {
  BuildContext? context;

  void startCheckout(BuildContext currentContext) async {
    context = currentContext;

    final rawData = {
      'successUrl': NetworkStrings.askProCheckoutSuccessUrl,
      'cancelUrl': NetworkStrings.askProCheckoutCancelUrl,
    };

    final response = await DioClient().postRequest(
      endPoint: NetworkStrings.askProCheckoutEndpoint,
      data: rawData,
      responseListener: this,
      isHeaderRequire: true,
    );

    DioClient().validateResponse(
      response: response,
      responseListener: this,
    );
  }

  String? _extractCheckoutUrl(dynamic response) {
    final outer = response['data'];
    if (outer is! Map) return null;

    final inner = outer['data'];
    if (inner is! Map) return null;

    final url = inner['url'];
    return url is String && url.isNotEmpty ? url : null;
  }

  @override
  void onSuccess({response}) {
    log(response.toString());
    final checkoutUrl = _extractCheckoutUrl(response);
    if (checkoutUrl == null) {
      AppDialogs.showToast(message: 'Unable to start checkout');
      return;
    }

    CheckoutBrowser.open(
      context!,
      checkoutUrl: checkoutUrl,
      successUrl: NetworkStrings.askProCheckoutSuccessUrl,
      cancelUrl: NetworkStrings.askProCheckoutCancelUrl,
    );
  }
}
