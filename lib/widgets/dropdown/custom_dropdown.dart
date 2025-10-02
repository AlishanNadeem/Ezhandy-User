// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:ezhandy_user/utils/app_colors.dart';
// import 'package:ezhandy_user/utils/asset_path.dart';
// import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';

// // ignore: must_be_immutable
// class CustomDropDown2 extends StatefulWidget {
//   final String? dropdownValue, hintText;
//   final List<String>? dropDownData;
//   final Function(String)? onChanged;
//   final Color? color, dropdownListColor;
//   final String? Function(String?)? validator; // ✅ validator
//   final double? width,
//       borderRadius,
//       fontSize,
//       dropDownWidth,
//       menuItemPadding,
//       horizontalPadding,
//       verticalPadding;
//   final Color? borderColor, hintTextColor, fillColor;
//   final Offset? offset;

//   const CustomDropDown2({
//     Key? key,
//     this.dropDownData,
//     this.dropdownValue,
//     this.borderRadius,
//     this.width,
//     this.onChanged,
//     this.validator,
//     this.fontSize = 15.5,
//     this.fillColor,
//     this.dropdownListColor,
//     this.hintText,
//     this.hintTextColor,
//     this.verticalPadding,
//     this.horizontalPadding,
//     this.menuItemPadding,
//     this.dropDownWidth,
//     this.offset,
//     this.borderColor,
//     this.color,
//   }) : super(key: key);

//   @override
//   State<CustomDropDown2> createState() => _CustomDropDown2State();
// }

// class _CustomDropDown2State extends State<CustomDropDown2> {
//   String? _errorText;

//   @override
//   Widget build(BuildContext context) {
//     return FormField<String>(
//       validator: widget.validator,
//       autovalidateMode: AutovalidateMode.onUserInteraction,
//       builder: (FormFieldState<String> state) {
//         _errorText = state.errorText;

//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             DropdownButtonFormField2<String>(
//               value: widget.dropdownValue,
//               style: TextStyle(
//                 color: widget.color ?? AppColors.black,
//                 fontSize: widget.fontSize!.sp,
//               ),
//               hint: Text(
//                 widget.hintText ?? "",
//                 style: TextStyle(
//                   fontSize: 14.sp,
//                   color: widget.hintTextColor ?? AppColors.greyBorder,
//                 ),
//               ),
//               decoration: InputDecoration(
//                 contentPadding: EdgeInsets.zero,
//                 border: OutlineInputBorder(
//                   borderRadius:
//                       BorderRadius.circular(widget.borderRadius ?? 35),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius:
//                       BorderRadius.circular(widget.borderRadius ?? 35),
//                   borderSide: BorderSide(
//                     color: state.hasError
//                         ? AppColors.red
//                         : (widget.borderColor ?? AppColors.greyBorder),
//                   ),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius:
//                       BorderRadius.circular(widget.borderRadius ?? 35),
//                   borderSide: BorderSide(
//                     color: state.hasError
//                         ? AppColors.red
//                         : (widget.borderColor ?? AppColors.greyBorder),
//                     width: 1.5,
//                   ),
//                 ),
//                 errorStyle: const TextStyle(
//                   height: 0,
//                   fontSize: 0,
//                 ),
//                 filled: true,
//                 fillColor: widget.fillColor ?? AppColors.white,
//               ),
//               isExpanded: true,
//               items: widget.dropDownData!
//                   .map((String value) => DropdownMenuItem<String>(
//                         value: value,
//                         child: CustomText(
//                           text: value,
//                           color: widget.color ?? AppColors.black,
//                         ),
//                       ))
//                   .toList(),
//               onChanged: (newValue) {
//                 state.didChange(newValue);
//                 if (widget.onChanged != null && newValue != null) {
//                   widget.onChanged!(newValue);
//                 }
//               },

//               // ✅ Apply widths here
//               buttonStyleData: ButtonStyleData(
//                 width: widget.width ?? 95.w,
//                 padding: EdgeInsets.symmetric(
//                   horizontal:
//                       widget.horizontalPadding ?? 16.w, // 👈 left/right padding
//                   vertical: widget.verticalPadding ?? 0,
//                 ),
//               ),
//               dropdownStyleData: DropdownStyleData(
//                 width: widget.dropDownWidth ?? 150.w,
//                 decoration: BoxDecoration(
//                   color: widget.dropdownListColor ?? AppColors.white,
//                   borderRadius:
//                       BorderRadius.circular(widget.borderRadius ?? 12),
//                 ),
//                 offset: widget.offset ?? const Offset(0, 0),
//               ),
//             ),
//             // ✅ Custom error text with left padding
//             if (_errorText != null)
//               Padding(
//                 padding: const EdgeInsets.only(left: 16, top: 4),
//                 child: Text(
//                   _errorText!,
//                   style: const TextStyle(
//                     color: AppColors.red,
//                     fontSize: 12,
//                   ),
//                 ),
//               ),
//           ],
//         );
//       },
//     );
//   }
// }

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';

