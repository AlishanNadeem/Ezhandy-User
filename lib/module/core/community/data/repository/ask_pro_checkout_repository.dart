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

  static Future<bool> confirmSession(String sessionId) async {
    final id = sessionId.trim();
    if (id.isEmpty) return false;

    var success = false;

    final response = await DioClient().getRequest(
      endPoint: NetworkStrings.askProConfirm(id),
      isHeaderRequire: true,
      isLoader: true,
    );

    await DioClient().validateResponse(
      response: response,
      responseListener: CallbackResponseListener(
        onSuccessCallback: (_) => success = true,
        onFailureCallback: (_) => success = false,
      ),
      message: true,
    );

    return success;
  }

  static Map<String, dynamic>? _extractCheckoutData(dynamic response) {
    final outer = response is Map ? response['data'] : null;
    if (outer is! Map) return null;

    final inner = outer['data'];
    if (inner is! Map) return null;

    return Map<String, dynamic>.from(inner);
  }

  static String? _extractCheckoutUrl(dynamic response) {
    final data = _extractCheckoutData(response);
    final url = data?['url'];
    return url is String && url.trim().isNotEmpty ? url.trim() : null;
  }

  static String? _extractSessionId(dynamic response) {
    final data = _extractCheckoutData(response);
    final sessionId = data?['sessionId'];
    return sessionId is String && sessionId.trim().isNotEmpty
        ? sessionId.trim()
        : null;
  }

  @override
  void onSuccess({response}) {
    log(response.toString());

    final checkoutUrl = _extractCheckoutUrl(response);
    final sessionId = _extractSessionId(response);

    if (checkoutUrl == null) {
      AppDialogs.showToast(message: 'Unable to start checkout');
      return;
    }

    if (sessionId == null) {
      AppDialogs.showToast(message: 'Unable to start checkout session');
      return;
    }

    CheckoutBrowser.open(
      context!,
      checkoutUrl: checkoutUrl,
      successUrl: NetworkStrings.askProCheckoutSuccessUrl,
      cancelUrl: NetworkStrings.askProCheckoutCancelUrl,
      confirmSessionId: sessionId,
    );
  }
}
