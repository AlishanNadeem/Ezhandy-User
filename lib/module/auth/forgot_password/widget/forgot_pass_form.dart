// import 'dart:math';

// import 'package:ezhandy_user/module/auth/verification/routing_arguments/otp_verification_routing_arguments.dart';
// import 'package:ezhandy_user/utils/app_colors.dart';
// import 'package:ezhandy_user/utils/asset_path.dart';
// import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// // import 'package:ezhandy_user/module/auth/Verification/routing_arguments/otp_verification_routing_arguments.dart';
// import 'package:ezhandy_user/utils/app_padding.dart';
// import 'package:ezhandy_user/utils/app_strings.dart';
// import 'package:ezhandy_user/utils/enums.dart';
// import 'package:ezhandy_user/utils/routes/app_navigation.dart';
// import 'package:ezhandy_user/utils/routes/app_route.dart';
// import 'package:ezhandy_user/utils/validator_extensions.dart';
// import 'package:ezhandy_user/widgets/button_widgets/custom_button.dart';
// import 'package:ezhandy_user/widgets/logo_and_backgrounds/app_logo.dart';
// import 'package:ezhandy_user/widgets/text_fields/custom_text_field.dart';
// import 'package:ezhandy_user/widgets/toast_dialogs_sheet/toast.dart';

// class ForgotPassForm extends StatelessWidget {
//   ForgotPassForm({super.key});

//   /// Form Key
//   final GlobalKey<FormState> forgotFormKey = GlobalKey<FormState>();

//   /// Text Editing Controllers
//   final TextEditingController emailController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: AppPadding.padding16),
//       child: Column(
//         children: [
//           // Non-scrollable content (e.g., logo)
//           // AppLogo(scale: 5.sp),
//           20.verticalSpace,
//           passwordRecoveryTextWidget(),
//           // dividerWidget(),
//           // Divider(color: AppColors.red,thickness: 2.sp,endIndent: 290,),
//           15.verticalSpace,
//           // Scrollable content starts here
//           Expanded(
//             child: SingleChildScrollView(
//               child: Form(
//                 key: forgotFormKey,
//                 child: Column(children: [
//                   //----------------Email Address Field----------------
//                   CustomText(
//                       text: AppStrings
//                           .resetYourPasswordInJustAFewClicksAndRegainAccessInstantly),
//                   20.verticalSpace,
//                   CustomText(text: AppStrings.emailAddress + "*"),
//                   10.verticalSpace,
//                   emailAddressWidget(),
//                   SizedBox(height: 30.h),
//                   //----------------Get Code Button----------------
//                   buttonWidget(context),
//                 ]),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Align dividerWidget() {
//   //   return Align(
//   //     alignment: Alignment.topLeft,
//   //     child: Container(
//   //       height: 1.h,
//   //       width: 120.w,
//   //       decoration: BoxDecoration(
//   //           color: AppColors.red,
//   //           borderRadius: BorderRadius.circular(10.r),
//   //           border: Border.all(width: 0.5, color: AppColors.red)),
//   //     ),
//   //   );
//   // }

//   Widget emailAddressWidget() {
//     return CustomTextField(
//       label: false,
//       divider: false,
//       hint: AppStrings.infoEnail,
//       prefxicon: AssetPath.emailIcon,
//       inputFormatters: [LengthLimitingTextInputFormatter(35)],
//       keyboardType: TextInputType.emailAddress,
//       controller: emailController,
//       validator: (value) => value?.validateEmail,
//     );
//   }

//   CustomText passwordRecoveryTextWidget() {
//     return CustomText(
//       text: AppStrings.passwordRecovery,
//       // is_alignLeft: false,
//       fontSize: 23.sp,
//       fontWeight: FontWeight.bold,
//       color: AppColors.blueDark,
//     );
//   }

//   Widget buttonWidget(context) {
//     return CustomButton(
//         text: AppStrings.continuee,
//         onclick: () {
//           // final isValid = forgotFormKey.currentState!.validate();
//           // if (!isValid) {
//           //   return;
//           // }
//           forgotFormKey.currentState!.save();
//           AppNavigation.navigateTo(
//               context, AppRoutes.otpVerificationScreenRoute,
//               arguments: OtpVerificationRoutingArgument(
//                   type: OtpType.forget.name,
//                   emailAndPhone: emailController.text,
//                   text: emailController.text));
//           // AuthController.i
//           //     .forgotPass(email: forgotPassRepo.email_controller.text);
//           ToastMessage(toastmsg: AppStrings.otpSendedToYourEmail);
//           FocusScope.of(context).unfocus();
//         });
//   }
// }
