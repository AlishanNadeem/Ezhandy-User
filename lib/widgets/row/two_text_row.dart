// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';

class TwoTextRow extends StatelessWidget {
  String firstText, secondText;
  Color? firstColor;
  bool? withPadding;
  TwoTextRow({required this.firstText, required this.secondText, this.firstColor, this.withPadding = true, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: withPadding! ? EdgeInsets.symmetric(vertical: 5.sp) : EdgeInsets.zero,
      child: Row(children: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: textWidget(text: firstText, fontcolor: firstColor, fontWeight: FontWeight.w400),
        ),
        Expanded(
          child: textWidget(text: secondText, fontcolor: AppColors.blueDark,fontWeight: FontWeight.bold),
        )
      ]),
    );
  }

  Widget textWidget({String? text, Color? fontcolor, FontWeight? fontWeight}) {
    return CustomText(
      align: Alignment.centerRight,
      text: text,
      fontWeight: fontWeight,
      color: fontcolor ?? null,
    );
  }
}
