import 'package:ezhandy_user/dio_client/dio_client.dart';
import 'package:ezhandy_user/module/core/community/data/repository/ask_pro_checkout_repository.dart';
import 'package:ezhandy_user/module/core/community/model/ask_pro_pricing_model.dart';
import 'package:ezhandy_user/module/core/community/widgets/ask_pro_pricing_dialog.dart';
import 'package:ezhandy_user/utils/app_dialogs.dart';
import 'package:ezhandy_user/utils/listeners.dart';
import 'package:ezhandy_user/utils/network_strings.dart';
import 'package:ezhandy_user/utils/routes/app_navigation.dart';
import 'package:ezhandy_user/utils/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AskProController extends GetxController {
  final RxBool isCheckingStatus = false.obs;

  Future<void> handleAskProTap(BuildContext context) async {
    if (isCheckingStatus.value) return;

    isCheckingStatus.value = true;
    try {
      final isAskPro = await fetchIsAskPro();

      if (!context.mounted) return;

      if (isAskPro == null) {
        AppDialogs.showToast(message: 'Unable to check Ask a Pro status');
        return;
      }

      if (isAskPro) {
        AppNavigation.navigateTo(context, AppRoutes.createAProPostScreenRoute);
        return;
      }

      final pricing = await fetchPricing();

      if (!context.mounted) return;

      if (pricing == null) {
        AppDialogs.showToast(message: 'Unable to load Ask a Pro pricing');
        return;
      }

      await AskProPricingDialog.show(
        context,
        pricing: pricing,
        onContinue: () {
          AskProCheckoutRepository().startCheckout(context);
        },
      );
    } finally {
      isCheckingStatus.value = false;
    }
  }

  /// Always calls the API — no cached status is stored between taps.
  Future<bool?> fetchIsAskPro() async {
    bool? isAskPro;

    final response = await DioClient().getRequest(
      endPoint: NetworkStrings.askProStatusEndpoint,
      queryParameters: {
        '_': DateTime.now().millisecondsSinceEpoch,
      },
      isHeaderRequire: true,
      isLoader: true,
    );

    await DioClient().validateResponse(
      response: response,
      responseListener: CallbackResponseListener(
        onSuccessCallback: (res) => isAskPro = _parseIsAskPro(res),
        onFailureCallback: (_) => isAskPro = null,
      ),
    );

    return isAskPro;
  }

  /// Fetches pricing for the checkout popup — called fresh each tap.
  Future<AskProPricing?> fetchPricing() async {
    AskProPricing? pricing;

    final response = await DioClient().getRequest(
      endPoint: NetworkStrings.askProPricingEndpoint,
      queryParameters: {
        '_': DateTime.now().millisecondsSinceEpoch,
      },
      isHeaderRequire: true,
      isLoader: true,
    );

    await DioClient().validateResponse(
      response: response,
      responseListener: CallbackResponseListener(
        onSuccessCallback: (res) {
          pricing = AskProPricing.fromApiResponse(res);
        },
        onFailureCallback: (_) => pricing = null,
      ),
    );

    return pricing;
  }

  static bool? _parseIsAskPro(dynamic response) {
    final outer = response is Map ? response['data'] : null;
    if (outer is! Map) return null;

    final inner = outer['data'];
    if (inner is! Map) return null;

    final value = inner['isAskPro'];
    if (value is bool) return value;
    return null;
  }
}
