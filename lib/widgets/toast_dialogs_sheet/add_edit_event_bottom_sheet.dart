// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:ezhandy_user/utils/app_colors.dart';
// import 'package:ezhandy_user/utils/app_strings.dart';
// import 'package:ezhandy_user/utils/asset_path.dart';
// import 'package:ezhandy_user/utils/constant.dart';
// import 'package:ezhandy_user/utils/enums.dart';
// import 'package:ezhandy_user/utils/routes/app_navigation.dart';
// import 'package:ezhandy_user/utils/utils.dart';
// import 'package:ezhandy_user/utils/validator_extensions.dart';
// import 'package:ezhandy_user/widgets/Container/custom_container.dart';
// import 'package:ezhandy_user/widgets/button_widgets/custom_button.dart';
// import 'package:ezhandy_user/widgets/dropdown/custom_dropdown.dart';
// import 'package:ezhandy_user/widgets/text_fields/custom_text_field.dart';
// import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';
// import 'package:ezhandy_user/widgets/toast_dialogs_sheet/custom_bottom_sheet.dart';
// import 'package:ezhandy_user/widgets/toast_dialogs_sheet/toast.dart';

// // ignore: must_be_immutable
// class AddEditEvent extends StatefulWidget {
//   // void Function()? ontapPic, ontapRec;
//   // final Function(File)? setFile;
//   String? type;
//   AddEditEvent({
//     this.type,
//     super.key,
//   });

//   @override
//   State<AddEditEvent> createState() => _AddEditEventState();
// }

// class _AddEditEventState extends State<AddEditEvent> {
//   // FocusNode _focusNodeBio = FocusNode();
//   final GlobalKey<FormState> FormKey = GlobalKey<FormState>();

//   // double ratting = 3;
//   bool _keyboardVisible = false;
//   // bool error = false;
//   TextEditingController locationController = TextEditingController();
//   TextEditingController dateController = TextEditingController();
//   TextEditingController titleController = TextEditingController();
//   TextEditingController detailController = TextEditingController();
//   var hourList = [
//     "01",
//     "02",
//     "03",
//     "04",
//     "05",
//     "06",
//     "07",
//     "08",
//     "09",
//     "10",
//     "11",
//     "12",
//   ];
//   String? errorStartHour = '';
//   String? hourStartValue;
//   String? errorEndHour = '';
//   String? hourEndValue;
//   var minutesList = [
//     "00",
//     "01",
//     "02",
//     "03",
//     "04",
//     "05",
//     "06",
//     "07",
//     "08",
//     "09",
//     "10",
//     "11",
//     "12",
//     "13",
//     "14",
//     "15",
//     "16",
//     "17",
//     "18",
//     "19",
//     "20",
//     "21",
//     "22",
//     "23",
//     "24",
//     "25",
//     "26",
//     "27",
//     "28",
//     "29",
//     "30",
//     "31",
//     "32",
//     "33",
//     "34",
//     "35",
//     "36",
//     "37",
//     "38",
//     "39",
//     "40",
//     "41",
//     "42",
//     "43",
//     "44",
//     "45",
//     "46",
//     "47",
//     "48",
//     "49",
//     "50",
//     "51",
//     "52",
//     "53",
//     "54",
//     "55",
//     "56",
//     "57",
//     "58",
//     "59",
//   ];
//   String? errorMinutesStart = '';
//   String? minutesStartValue;
//   String? errorMinutesEnd = '';
//   String? minutesEndValue;
//   String? amPmEndValue = AppStrings.pm;
//   String? amPmStartValue = AppStrings.pm;

//   DateTime? dob;

