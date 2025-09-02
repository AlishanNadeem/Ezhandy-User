// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:ezhandy_user/module/core/controller/home_controller.dart';
// import 'package:ezhandy_user/utils/app_colors.dart';
// import 'package:ezhandy_user/utils/app_padding.dart';
// import 'package:ezhandy_user/utils/app_strings.dart';
// import 'package:ezhandy_user/utils/asset_path.dart';
// import 'package:ezhandy_user/utils/routes/app_navigation.dart';
// import 'package:ezhandy_user/widgets/button_widgets/custom_button.dart';
// import 'package:ezhandy_user/widgets/text_fields/custom_text_field.dart';
// import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';
// import 'package:ezhandy_user/widgets/toast_dialogs_sheet/custom_bottom_sheet.dart';
// import 'package:syncfusion_flutter_sliders/sliders.dart';

// // ignore: must_be_immutable
// class ExploreFilterBottomSheet extends StatefulWidget {
//   ExploreFilterBottomSheet({super.key});

//   @override
//   State<ExploreFilterBottomSheet> createState() =>
//       _ExploreFilterBottomSheetState();
// }

// class _ExploreFilterBottomSheetState extends State<ExploreFilterBottomSheet> {
//   SfRangeValues _values = SfRangeValues(2, 6);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         FocusScope.of(context).unfocus();
//       },
//       child: CustomBottomSheet(
//         isPadding: false,
//         isTopPadding: false,
//         // isGradient: true,
//         // showBar: true,
//         showCross: true,
//         title: AppStrings.searchFilter,
//         // titleColor: AppColors.white,
//         height: MediaQuery.of(context).viewInsets.bottom > 0 ? 0.9.sh : 0.55.sh,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(
//                   horizontal: AppPadding.defaultHorizontalPadding),
//               child: CustomText(
//                 text: AppStrings.category,
//                 // color: AppColors.white,
//                 fontSize: 16.sp,
//               ),
//             ),
//             10.verticalSpace,
//             categoryTextField(),
//             10.verticalSpace,

//             Padding(
//               padding: const EdgeInsets.symmetric(
//                   horizontal: AppPadding.defaultHorizontalPadding),
//               child: CustomText(
//                 text: AppStrings.priceRange,
//                 // color: AppColors.white,
//                 fontSize: 16.sp,
//               ),
//             ),
//             10.verticalSpace,
//             Padding(
//               padding: const EdgeInsets.symmetric(
//                   horizontal: AppPadding.defaultHorizontalPadding),
//               child: Row(
//                 children: [
//                   Expanded(child: minTextField()),
//                   20.horizontalSpace,
//                   Expanded(child: maxTextField())
//                 ],
//               ),
//             ),
//             20.verticalSpace,

//             radiusMilesRow(),
//             10.verticalSpace,
//             milesSlider(),
//             rangeWidget(),
//             // 20.verticalSpace,

//             // 5.verticalSpace,
//             // ageSlider(),
//             .03.sh.verticalSpace,
//             MediaQuery.of(context).viewInsets.bottom > 0
//                 ? SizedBox.shrink()
//                 : btnWidget(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget categoryTextField() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(
//           horizontal: AppPadding.defaultHorizontalPadding),
//       child: CustomTextField(
//         borderRadius: 8.r,
//         fillColor: AppColors.white,
//         fontColor: AppColors.black,
//         hintColor: AppColors.iconGrey,
//         // prefixIconColor: AppColors.fontColor,
//         borderColor: AppColors.backButtonPurple,
//         divider: false,
//         label: false,
//         // prefxicon: AssetPath.searchIcon,

//         hint: AppStrings.enterCategory,
//         inputFormatters: [LengthLimitingTextInputFormatter(35)],
//         // controller: firstNameController,
//       ),
//     );
//   }

//   Widget minTextField() {
//     return CustomTextField(
//       borderRadius: 8.r,
//       fillColor: AppColors.white,
//       fontColor: AppColors.black,
//       hintColor: AppColors.iconGrey,
//       // prefixIconColor: AppColors.fontColor,
//       borderColor: AppColors.backButtonPurple,
//       divider: false,
//       label: false,
//       // prefxicon: AssetPath.searchIcon,

