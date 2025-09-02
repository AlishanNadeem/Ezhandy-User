import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

// ignore: must_be_immutable
class CustomKeyboardActionWidget extends StatelessWidget {
  final Widget child;
  final FocusNode focusNode;
  KeyboardActionsPlatform? keyboardActionsPlatform;
  CustomKeyboardActionWidget({required this.child, required this.focusNode, this.keyboardActionsPlatform});
  @override
  Widget build(BuildContext context) {
    return KeyboardActions(config: _buildConfig(context), disableScroll: true, child: child);
  }

  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: keyboardActionsPlatform ?? KeyboardActionsPlatform.IOS,
      keyboardBarColor: AppColors.white,
      actions: [
        KeyboardActionsItem(
          focusNode: focusNode,
          displayArrows: false,
          displayDoneButton: true,
        ),
      ],
    );
  }
}
