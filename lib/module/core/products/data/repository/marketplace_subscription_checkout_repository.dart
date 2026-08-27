import 'dart:developer';

import 'package:ezhandy_user/dio_client/dio_client.dart';
import 'package:ezhandy_user/utils/app_dialogs.dart';
import 'package:ezhandy_user/utils/checkout_browser.dart';
import 'package:ezhandy_user/utils/listeners.dart';
import 'package:ezhandy_user/utils/network_strings.dart';
import 'package:flutter/material.dart';

class MarketplaceSubscriptionCheckoutRepository extends ResponseListener {
  BuildContext? context;
  VoidCallback? onCheckoutSuccess;

  void startCheckout(
    BuildContext currentContext, {
    required int planId,
    VoidCallback? onSuccess,
  }) async {
    context = currentContext;
    onCheckoutSuccess = onSuccess;

    final rawData = {
      'planId': planId,
      'successUrl': NetworkStrings.marketplaceSubscriptionCheckoutSuccessUrl,
      'cancelUrl': NetworkStrings.marketplaceSubscriptionCheckoutCancelUrl,
    };

    final response = await DioClient().postRequest(
      endPoint: NetworkStrings.marketplaceSubscriptionCheckoutEndpoint,
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

    final response = await DioClient().postRequest(
      endPoint: NetworkStrings.marketplaceSubscriptionVerifyCheckoutEndpoint,
      data: <String, dynamic>{'sessionId': id},
      isHeaderRequire: true,
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
    if (response is! Map) return null;

    final outer = response['data'];
    if (outer is! Map) return null;

    // Supports both { data: { url, sessionId } } and { data: { data: { ... } } }
    final inner = outer['data'];
    if (inner is Map) {
      return Map<String, dynamic>.from(inner);
    }
    return Map<String, dynamic>.from(outer);
  }

  static String? _extractCheckoutUrl(dynamic response) {
    final data = _extractCheckoutData(response);
    final url = data?['url'] ?? data?['checkoutUrl'];
    return url is String && url.trim().isNotEmpty ? url.trim() : null;
  }

  static String? _extractSessionId(dynamic response) {
    final data = _extractCheckoutData(response);
    final sessionId = data?['sessionId'] ?? data?['id'];
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

    final ctx = context;
    if (ctx == null) return;

    CheckoutBrowser.open(
      ctx,
      checkoutUrl: checkoutUrl,
      successUrl: NetworkStrings.marketplaceSubscriptionCheckoutSuccessUrl,
      cancelUrl: NetworkStrings.marketplaceSubscriptionCheckoutCancelUrl,
      navigateOnSuccess: false,
      confirmSessionId: sessionId,
      confirmSession: confirmSession,
      onSuccess: onCheckoutSuccess,
    );
  }
}