//       hint: AppStrings.min,
//       keyboardType: TextInputType.numberWithOptions(decimal: true),
//       inputFormatters: [
//         LengthLimitingTextInputFormatter(6),
//         FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$'))
//       ],
//       // controller: firstNameController,
//     );
//   }

//   Widget maxTextField() {
//     return CustomTextField(
//       borderRadius: 8.r,
//       fillColor: AppColors.white,
//       fontColor: AppColors.black,
//       hintColor: AppColors.iconGrey,
//       // prefixIconColor: AppColors.fontColor,
//       borderColor: AppColors.backButtonPurple,
//       divider: false,
//       label: false,
//       // prefxicon: AssetPath.searchIcon,

//       hint: AppStrings.max,
//       keyboardType: TextInputType.numberWithOptions(decimal: true),
//       inputFormatters: [
//         LengthLimitingTextInputFormatter(6),
//         FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$'))
//       ],
//       // controller: firstNameController,
//     );
//   }

//   Padding rangeWidget() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(
//           horizontal: AppPadding.defaultHorizontalPadding),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           CustomText(
//             text: "0 miles",
//             color: AppColors.fontColor,
//           ),
//           CustomText(
//             text: "10 miles",
//             color: AppColors.fontColor,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget milesSlider() {
//     return Stack(
//       alignment: Alignment.center,
//       children: [
//         Positioned(left: 20.w, child: verticalDividerWidget()),
//         SfRangeSlider(
//           min: 0,
//           max: 10,
//           values: _values,
//           interval: 5,
//           showTicks: false,

//           // showTicks: true,
//           // showLabels: true,
//           enableTooltip: true,
//           minorTicksPerInterval: 5,
//           activeColor: AppColors.backButtonPurple,
//           inactiveColor: AppColors.white,

//           startThumbIcon: thumbWidget(),
//           endThumbIcon: thumbWidget(),
//           onChanged: (SfRangeValues values) {
//             setState(() {
//               _values = values;
//             });
//           },
//           tooltipTextFormatterCallback: (dynamic value, String label) {
//             // Custom tooltip formatter (rounded value and a suffix)
//             return '${value.round()}'; // Modify as needed
//           },
//         ),
//         Positioned(right: 20.w, child: verticalDividerWidget()),
//       ],
//     );
//   }

//   Widget radiusMilesRow() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(
//           horizontal: AppPadding.defaultHorizontalPadding),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           CustomText(
//             text: AppStrings.radius,
//             // color: AppColors.white,
//             fontSize: 16.sp,
//           ),
//           CustomText(
//             text: AppStrings.miles,
//             // color: AppColors.white,
//             fontSize: 16.sp,
//           ),
//         ],
//       ),
//     );
//   }

//   Container verticalDividerWidget() {
//     return Container(
//       width: 2.w,
//       height: 20.h,
//       color: AppColors.backButtonPurple,
//     );
//   }

//   Container thumbWidget() {
//     return Container(
//       decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           border: Border.all(color: AppColors.white),
//           color: AppColors.backButtonPurple),
//     );
//   }

//   Widget btnWidget() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(
//           horizontal: AppPadding.defaultHorizontalPadding),
//       child: CustomButton(
//         isAuth: false,
//         // /boxShadow: AppShadows.shadow2,
//         onclick: () {
//           // setState(() {
//           //   requestSent = !requestSent;
//           // });
//           // validateGender(genderValue);
//           // validateCountry(countryValue);
//           // // validateCity(cityValue);
//           // // validateState(stateValue);
//           // if (FormKey.currentState!.validate()) {
//           AppNavigation.navigatorPop(context);
//           // HomeController.i.selectedTab.value = 1;
//           // }
//         },
//         text: AppStrings.apply.toUpperCase(),
//       ),
//     );
//   }
// }
