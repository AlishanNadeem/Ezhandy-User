// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:ezhandy_user/module/core/controller/home_controller.dart';
// import 'package:ezhandy_user/utils/app_colors.dart';
// import 'package:ezhandy_user/utils/app_padding.dart';
// import 'package:ezhandy_user/utils/app_strings.dart';
// import 'package:ezhandy_user/utils/asset_path.dart';
// import 'package:ezhandy_user/utils/routes/app_navigation.dart';
// import 'package:ezhandy_user/utils/routes/app_route.dart';
// import 'package:ezhandy_user/widgets/button_widgets/custom_button.dart';
// import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';
// import 'package:ezhandy_user/widgets/toast_dialogs_sheet/custom_bottom_sheet.dart';
// import 'package:syncfusion_flutter_sliders/sliders.dart';

// // ignore: must_be_immutable
// class FilterBottomSheet extends StatefulWidget {
//   FilterBottomSheet({super.key});

//   @override
//   State<FilterBottomSheet> createState() => _FilterBottomSheetState();
// }

// class _FilterBottomSheetState extends State<FilterBottomSheet> {
//   SfRangeValues _values = SfRangeValues(2, 6);
//   SfRangeValues _ageValues = SfRangeValues(25, 30);
//   String gender = AppStrings.male;

//   @override
//   Widget build(BuildContext context) {
//     return CustomBottomSheet(
//       isPadding: false,
//       isGradient: true,
//       showBar: true,
//       title: AppStrings.filter,
//       titleColor: AppColors.white,
//       height: 0.7.sh,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(
//                 horizontal: AppPadding.defaultHorizontalPadding),
//             child: CustomText(
//               text: AppStrings.interestedIn,
//               color: AppColors.white,
//               fontSize: 16.sp,
//             ),
//           ),
//           10.verticalSpace,
//           genderRow(),
//           15.verticalSpace,
//           radiusMilesRow(),
//           10.verticalSpace,
//           milesSlider(),
//           rangeWidget(),
//           20.verticalSpace,
//           Padding(
//             padding: const EdgeInsets.symmetric(
//                 horizontal: AppPadding.defaultHorizontalPadding),
//             child: CustomText(
//               text: AppStrings.Age,
//               color: AppColors.white,
//               fontSize: 16.sp,
//             ),
//           ),
//           5.verticalSpace,
//           ageSlider(),
//           .1.sh.verticalSpace,
//           btnWidget(),
//         ],
//       ),
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
//             color: AppColors.white,
//           ),
//           CustomText(
//             text: "10 miles",
//             color: AppColors.white,
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
//           activeColor: AppColors.sliderColor,
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

//   Widget ageSlider() {
//     return Stack(
//       alignment: Alignment.center,
//       children: [
//         Positioned(left: 20.w, child: verticalDividerWidget()),
//         Theme(
//           data: ThemeData(
//             useMaterial3: false,
//             // tooltipTheme:
//             // TooltipThemeData(textStyle: TextStyle(color: AppColors.white)),
//             // hintColor: Colors.amber,
//             textTheme: TextTheme(
//               bodyLarge: TextStyle(color: Colors.white), // Global text color
//               bodyMedium: TextStyle(color: Colors.white), // Global text color
//               bodySmall: TextStyle(color: Colors.white), // Global text color
//             ),
//           ),
//           child: SfRangeSlider(
//             min: 20,
//             max: 45,
//             values: _ageValues,
//             interval: 5,
//             showTicks: false,
//             // showTicks: true,
//             showLabels: true,
//             enableTooltip: true,
//             // minorTicksPerInterval: ,
//             activeColor: AppColors.sliderColor,
//             inactiveColor: AppColors.white,

//             startThumbIcon: thumbWidget(),
//             endThumbIcon: thumbWidget(),
//             onChanged: (SfRangeValues values) {
//               setState(() {
//                 _ageValues = values;
//               });
//             },
//             tooltipTextFormatterCallback: (dynamic value, String label) {
//               // Custom tooltip formatter (rounded value and a suffix)
//               return '${value.round()}'; // Modify as needed
//             },
//           ),
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
//             color: AppColors.white,
//             fontSize: 16.sp,
//           ),
//           CustomText(
//             text: AppStrings.miles,
//             color: AppColors.white,
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
//       color: AppColors.sliderColor,
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
//         // isAuth: false,
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
//           HomeController.i.selectedTab.value = 1;
//           // }
//         },
//         text: AppStrings.done.toUpperCase(),
//       ),
//     );
//   }

//   Widget genderRow() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(
//           horizontal: AppPadding.defaultHorizontalPadding),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           genderOption(
//             bgColor: AppColors.backButtonPurple,
//             image: AssetPath.maleIcon,
//             title: AppStrings.male,
//             isBorderTrue: gender == AppStrings.male,
//             ontap: () {
//               setState(() {
//                 gender = AppStrings.male;
//               });
//             },
//           ),
//           genderOption(
//             bgColor: AppColors.pink,
//             image: AssetPath.femaleIcon,
//             title: AppStrings.female,
//             isBorderTrue: gender == AppStrings.female,
//             ontap: () {
//               setState(() {
//                 gender = AppStrings.female;
//               });
//             },
//           ),
//           genderOption(
//             bgColor: AppColors.darkPurple,
//             image: AssetPath.bothIcon,
//             title: AppStrings.both,
//             isBorderTrue: gender == AppStrings.both,
//             ontap: () {
//               setState(() {
//                 gender = AppStrings.both;
//               });
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   Widget genderOption(
//       {required Color bgColor,
//       required String image,
//       required String title,
//       required bool isBorderTrue,
//       void Function()? ontap}) {
//     return GestureDetector(
//       onTap: ontap,
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
//         decoration: isBorderTrue
//             ? BoxDecoration(
//                 border: Border.all(color: AppColors.white),
//                 borderRadius: BorderRadius.circular(15.r))
//             : null,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Container(
//               height: 50.h,
//               width: 50.w,
//               // padding: EdgeInsets.all(10.sp),
//               decoration: BoxDecoration(
//                   border: Border.all(color: AppColors.white),
//                   color: bgColor,
//                   shape: BoxShape.circle),
//               child: Image.asset(image, scale: 4.sp),
//             ),
//             10.verticalSpace,
//             CustomText(
//               text: title,
//               color: AppColors.white,
//               is_alignLeft: false,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