// ignore: must_be_immutable
class CustomDropDown2 extends StatefulWidget {
  final String? dropdownValue, hintText;
  final List<String>? dropDownData;
  final Function(String)? onChanged;
  final Color? color, dropdownListColor;
  final String? Function(String?)? validator; // ✅ validator
  final double? width,dropDownHeight,
      borderRadius,
      fontSize,
      dropDownWidth,
      menuItemPadding,
      horizontalPadding,
      verticalPadding;
  final Color? borderColor, hintTextColor, fillColor;
  final Offset? offset;

  const CustomDropDown2({
    Key? key,
    this.dropDownData,
    this.dropDownHeight,
    this.dropdownValue,
    this.borderRadius,
    this.width,
    this.onChanged,
    this.validator,
    this.fontSize = 15.5,
    this.fillColor,
    this.dropdownListColor,
    this.hintText,
    this.hintTextColor,
    this.verticalPadding,
    this.horizontalPadding,
    this.menuItemPadding,
    this.dropDownWidth,
    this.offset,
    this.borderColor,
    this.color,
  }) : super(key: key);

  @override
  State<CustomDropDown2> createState() => _CustomDropDown2State();
}

class _CustomDropDown2State extends State<CustomDropDown2> {
  String? _errorText;

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      builder: (FormFieldState<String> state) {
        _errorText = state.errorText;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ✅ Wrapped with SizedBox so InputDecorator always has finite width
            SizedBox(
              width: widget.width ?? double.infinity,
              child: DropdownButtonFormField2<String>(
                value: widget.dropdownValue,
                style: TextStyle(
                  color: widget.color ?? AppColors.black,
                  fontSize: widget.fontSize!.sp,
                ),
                hint: Text(
                  widget.hintText ?? "",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: widget.hintTextColor ?? AppColors.greyBorder,
                  ),
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(widget.borderRadius ?? 35),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(widget.borderRadius ?? 35),
                    borderSide: BorderSide(
                      color: state.hasError
                          ? AppColors.red
                          : (widget.borderColor ?? AppColors.greyBorder),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(widget.borderRadius ?? 35),
                    borderSide: BorderSide(
                      color: state.hasError
                          ? AppColors.red
                          : (widget.borderColor ?? AppColors.greyBorder),
                      width: 1.5,
                    ),
                  ),
                  errorStyle: const TextStyle(
                    height: 0,
                    fontSize: 0,
                  ),
                  filled: true,
                  fillColor: widget.fillColor ?? AppColors.white,
                ),
                isExpanded: true,
                items: widget.dropDownData!
                    .map((String value) => DropdownMenuItem<String>(
                          value: value,
                          child: CustomText(
                            text: value,
                            color: widget.color ?? AppColors.black,
                          ),
                        ))
                    .toList(),
                onChanged: (newValue) {
                  state.didChange(newValue);
                  if (widget.onChanged != null && newValue != null) {
                    widget.onChanged!(newValue);
                  }
                },

                // ✅ Button styling
                buttonStyleData: ButtonStyleData(
                  width: widget.width ?? double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: widget.horizontalPadding ?? 16.w,
                    vertical: widget.verticalPadding ?? 0,
                  ),
                ),

                // ✅ Dropdown styling
                dropdownStyleData: DropdownStyleData(
                  maxHeight:widget.dropDownHeight,
                  width: widget.dropDownWidth ?? widget.width ?? 150.w,
                  decoration: BoxDecoration(
                    color: widget.dropdownListColor ?? AppColors.white,
                    borderRadius:
                        BorderRadius.circular(widget.borderRadius ?? 12),
                  ),
                  offset: widget.offset ?? const Offset(0, 0),
                ),
              ),
            ),

            // ✅ Custom error text with left padding
            if (_errorText != null)
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 4),
                child: Text(
                  _errorText!,
                  style: const TextStyle(
                    color: AppColors.red,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
