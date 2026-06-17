import 'package:flutter/material.dart';

class CheckoutRoutingArguments {
  final String checkoutUrl;
  final String successUrl;
  final String cancelUrl;
  final String successRoute;
  final VoidCallback? onSuccess;
  final String? confirmSessionId;

  CheckoutRoutingArguments({
    required this.checkoutUrl,
    required this.successUrl,
    required this.cancelUrl,
    required this.successRoute,
    this.onSuccess,
    this.confirmSessionId,
  });
}