//   @override
//   Widget build(BuildContext context) {
//     _keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
//     log(_keyboardVisible.toString());
//     return CustomBottomSheet(
//       height: _keyboardVisible ? 0.95.sh : 0.9.sh,
//       child: Form(
//         key: FormKey,
//         child: Expanded(
//           child: Padding(
//             padding: EdgeInsets.only(
//                 bottom: MediaQuery.of(context).viewInsets.bottom),
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     SizedBox(),
//                     CustomText(
//                         text: AddEditType.add.name == widget.type
//                             ? AppStrings.addEvent
//                             : AppStrings.editEvent,
//                         is_alignLeft: false,
//                         fontSize: 16.sp),
//                     GestureDetector(
//                         onTap: () {
//                           AppNavigation.navigatorPop(context);
//                         },
//                         child: Image.asset(AssetPath.crossIcon, scale: 4.sp))
//                   ],
//                 ),
//                 Expanded(
//                   child: SingleChildScrollView(
//                     child: Column(
//                       children: [
//                         10.h.verticalSpace,
//                         titleWidget(title: AppStrings.addTitle),
//                         10.h.verticalSpace,
//                         titleTextField(),
//                         10.h.verticalSpace,
//                         titleWidget(title: AppStrings.addDate),
//                         10.h.verticalSpace,
//                         dateTextField(),
//                         10.h.verticalSpace,
//                         titleWidget(title: AppStrings.addStartTime),
//                         10.h.verticalSpace,
//                         addStartTimeWidget(),
//                         10.h.verticalSpace,
//                         titleWidget(title: AppStrings.addEndTime),
//                         10.h.verticalSpace,
//                         addEndTimeWidget(),
//                         10.h.verticalSpace,
//                         titleWidget(title: AppStrings.addLocation),
//                         10.h.verticalSpace,
//                         locationTextField(),
//                         10.h.verticalSpace,
//                         titleWidget(title: AppStrings.addDesciption),
//                         10.h.verticalSpace,
//                         detailTextField(),
//                         10.h.verticalSpace,
//                       ],
//                     ),
//                   ),
//                 ),
//                 buttonWidget(),
//                 10.h.verticalSpace,
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Row addStartTimeWidget() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Expanded(child: hourStartDropDown()),
//         10.w.horizontalSpace,
//         Expanded(child: minutesStartDropDown()),
//         10.w.horizontalSpace,
//         GestureDetector(
//           onTap: () {
//             setState(() {
//               amPmStartValue = AppStrings.am;
//             });
//           },
//           child: CustomContainer(
//             isBorder: true,
//             radius: 50.sp,
//             bgColor: amPmStartValue == AppStrings.am ? AppColors.purple : null,
//             child: CustomText(
//               text: AppStrings.am,
//               color: amPmStartValue == AppStrings.am ? AppColors.white : null,
//             ),
//           ),
//         ),
//         10.w.horizontalSpace,
//         GestureDetector(
//           onTap: () {
//             setState(() {
//               amPmStartValue = AppStrings.pm;
//             });
//           },
//           child: CustomContainer(
//             isBorder: true,
//             radius: 50.sp,
//             bgColor: amPmStartValue == AppStrings.pm ? AppColors.purple : null,
//             child: CustomText(
//               text: AppStrings.pm,
//               color: amPmStartValue == AppStrings.pm ? AppColors.white : null,
//             ),
//           ),
//         )
//       ],
//     );
//   }

//   Row addEndTimeWidget() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Expanded(child: hourEndDropDown()),
//         10.w.horizontalSpace,
//         Expanded(child: minutesEndDropDown()),
//         10.w.horizontalSpace,
//         GestureDetector(
//           onTap: () {
//             setState(() {
//               amPmEndValue = AppStrings.am;
//             });
//           },
//           child: CustomContainer(
//             isBorder: true,
//             radius: 50.sp,
//             bgColor: amPmEndValue == AppStrings.am ? AppColors.purple : null,
//             child: CustomText(
//               text: AppStrings.am,
//               color: amPmEndValue == AppStrings.am ? AppColors.white : null,
//             ),
//           ),
//         ),
//         10.w.horizontalSpace,
//         GestureDetector(
//           onTap: () {
//             setState(() {
//               amPmEndValue = AppStrings.pm;
//             });
//           },
//           child: CustomContainer(
//             isBorder: true,
//             radius: 50.sp,
//             bgColor: amPmEndValue == AppStrings.pm ? AppColors.purple : null,
//             child: CustomText(
//               text: AppStrings.pm,
//               color: amPmEndValue == AppStrings.pm ? AppColors.white : null,
//             ),
//           ),
//         )
//       ],
//     );
//   }

//   validatehour(value) {
//     if (value == null) {
//       errorStartHour = "Select Hour field can't be empty.";
//     } else {
//       errorStartHour = "";
//     }
//     setState(() {});
//   }

//   Widget hourStartDropDown() {
//     return CustomDropDown2(
//         dropDownWidth: .82.sw,
//         dropDownData: hourList,
//         hintText: "00",
//         error_text: errorStartHour,
//         dropdownValue: hourStartValue,
//         dropdownListColor: AppColors.white,
//         hintTextColor: AppColors.fontColor,
//         // color: AppColors.BROWN_COLOR,
//         fillColor: AppColors.white,
//         onChanged: (value) {
//           setState(() {
//             hourStartValue = value.toString();
//           });
//         },
//         validator: (value) => value?.validateEmpty(""));
//   }

//   Widget minutesStartDropDown() {
//     return CustomDropDown2(
//         dropDownWidth: .82.sw,
//         dropDownData: minutesList,
//         hintText: "00",
//         error_text: errorMinutesStart,
//         dropdownValue: minutesStartValue,
//         dropdownListColor: AppColors.white,
//         hintTextColor: AppColors.fontColor,
//         // color: AppColors.BROWN_COLOR,
//         fillColor: AppColors.white,
//         onChanged: (value) {
//           setState(() {
//             minutesStartValue = value.toString();
//           });
//         },
//         validator: (value) => value?.validateEmpty(""));
//   }

