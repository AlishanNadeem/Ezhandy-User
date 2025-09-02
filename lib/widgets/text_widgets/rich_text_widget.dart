import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ezhandy_user/utils/app_colors.dart';

class RichTextWidget extends StatelessWidget {
  final String? text, subText;
  final Color? subTextColor;
  final double? fontSize;
  final VoidCallback? onSubTextPress;

  RichTextWidget({this.text, this.subText, this.onSubTextPress, this.subTextColor, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: text,
        style: TextStyle(color: AppColors.black, fontWeight: FontWeight.w500, fontSize: fontSize ?? 16),
        children: <TextSpan>[
          TextSpan(
            recognizer: TapGestureRecognizer()..onTap = onSubTextPress,
            text: subText,
            style: TextStyle(
              color: subTextColor ?? AppColors.orange,
              fontWeight: FontWeight.bold,
              // fontStyle: FontStyle.italic,
              // fontFamily: AppStrings.CAVIAR_DREAMS,
              fontSize: fontSize ?? 16,
              decoration: TextDecoration.underline,
            ),
          ),
        ],
      ),
    );
  }
}
