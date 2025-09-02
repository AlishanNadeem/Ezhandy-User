// // ignore_for_file: must_be_immutable

// import 'package:ezhandy_user/utils/app_colors.dart';
// import 'package:ezhandy_user/utils/app_strings.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';
// import 'package:intl_phone_field/phone_number.dart';

// class PhoneNumberTextField extends StatelessWidget {
//   final Color? backgroundColor;
//   final Color? borderColor;
//   final Color? curserColor;
//   final Color? textColor;
//   final Color? hintColor;
//   // final Color? borderColor;
//   String? hintText, errorText;
//   String? label;
//   String? initialCountryCode;
//   final ValueChanged<PhoneNumber>? onChanged;
//   final bool? isBorder;
//   final bool? isEmptyCheck;
//   final bool isReadOnly;
//   final bool is_clickable;
//   final TextEditingController? controller;
//   final Future<String?> Function(PhoneNumber?)? validator;
//   final FocusNode focusNode;
//   final Widget? suffixWidget;
//   PhoneNumberTextField(
//       {Key? key,
//       this.controller,
//       this.suffixWidget,
//       this.textColor,
//       this.initialCountryCode,
//       this.validator,
//       this.backgroundColor,
//       this.isEmptyCheck,
//       this.borderColor,
//       this.isBorder,
//       this.errorText,
//       this.hintText,
//       this.curserColor,
//       this.label,
//       required this.focusNode,
//       this.isReadOnly = false,
//       this.is_clickable = true,
//       this.onChanged,
//       this.hintColor})
//       : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return IntlPhoneField(
//       isEmptyCheck: isEmptyCheck,
//       hintColor: hintColor,
//       borderColor: borderColor,
//       suffixWidget: suffixWidget,
//       showCountryFlag: false,
//       flagsButtonMargin: EdgeInsets.only(left: 10.sp),
//       focusNode: focusNode,
//       initialCountryCode: initialCountryCode,
//       cursorColor: AppColors.backButtonPurple,
//       enabled: is_clickable,
//       showCursor: is_clickable,
//       readOnly: isReadOnly,
//       showDropdownIcon: false,
//       dropdownIconPosition: IconPosition.trailing,
//       invalidNumberMessage: errorText ?? AppStrings.invalidPhoneNumber,
//       validator: validator,
//       style: TextStyle(
//         fontSize: 16,
//         color: textColor ?? AppColors.white,
//       ),
//       autovalidateMode: AutovalidateMode.onUserInteraction,
//       controller: controller,
//       dropdownTextStyle: TextStyle(
//         fontSize: 14.sp,
//         color: textColor ?? AppColors.white,
//       ),
//       hintText: hintText ?? AppStrings.phoneNumber,
//       inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//       // decoration: InputDecoration(
//       //   filled: true,
//       //   fillColor: AppColors.white,
//       //   contentPadding: EdgeInsets.only(left: 15.w),

//       //   hintText: hintText ?? AppStrings.phoneNumber,
//       //   counter: const SizedBox.shrink(),
//       //   border: UnderlineInputBorder(
//       //     borderSide: BorderSide(
//       //       color: AppColors.borderColor,
//       //     ),
//       //   ),
//       //   hintStyle: TextStyle(color: AppColors.fontColor, fontSize: 14.sp),
//       //   // label: Text(label!),
//       //   // labelStyle: TextStyle(color: AppColors.fontColor, fontSize: 14.sp),
//       //   errorMaxLines: 3,
//       //   enabledBorder: OutlineInputBorder(
//       //       borderRadius: BorderRadius.circular(35),
//       //       borderSide: BorderSide(width: 1, color: AppColors.borderColor)),
//       //   focusedBorder: OutlineInputBorder(
//       //       borderRadius: BorderRadius.circular(35),
//       //       borderSide: BorderSide(color: AppColors.borderColor)),
//       //   errorBorder: OutlineInputBorder(
//       //       borderRadius: BorderRadius.circular(35),
//       //       borderSide: BorderSide(color: AppColors.borderColor)),
//       //   focusedErrorBorder: OutlineInputBorder(
//       //       borderRadius: BorderRadius.circular(35),
//       //       borderSide: const BorderSide(color: AppColors.borderColor)),
//       //   errorStyle: const TextStyle(
//       //     color: Colors.red,
//       //     height: 1,
//       //   ),
//       // ),

//       onChanged: onChanged,
//       onCountryChanged: (country) {
//         print('Country changed to: ' + country.name);
//       },
//     );
//   }
// }