//   Widget hourEndDropDown() {
//     return CustomDropDown2(
//         dropDownWidth: .82.sw,
//         dropDownData: hourList,
//         hintText: "00",
//         error_text: errorEndHour,
//         dropdownValue: hourEndValue,
//         dropdownListColor: AppColors.white,
//         hintTextColor: AppColors.fontColor,
//         // color: AppColors.BROWN_COLOR,
//         fillColor: AppColors.white,
//         onChanged: (value) {
//           setState(() {
//             hourEndValue = value.toString();
//           });
//         },
//         validator: (value) => value?.validateEmpty(""));
//   }

//   Widget minutesEndDropDown() {
//     return CustomDropDown2(
//         dropDownWidth: .82.sw,
//         dropDownData: minutesList,
//         hintText: "00",
//         error_text: errorMinutesEnd,
//         dropdownValue: minutesEndValue,
//         dropdownListColor: AppColors.white,
//         hintTextColor: AppColors.fontColor,
//         // color: AppColors.BROWN_COLOR,
//         fillColor: AppColors.white,
//         onChanged: (value) {
//           setState(() {
//             minutesEndValue = value.toString();
//           });
//         },
//         validator: (value) => value?.validateEmpty(""));
//   }

//   Widget buttonWidget() {
//     return CustomButton(
//       onclick: () {
//         ToastMessage(
//             toastmsg: widget.type == AddEditType.add.name
//                 ? "Added Successfully"
//                 : "Edit Successfully");

//         AppNavigation.navigatorPop(context);
//       },
//       height: 45.h,
//       text: AddEditType.add.name == widget.type
//           ? AppStrings.add
//           : AppStrings.save,
//       // color: AppColors.lightPink,
//       // textcolor: AppColors.black,
//     );
//   }

//   CustomText titleWidget({String? title}) {
//     return CustomText(
//       text: title,
//       fontSize: 16.sp,
//       fontWeight: FontWeight.bold,
//     );
//   }

//   Widget detailTextField() {
//     return CustomTextField(
//         // focusNode: _focusNodeBio,
//         divider: false,
//         //   prefxicon: AssetPath.profileIcon,
//         label: false,
//         lines: 5,
//         borderRadius: 15.sp,
//         hint: AppStrings.typeHere,
//         inputFormatters: [LengthLimitingTextInputFormatter(500)],
//         controller: detailController,
//         validator: (value) => value?.validateEmpty(AppStrings.typeHere));
//   }

//   Widget titleTextField() {
//     return CustomTextField(
//         // focusNode: _focusNodeBio,
//         divider: false,
//         //   prefxicon: AssetPath.profileIcon,
//         label: false,
//         // lines: 5,
//         // borderRadius: 15.sp,
//         hint: AppStrings.addTitle,
//         inputFormatters: [LengthLimitingTextInputFormatter(35)],
//         controller: titleController,
//         validator: (value) => value?.validateEmpty(AppStrings.addTitle));
//   }

//   Widget dateTextField() {
//     return CustomTextField(
//         label: false,
//         divider: false,
//         onTap: () async {
//           dob = await Utils.displayDatePicker(
//               context: context,
//               firstDate: DateTime(1950),
//               lastDate: DateTime(2050),
//               date: DateTime.now());
//           if (dob != null) {
//             dateController.text = Utils.formatDate(
//                 pattern: AppStrings.MM_DD_YYYY_FORMAT, date: dob);
//           }
//         },
//         readOnly: true,
//         hint: AppStrings.date,
//         sufixImage: Image.asset(AssetPath.calendarIcon, scale: 4.sp),
//         controller: dateController,
//         validator: (value) => value?.validateEmpty(AppStrings.date));
//   }

//   Widget locationTextField() {
//     return CustomTextField(
//         onTap: () async {
//           Map<String, String>? placeDetails =
//               await Constants().pickPlace(context);
//           locationController.text = placeDetails?['fullAddress'] ?? "";
//         },
//         readOnly: true,
//         // focusNode: _focusNodeBio,
//         divider: false,
//         //   prefxicon: AssetPath.profileIcon,
//         label: false,
//         hint: AppStrings.location,
//         sufixImage: Image.asset(AssetPath.locationIcon, scale: 4.sp),
//         inputFormatters: [LengthLimitingTextInputFormatter(35)],
//         controller: locationController,
//         validator: (value) => value?.validateEmpty(AppStrings.location));
//   }
// }
