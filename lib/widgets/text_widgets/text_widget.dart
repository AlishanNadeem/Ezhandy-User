import 'package:ezhandy_user/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ezhandy_user/utils/app_colors.dart';

// ignore: must_be_immutable
class CustomText extends StatelessWidget {
  String? text;
  final Color? color;
  final FontWeight? fontWeight;
  String? fontFamily;
  final double? fontSize;
  AlignmentGeometry? align;
  TextAlign? textAlign;
  double? height;
  List<FontFeature>? fontFeatures;
  final int? maxLines;

  bool is_alignLeft;
  TextDecoration? textDecoration;

  CustomText(
      {Key? key,
      required this.text,
      this.color,
      this.height,
      this.fontWeight,
      this.fontFamily,
      this.textAlign,
      this.fontSize,
      this.fontFeatures,
      this.maxLines,
      this.align,
      this.is_alignLeft = true,
      this.textDecoration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: align ??
          (is_alignLeft == true ? Alignment.centerLeft : Alignment.center),
      child: Text(
        textAlign: is_alignLeft == false ? TextAlign.center : null,
        maxLines: maxLines,
        overflow:
            maxLines != null ? TextOverflow.ellipsis : TextOverflow.visible,
        text ?? "",
        style: TextStyle(
            fontFeatures: fontFeatures,
            fontFamily: fontFamily ?? AppStrings.montserrat,
            height: height
            // ?? 1.5
            ,
            fontSize: fontSize ?? 14.sp,
            color: color ?? AppColors.black,
            fontWeight: fontWeight ?? FontWeight.normal,
            decoration: textDecoration,
            decorationThickness: 1,
            decorationColor: color ?? AppColors.blueDark,
            overflow: TextOverflow.ellipsis),
      ),
    );
  }
}
