import 'dart:developer';

import 'package:ezhandy_user/dio_client/dio_client.dart';
import 'package:ezhandy_user/utils/app_dialogs.dart';
import 'package:ezhandy_user/utils/checkout_browser.dart';
import 'package:ezhandy_user/utils/listeners.dart';
import 'package:ezhandy_user/utils/network_strings.dart';
import 'package:ezhandy_user/utils/routes/app_route.dart';
import 'package:flutter/material.dart';

class AskProBuyCreditsRepository extends ResponseListener {
  BuildContext? context;
  VoidCallback? onCheckoutSuccess;
  String? _successUrl;
  String? _cancelUrl;

  Future<void> startBuyCredits(
    BuildContext currentContext, {
    required String askProChatId,
    VoidCallback? onCheckoutSuccess,
  }) async {
    context = currentContext;
    this.onCheckoutSuccess = onCheckoutSuccess;
    _successUrl = NetworkStrings.askProBuyCreditsSuccessUrl;
    _cancelUrl = NetworkStrings.askProBuyCreditsCancelUrl;

    final id = askProChatId.trim();
    if (id.isEmpty) {
      AppDialogs.showToast(message: 'Unable to start checkout');
      return;
    }

    final response = await DioClient().postRequest(
      endPoint: NetworkStrings.askProBuyCredits(id),
      data: {
        'successUrl': _successUrl,
        'cancelUrl': _cancelUrl,
      },
      responseListener: this,
      isHeaderRequire: true,
    );

    DioClient().validateResponse(
      response: response,
      responseListener: this,
    );
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
    if (data == null) return null;

    for (final key in ['session_id', 'sessionId', 'session_ikd']) {
      final value = data[key];
      if (value is String && value.trim().isNotEmpty) {
        return value.trim();
      }
    }
    return null;
  }

  static Future<bool> confirmCredits(String sessionId) async {
    final id = sessionId.trim();
    if (id.isEmpty) return false;

    var success = false;

    final response = await DioClient().getRequest(
      endPoint: NetworkStrings.askProConfirmCredits(id),
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

  @override
  void onSuccess({response}) {
    log(response.toString());

    final checkoutUrl = _extractCheckoutUrl(response);
    final sessionId = _extractSessionId(response);
    if (checkoutUrl == null || context == null) {
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
      successUrl: _successUrl ?? NetworkStrings.askProBuyCreditsSuccessUrl,
      cancelUrl: _cancelUrl ?? NetworkStrings.askProBuyCreditsCancelUrl,
      successRoute: AppRoutes.chatScreenRoute,
      navigateOnSuccess: false,
      confirmSessionId: sessionId,
      confirmSession: AskProBuyCreditsRepository.confirmCredits,
      onSuccess: onCheckoutSuccess,
    );
  }
}
