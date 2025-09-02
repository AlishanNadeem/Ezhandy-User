// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:ezhandy_user/utils/app_colors.dart';
// import 'package:ezhandy_user/utils/app_strings.dart';
// import 'package:ezhandy_user/utils/constant.dart';
// import 'package:ezhandy_user/utils/routes/app_navigation.dart';
// import 'package:ezhandy_user/utils/validator_extensions.dart';
// import 'package:ezhandy_user/widgets/button_widgets/custom_button.dart';
// import 'package:ezhandy_user/widgets/checkbox/custom_checkbox.dart';
// import 'package:ezhandy_user/widgets/text_fields/custom_text_field.dart';
// import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';
// import 'package:ezhandy_user/widgets/toast_dialogs_sheet/custom_dialoge.dart';

// class DeclineReasonDialoge extends StatefulWidget {
//   String? title, hinttext;
//   int? postId;
//   final Function(String? value)? onSubmit;
//   DeclineReasonDialoge(
//       {this.title, this.hinttext, this.postId, this.onSubmit, super.key});

//   @override
//   State<DeclineReasonDialoge> createState() => _DeclineReasonDialogeState();
// }

// class _DeclineReasonDialogeState extends State<DeclineReasonDialoge> {
//   var option = AppStrings.iDontNeedItAnymore;
//   bool visible = false;
//   final reason_controller = TextEditingController();

//   final gkey = GlobalKey<FormState>();

//   @override
//   void initState() {
//     // if (HomeController.i.reportReasonList.isEmpty) {
//     //   HomeController.i.getReportReasons(loader: true);
//     // }
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   void dispose() {
//     // HomeController.i.reportReasonList.clear();
//     // TODO: implement dispose
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return CustomDialogs(
//         Heading: AppStrings.declineReason,
//         child: Flexible(
//           child: SingleChildScrollView(
//             child: Padding(
//                 padding: EdgeInsets.all(20),
//                 child:
//                     // option = HomeController.i.reportReasonList[0]?.name;
//                     Form(
//                   key: gkey,
//                   child: Column(
//                     children: [
//                       custom_row(
//                           value: AppStrings.iDontNeedItAnymore,
//                           text: AppStrings.iDontNeedItAnymore),
//                       Divider(),
//                       SizedBox(height: 5.h),
//                       custom_row(
//                           value: AppStrings.iDontFindItUseFul,
//                           text: AppStrings.iDontFindItUseFul),
//                       Divider(),
//                       SizedBox(height: 5.h),
//                       custom_row(
//                           value: AppStrings.lorem3, text: AppStrings.lorem3),
//                       Divider(),
//                       SizedBox(height: 5.h),
//                       custom_row(
//                           value: AppStrings.other, text: AppStrings.other),
//                       SizedBox(height: 5.h),
//                       text_field(),
//                       SizedBox(height: 10.h),
//                       CustomButton(
//                           text: AppStrings.submit.toUpperCase(),
//                           // isAuth: false,
//                           onclick: () {
//                             if (gkey.currentState!.validate()) {
//                               reason_controller.clear();
//                               if (widget.onSubmit != null) {
//                                 widget.onSubmit!(reason_controller.text);
//                               }
//                               AppNavigation.navigatorPop(
//                                   Constants.navigatorKey.currentContext!);
//                               AppNavigation.navigatorPop(
//                                   Constants.navigatorKey.currentContext!);
//                               // AppNavigation.navigateReplacementNamed(
//                               //     context, AppRoutes.roleSelectionScreenRoute);

//                               // AppDialogs.showToast(message: AppStrings.loginSuccessfully);
//                             }
//                           }),
//                       SizedBox(height: 5.h),
//                       // notNowButton(context),
//                     ],
//                   ),
//                 )),
//           ),
//         ));
//   }

//   GestureDetector notNowButton(BuildContext context) {
//     return GestureDetector(
//         onTap: () {
//           AppNavigation.navigatorPop(context);
//         },
//         child: CustomText(
//           text: AppStrings.notNow,
//           textDecoration: TextDecoration.underline,
//           is_alignLeft: false,
//         ));
//   }

//   Widget text_field() {
//     return Visibility(
//       visible: visible,
//       child: CustomTextField(
//           label: false, // filled: true,
//           // fillColor: Color.fromARGB(255, 237, 235, 235),
//           hint: AppStrings.description,
//           // textColor: AppColors.black,
//           // borderRadius: 15,
//           // border_radius: 10,
//           // fillColor: AppColors.GREY_COLOR,
//           fontColor: AppColors.black,
//           borderRadius: 10.r,
//           fillColor: AppColors.white,
//           borderColor: AppColors.black,
//           lines: 5,
//           // prefixRIghtPadding: 10.w,
//           inputFormatters: [LengthLimitingTextInputFormatter(275)],
//           controller: reason_controller,
//           validator: (value) => value?.validateEmpty(AppStrings.description)
//           //  {
//           //   return FieldValidator.validateNull(
//           //       value: value!, label: AppStrings.REASON_TEXT);
//           // }
//           ),
//     );
//   }

//   Widget custom_row({value, String? text}) {
//     return Row(
//       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         radio_button(value),
//         text_widget(text: text),
//       ],
//     );
//   }

//   Widget radio_button(value) {
//     return Theme(
//       data: Theme.of(context).copyWith(
//         unselectedWidgetColor: AppColors.black, // Set inactive color to green
//       ),
//       child: Radio(
//         activeColor: AppColors.black,
//         visualDensity: const VisualDensity(
//             horizontal: VisualDensity.minimumDensity,
//             vertical: VisualDensity.minimumDensity),
//         value: value,
//         groupValue: option,
//         onChanged: (value) {
//           setState(() {
//             if (value == 'Other') {
//               visible = true;
//               reason_controller.text = "";
//               option = value;
//             } else {
//               visible = false;
//               reason_controller.text = value;
//               option = value;
//             }
//             print(reason_controller.text);
//           });
//         },
//       ),
//     );
//   }

//   CheckBoxWidget checkBox({value, String? text}) {
//     return CheckBoxWidget(
//         isChecked: value!,
//         title: text ?? "",
//         ontapCheck: () {
//           setState(() {
//             value = !value!;
//           });
//         });
//   }

//   Widget text_widget({String? text}) {
//     return CustomText(
//       fontSize: 14,
//       text: text ?? AppStrings.dummylorem,
//     );
//   }
// }
