import 'package:flutter/material.dart';
import 'dart:developer';

class AppNavigation {
  static void navigateToRemovingAll(context, String routeName,
      {Object? arguments}) async {
    log("\\" + routeName);
    Navigator.pushNamedAndRemoveUntil(
        context, routeName, (Route<dynamic> route) => false,
        arguments: arguments);
  }

  static void navigateTo(BuildContext context, String routeName,
      {Object? arguments}) async {
    log("\\" + routeName);
    Navigator.pushNamed(context, routeName, arguments: arguments);
  }

  static void navigatorPopUntil(BuildContext context, String routeName) async {
    log("\\" + routeName);
    Navigator.popUntil(context, ModalRoute.withName(routeName));
  }

  static void navigateReplacementNamed(BuildContext context, String routeName,
      {Object? arguments}) async {
    log("\\" + routeName);
    Navigator.pushReplacementNamed(context, routeName, arguments: arguments);
  }

  static void navigatorPop(BuildContext context) {
    Navigator.pop(context);
  }

  static void navigateCloseDialog(BuildContext context) async {
    Navigator.of(context, rootNavigator: true).pop();
  }
}
