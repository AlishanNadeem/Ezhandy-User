import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  ///Keyboard Un-Focus
  void unFocusKeyBoard() {
    FocusScope.of(this).unfocus();
  }

  /// Checking Bottom insets
  double get bottomViewInsets => MediaQuery.of(this).viewInsets.bottom;
}
