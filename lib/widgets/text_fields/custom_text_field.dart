import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ezhandy_user/utils/app_colors.dart';

// ignore: must_be_immutable
class CustomTextField extends StatefulWidget {
  void Function()? onPrefixTap;
  void Function()? onTap;
  String? prefxicon;
  TextInputType? keyboardType;
  double? prefixRIghtPadding, sufixRIghtPadding, prefixLeftPadding;
  Widget? sufixImage, prefixImage;
  int? lines;
  double? borderRadius;
  bool readOnly, divider, label;
  // FocusNode? myFocusNode;
  EdgeInsetsGeometry? contentPadding;
  final String hint;
  final double? fontSize, width;
  final bool? obscureText;
  final Color? prefixIconColor, hintColor, fillColor, borderColor, fontColor;
  TextEditingController? controller;
  String? Function(String?)? validator;
  void Function(String)? onchange;
  bool? suffix_divider;
  final void Function()? onclickSufix;
  List<TextInputFormatter>? inputFormatters;
  FocusNode? focusNode;
  CustomTextField({
    Key? key,
    this.onPrefixTap,
    this.prefxicon,
    this.borderRadius,
    this.prefixRIghtPadding,
    this.sufixRIghtPadding,
    this.borderColor,
    this.fontColor,
    this.prefixImage,
    this.fillColor,
    this.prefixLeftPadding,
    this.lines,
    this.obscureText = false,
    this.hintColor,
    required this.hint,
    this.fontSize,
    this.width,
    this.prefixIconColor,
    // this.myFocusNode,
    this.contentPadding,
    this.onclickSufix,
    this.controller,
    this.validator,
    this.onchange,
    this.onTap,
    this.keyboardType,
    this.sufixImage,
    this.readOnly = false,
    this.divider = true,
    this.suffix_divider = false,
    this.label = true,
    this.inputFormatters,
    this.focusNode,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // boxShadow: AppShadows.shadow1,
        borderRadius: BorderRadius.circular(widget.borderRadius ?? 10.r),
      ),
      child: TextFormField(
        // autovalidateMode: ,
        focusNode: widget.focusNode,
        onTap: widget.onTap,
        readOnly: widget.readOnly,
        keyboardType: widget.keyboardType,
        onChanged: widget.onchange,
        validator: widget.validator,
        controller: widget.controller,
        obscureText: widget.obscureText!,
        minLines: widget.lines ?? 1,
        maxLines: widget.lines ?? 1,
        cursorColor: AppColors.orange,
        inputFormatters: widget.inputFormatters,
        style: TextStyle(
            fontSize: widget.fontSize ?? 14.sp,
            color: widget.fontColor ?? AppColors.black),
        decoration: InputDecoration(
            filled: true,
            fillColor: widget.fillColor ?? AppColors.white,
            enabledBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(widget.borderRadius ?? 10.r),
                borderSide: BorderSide(
                    color: widget.borderColor ?? AppColors.greyBorder)),
            focusedBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(widget.borderRadius ?? 10.r),
                borderSide: BorderSide(
                    color: widget.borderColor ?? AppColors.orange)),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(widget.borderRadius ?? 10.r),
                borderSide:
                    BorderSide(color: widget.borderColor ?? AppColors.red)),
            errorBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(widget.borderRadius ?? 10.r),
                borderSide:
                    BorderSide(color: widget.borderColor ?? AppColors.red)),
            contentPadding: widget.prefxicon == null
                ? EdgeInsets.only(
                    top: 15.sp, left: 15.sp, bottom: 15.sp, right: 15.sp)
                : widget.contentPadding ?? null,
            label: widget.label ? Text(widget.hint) : null,
            labelStyle: TextStyle(
                color: widget.hintColor ?? AppColors.black, fontSize: 15),
            border: InputBorder.none,
            isDense: true,
            hintStyle: TextStyle(
                color: widget.hintColor ?? AppColors.black, fontSize: 15),
            hintText: !widget.label ? widget.hint : null,
            errorStyle: const TextStyle(
                overflow: TextOverflow.visible, color: AppColors.red),
            errorMaxLines: 3,
            prefixIcon: widget.prefixImage ??
                (widget.prefxicon != null
                    ? GestureDetector(
                        onTap: widget.onPrefixTap,
                        child: Container(
                          width: 30.w,
                          height: 25,
                          margin: EdgeInsets.only(left: 15.w, right: 5.w),
                          padding: EdgeInsets.only(
                            right: widget.prefixRIghtPadding ?? 5.w,
                            left: widget.prefixLeftPadding ?? 0,
                          ),
                          decoration: widget.divider == true
                              ? const BoxDecoration(
                                  border: Border(
                                      right:
                                          BorderSide(color: AppColors.white)))
                              : null,
                          child: Image.asset(
                            widget.prefxicon!,
                            color: widget.prefixIconColor??AppColors.orange,
                            scale: 3,
                          ),
                        ),
                      )
                    : null),
            prefixIconConstraints: const BoxConstraints(),
            suffixIcon: widget.sufixImage != null
                ? GestureDetector(
                    onTap: widget.onclickSufix,
                    child: Container(
                        height: 15,
                        margin: EdgeInsets.only(top: 5,bottom: 5,right: 10,left: 5),
                        decoration: widget.suffix_divider == true
                            ? BoxDecoration(
                                border: Border(
                                    left: BorderSide(
                                        color:
                                            AppColors.black.withOpacity(0.5))))
                            : null,
                        child: widget.sufixImage),
                  )
                : null),
      ),
    );
  }
}
