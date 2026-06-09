import 'package:ezhandy_user/module/core/community/routing_arguments/checkout_routing_arguments.dart';
import 'package:ezhandy_user/utils/routes/app_navigation.dart';
import 'package:ezhandy_user/utils/routes/app_route.dart';
import 'package:flutter/material.dart';

class CheckoutBrowser {
  CheckoutBrowser._();

  static void open(
    BuildContext context, {
    required String checkoutUrl,
    required String successUrl,
    required String cancelUrl,
    String? successRoute,
  }) {
    AppNavigation.navigateTo(
      context,
      AppRoutes.checkoutWebViewScreenRoute,
      arguments: CheckoutRoutingArguments(
        checkoutUrl: checkoutUrl,
        successUrl: successUrl,
        cancelUrl: cancelUrl,
        successRoute: successRoute ?? AppRoutes.createAProPostScreenRoute,
      ),
    );
  }
}
