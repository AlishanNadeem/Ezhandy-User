// import 'package:ezhandy_user/module/auth/verification/routing_arguments/otp_verification_routing_arguments.dart';
// import 'package:ezhandy_user/utils/app_colors.dart';
// import 'package:ezhandy_user/utils/asset_path.dart';
// import 'package:ezhandy_user/utils/constant.dart';
// import 'package:ezhandy_user/widgets/logo_and_backgrounds/app_logo.dart';
// import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:ezhandy_user/utils/app_padding.dart';
// import 'package:ezhandy_user/utils/app_strings.dart';
// import 'package:ezhandy_user/utils/enums.dart';
// import 'package:ezhandy_user/utils/routes/app_navigation.dart';
// import 'package:ezhandy_user/utils/routes/app_route.dart';
// import 'package:ezhandy_user/utils/validator_extensions.dart';
// import 'package:ezhandy_user/widgets/button_widgets/custom_button.dart';
// import 'package:ezhandy_user/widgets/text_fields/custom_text_field.dart';

// class VerificationSelectionForm extends StatefulWidget {
//   String? type;
//   VerificationSelectionForm({this.type, super.key});

//   @override
//   State<VerificationSelectionForm> createState() =>
//       _VerificationSelectionFormState();
// }

// class _VerificationSelectionFormState extends State<VerificationSelectionForm> {
//   /// Form Key
//   final GlobalKey<FormState> verificationFormKey = GlobalKey<FormState>();

//   /// Text Editing Controllers
//   final TextEditingController emailController = TextEditingController();

//   final TextEditingController phoneController = TextEditingController();

//   bool isEmail = true;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: AppPadding.padding16),
//       child: Column(
//         children: [
//           // Non-scrollable content (e.g., logo)
//           AppLogo(scale: 3.5.sp),
//           15.verticalSpace,
//           signInTextWidget(),
//           5.verticalSpace,
//           CustomText(
//               text: AppStrings.PleaseEnterYourEmailPhoneContinue,
//               is_alignLeft: false),

//           25.verticalSpace,
//           // Scrollable content starts here
//           Expanded(
//             child: SingleChildScrollView(
//               child: Form(
//                 key: verificationFormKey,
//                 child: Column(children: [
//                   //----------------Email Address Field----------------

//                   CustomText(text: AppStrings.viaEmail),
//                   10.verticalSpace,
//                   _emailTextField(),
//                   20.verticalSpace,
//                   CustomText(text: AppStrings.viaPhoneNumber),
//                   10.verticalSpace,
//                   _phoneNumberTextField(),
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

//   CustomText signInTextWidget() {
//     return CustomText(
//       text: "Verification Method",
//       is_alignLeft: false,
//       fontSize: 18.sp,
//       fontWeight: FontWeight.bold,
//       color: AppColors.black,
//     );
//   }

//   // Align dividerWidget() {
//   Widget _emailTextField() {
//     return CustomTextField(
//       onTap: () {
//         setState(() {
//           isEmail = true;
//         });
//         phoneController.clear();
//       },
//       label: false,
//       divider: false,
//       hint: AppStrings.enterEmailAddress,
//       prefxicon: AssetPath.emailIcon,
//       sufixImage: isEmail ? Icon(Icons.check) : null,
//       inputFormatters: [LengthLimitingTextInputFormatter(35)],
//       keyboardType: TextInputType.emailAddress,
//       controller: emailController,
//       validator: (value) => isEmail ? value?.validateEmail : null,
//     );
//   }

//   Widget _phoneNumberTextField() {
//     return CustomTextField(
//       onTap: () {
//         setState(() {
//           isEmail = false;
//         });
//         emailController.clear();
//       },
//       hint: AppStrings.enterPhoneNumber,
//       divider: false,
//       prefxicon: AssetPath.callIcon,
//       label: false,
//       sufixImage: isEmail ? null : Icon(Icons.check),

//       keyboardType: TextInputType.number,
//       inputFormatters: [Constants.maskTextInputFormatterPhoneUSWithCode],
//       controller: phoneController,
//       validator: (value) =>
//           isEmail ? null : value?.validateEmpty(AppStrings.phoneNumber),
//       // error_text: error_email,
//     );
//   }

//   CustomText verificationTextWidget() {
//     return CustomText(
//       text: AppStrings.verification,
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
//           final isValid = verificationFormKey.currentState!.validate();
//           if (!isValid) {
//             return;
//           }
//           verificationFormKey.currentState!.save();
//           AppNavigation.navigateTo(
//               context, AppRoutes.otpVerificationScreenRoute,
//               arguments: OtpVerificationRoutingArgument(
               
               
//                   type: widget.type,
//                   text: isEmail ? emailController.text : phoneController.text,
//                   emailAndPhone: isEmail
//                       ? OtpCodeType.email.name
//                       : OtpCodeType.phone.name));
//           // AuthController.i
//           //     .forgotPass(email: forgotPassRepo.email_controller.text);
//           // ToastMessage(toastmsg: AppStrings.otpSendedToYourEmail);
//           FocusScope.of(context).unfocus();
//         });
//   }
// }
