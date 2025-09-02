import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  final String text;
  String? btnimg, prefixbtnimg;
  Color? color;
  String? fontFamily;
  final Color? textcolor, borderColor;
  final double? fontSize,borderRadius ,height, width, iconsize;
  final Function()? onclick;
  FontWeight? fontWeight;
  bool? is_spaceBetween, is_shadow;
  List<BoxShadow>? boxShadow;
  // bool isGradient;
  EdgeInsetsGeometry? padding;
  CustomButton(
      {Key? key,
      required this.text,
      this.btnimg,
      this.prefixbtnimg,
      this.borderRadius,
      this.color,
      this.fontSize,
      this.fontWeight,
      this.fontFamily,
      this.boxShadow,
      this.borderColor,
      this.padding,
      this.height,
      this.width,
      this.iconsize,
      this.textcolor,
      this.onclick,
      // this.isGradient = true,
      this.is_shadow = true,
      this.is_spaceBetween = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onclick,
      child: Container(
        width: width ?? 1.sw,
        height: height ?? 0.06.sh,
        padding: padding,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius?? 10.sp),
          border: Border.all(color: borderColor ?? AppColors.transparent),

          //  boxShadow == null ? (color != null ? Border.all(color: AppColors.borderColor) : null) : null,
          color: color ?? AppColors.orange,
          //  color ?? AppColors.buttonColor,
          // gradient: color==null? AppGradients.buttonGradient : null,
          // boxShadow: boxShadow ??

          //     // boxShadow ?? (color == null ?
          //     AppShadows.shadow1
          // : AppShadows.shadow1
        ),
        child: Row(
            mainAxisAlignment: is_spaceBetween == true
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.center,
            children: [
              prefixbtnimg != null
                  ? Padding(
                      padding: EdgeInsets.only(
                          right: is_spaceBetween == true ? 0.sp : 10.sp),
                      child: Image.asset(
                        prefixbtnimg!,
                        scale: iconsize ?? 4,
                        // color: AppColors.white,
                      ),
                    )
                  : const SizedBox(),
              CustomText(
                text: text,

                // fontFamily: AppStrings.CAVIAR_ DREAMS,
                color: textcolor ?? AppColors.white,
                fontSize: fontSize ?? 14.sp,
                textDecoration: TextDecoration.none,
                // fontWeight: fontWeight ?? FontWeight.bold
              ),
              btnimg != null
                  ? Padding(
                      padding: EdgeInsets.only(
                          left: is_spaceBetween == true ? 0.sp : 10.sp),
                      child: Image.asset(
                        btnimg!,
                        scale: iconsize ?? 4,
                        color: AppColors.white,
                      ),
                    )
                  : const SizedBox(width: 0.0),
            ]),
      ),
    );
  }
}
