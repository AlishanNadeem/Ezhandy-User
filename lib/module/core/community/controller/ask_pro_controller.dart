import 'package:ezhandy_user/dio_client/dio_client.dart';
import 'package:ezhandy_user/module/core/community/data/repository/ask_pro_checkout_repository.dart';
import 'package:ezhandy_user/utils/app_dialogs.dart';
import 'package:ezhandy_user/utils/app_strings.dart';
import 'package:ezhandy_user/utils/asset_path.dart';
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

      _showCheckoutPopup(context);
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

  static bool? _parseIsAskPro(dynamic response) {
    final outer = response is Map ? response['data'] : null;
    if (outer is! Map) return null;

    final inner = outer['data'];
    if (inner is! Map) return null;

    final value = inner['isAskPro'];
    if (value is bool) return value;
    return null;
  }

  void _showCheckoutPopup(BuildContext context) {
    AppDialogs.showSuccessDialog(
      context,
      description:
          'Get expert help instantly. Make a payment to ask a Pro.',
      title: '\$4.99/ 5 text messages',
      image: AssetPath.proUserIcon,
      isDoneShow: false,
      btnTxt1: AppStrings.continuee,
      onTap1: () {
        AppNavigation.navigateCloseDialog(context);
        AskProCheckoutRepository().startCheckout(context);
      },
      btnTxt2: AppStrings.cancel,
      onTap2: () {
        AppNavigation.navigatorPop(context);
      },
    );
  }
}
