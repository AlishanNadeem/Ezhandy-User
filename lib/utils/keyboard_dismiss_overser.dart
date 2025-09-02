import 'package:flutter/material.dart';

class KeyboardDismissObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    // Dismiss keyboard when a new route is pushed
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    // Dismiss keyboard when a route is popped
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
