// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:ezhandy_user/utils/app_colors.dart';
// import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';

// class StepProgressBar extends StatelessWidget {
//   final int currentStep;
//   StepProgressBar({required this.currentStep});
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         // Step Numbers with Progress Lines
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Expanded(child: progressLineWidget(isActive: currentStep >= 1)),
//             stepNumberWidget(step: "01", isActive: currentStep >= 1),
//             Expanded(flex: 2, child: progressLineWidget(isActive: currentStep >= 2)),
//             stepNumberWidget(step: "02", isActive: currentStep >= 2),
//             Expanded(flex: 2, child: progressLineWidget(isActive: currentStep >= 3)),
//             stepNumberWidget(step: "03", isActive: currentStep >= 3),
//             Expanded(child: progressLineWidget(isActive: currentStep >= 3)),
//           ],
//         ),
//         // const SizedBox(height: 4), // Small space between numbers and labels
//         // Step Labels
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Expanded(child: SizedBox()), // Keeps spacing balanced
//             Padding(
//               padding: EdgeInsets.only(left: 10.w),
//               child: stepLabelWidget(label: "Menu", isActive: currentStep >= 1),
//             ),
//             Expanded(flex: 2, child: SizedBox()), // Adds spacing between labels
//             Padding(
//               padding: EdgeInsets.only(left: 20.w),
//               child: stepLabelWidget(label: "Cart", isActive: currentStep >= 2),
//             ),
//             Expanded(flex: 2, child: SizedBox()),
//             Padding(
//               padding: EdgeInsets.only(left: 15.w),
//               child: stepLabelWidget(label: "Checkout", isActive: currentStep >= 3),
//             ),
//             Expanded(child: SizedBox()),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget progressLineWidget({required bool isActive}) {
//     return Container(
//       height: 6,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(3.r),
//         color: isActive ? AppColors.backButtonPurple : AppColors.lightPurple,
//       ),
//     );
//   }

//   Widget stepNumberWidget({required String step, required bool isActive}) {
//     return Container(
//       width: 30,
//       height: 30,
//       alignment: Alignment.center,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         color: isActive ? AppColors.backButtonPurple : AppColors.backButtonPurple,
//       ),
//       child: Text(
//         step,
//         style: TextStyle(
//           color: Colors.white,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//     );
//   }

//   Widget stepLabelWidget({required String label, required bool isActive}) {
//     return CustomText(
//       text: label,
//       is_alignLeft: false,
//       fontSize: 12.sp,
//       // fontWeight: FontWeight.w500,
//       color: Colors.grey,
//     );
//   }
// }
