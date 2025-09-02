// import 'package:elpistoken/utils/app_colors.dart';
// import 'package:elpistoken/utils/app_strings.dart';
// import 'package:elpistoken/utils/routes/app_navigation.dart';
// import 'package:elpistoken/utils/routes/app_route.dart';
// import 'package:elpistoken/utils/validator_extensions.dart';
// import 'package:elpistoken/widgets/Container/custom_container.dart';
// import 'package:elpistoken/widgets/button_widgets/custom_button.dart';
// import 'package:elpistoken/widgets/checkbox/custom_checkbox.dart';
// import 'package:elpistoken/widgets/row/two_text_row.dart';
// import 'package:elpistoken/widgets/text_fields/custom_text_field.dart';
// import 'package:elpistoken/widgets/text_widgets/text_widget.dart';
// import 'package:elpistoken/widgets/toast_dialogs_sheet/custom_dialoge.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';

// class PaymentDialog extends StatefulWidget {
//   String buttonText;
//   Function()? onclick;
//   int? postId;
//   // final Function(String? value)? onSubmit;
//   PaymentDialog(
//       {required this.buttonText,
//       this.onclick,
//       this.postId,
//       // this.onSubmit,
//       super.key});

//   @override
//   State<PaymentDialog> createState() => _PaymentDialogState();
// }

// class _PaymentDialogState extends State<PaymentDialog> {
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
//         // height: .7.sh,
//         Heading: AppStrings.payment,
//         child: Flexible(
//           child: SingleChildScrollView(
//             child: Padding(
//                 padding: EdgeInsets.all(20),
//                 child:
//                     // option = HomeController.i.reportReasonList[0]?.name;
//                     Column(
//                   children: [
//                     CustomContainer(
//                         isGradient: false,
//                         child: Column(
//                           children: [
//                             CustomText(
//                               text: "\$ " + AppStrings.dummyAmount2,
//                               fontSize: 16.sp,
//                               fontWeight: FontWeight.bold,
//                               is_alignLeft: false,
//                             ),
//                             CustomText(
//                               text: AppStrings.billToPay,
//                               color: AppColors.fontColor,
//                               fontSize: 12.sp,
//                               is_alignLeft: false,
//                             )
//                           ],
//                         )),
//                     10.verticalSpace,
//                     TwoTextRow(
//                         firstText: AppStrings.arrivalTime,
//                         secondText: AppStrings.dummytime),
//                     divider(),
//                     TwoTextRow(
//                         firstText: AppStrings.distance,
//                         secondText: AppStrings.dummyDistance),
//                     divider(),
//                     TwoTextRow(
//                         firstText: AppStrings.rideFare,
//                         secondText: "\$ " + AppStrings.dummyAmount2),
//                     divider(),
//                     TwoTextRow(
//                         firstText: AppStrings.otherCharges,
//                         secondText: "\$ " + AppStrings.dummyAmount2),
//                     divider(),
//                     TwoTextRow(
//                         firstText: AppStrings.totalCost,
//                         secondText: "\$ " + AppStrings.dummyAmount2),
//                     10.verticalSpace,
//                     CustomButton(
//                         text: widget.buttonText, onclick: widget.onclick),
//                     SizedBox(height: 5.h),
//                     // notNowButton(context),
//                   ],
//                 )),
//           ),
//         ));
//   }

//   Divider divider() {
//     return Divider(
//       thickness: .5,
//       color: AppColors.borderColor,
//     );
//   }
// }
