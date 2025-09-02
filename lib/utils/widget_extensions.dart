import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:flutter/material.dart';

extension ListOfWidgetsExtension on List<Widget> {
  List<Widget> spacedVertically(double spacing) {
    return expand((Widget element) => [element, SizedBox(height: spacing)]).toList();
  }
}

extension TextExtension on Text {
  Text withRedAsterisk() {
    return Text.rich(
      TextSpan(
        text: this.data,
        children: [
          TextSpan(
            text: ' *',
            style: TextStyle(color: AppColors.red),
          ),
        ],
      ),
      style: this.style,
    );
  }
}

extension StringExtension on String {
  String withColon() {
    return "$this:";
  }
}
