import 'dart:async';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:ezhandy_user/module/auth/controller/auth_controller.dart';
import 'package:ezhandy_user/widgets/logo_and_backgrounds/app_logo.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/utils/app_padding.dart';
import 'package:ezhandy_user/utils/app_strings.dart';
import 'package:ezhandy_user/utils/routes/app_navigation.dart';
import 'package:ezhandy_user/utils/routes/app_route.dart';
import 'package:ezhandy_user/utils/validator_extensions.dart';
import 'package:ezhandy_user/widgets/button_widgets/custom_button.dart';
import 'package:ezhandy_user/widgets/keyboard/custom_keyboard_action_widget.dart';
import 'package:ezhandy_user/widgets/text_widgets/rich_text_widget.dart';
import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';
import 'package:ezhandy_user/widgets/toast_dialogs_sheet/toast.dart';
import 'package:ezhandy_user/utils/enums.dart';

class OtpVerificationForm extends StatefulWidget {
  String? type;
  String? text;
  String? phone_verication, country_code, iso_code;
  String? user_id;
  String? emailAndPhone;
  bool isTimeComplete;
  int duration;
  bool keyboardVisible;

  OtpVerificationForm({
    required this.duration,
    this.phone_verication,
    this.user_id,
    this.text,
    this.type,
    this.emailAndPhone,
    this.isTimeComplete = false,
    this.country_code,
    this.iso_code,
    required this.keyboardVisible,
    super.key,
  });

  @override
  State<OtpVerificationForm> createState() => _OtpVerificationFormState();
}

class _OtpVerificationFormState extends State<OtpVerificationForm> {
  final TextEditingController pinController = TextEditingController();
  final GlobalKey<FormState> otpKey = GlobalKey<FormState>();
  FocusNode _focusNode = FocusNode();

  // int _remainingTime = 0;
  // Timer? _otpTextTimer;
  // bool _isTimeComplete = false;

  // @override
  // void initState() {
  //   super.initState();
  //   _remainingTime = widget.duration;
  //   _startOtpTimer(() {
  //     setState(() {
  //       _isTimeComplete = true;
  //     });
  //   });
  // }

  @override
  void dispose() {
    // _otpTextTimer?.cancel();
    // pinController.dispose();
    // _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.padding16),
      child: Column(
        children: [
          AppLogo(scale: 3.5.sp),
          15.verticalSpace,
          passwordRecoveryTextWidget(),
          5.verticalSpace,

          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: otpKey,
                child: Column(
                  children: [
                    CustomText(
                        is_alignLeft: false,
                        text:
                            //  widget.type == OtpType.forget.name
                            //     ? AppStrings.otpCodeForgetMessage
                            //     : widget.emailAndPhone == OtpCodeType.email.name
                            //         ? AppStrings.otpCodeEmailMessage
                            //         :
                            AppStrings.otpCodePhoneMessage),
                    20.verticalSpace,
                    // CustomText(text: AppStrings.verificationCode + "*"),
                    // 10.verticalSpace,
                    pinCodeWidget(context),
                    20.verticalSpace,
                    _verifyButton(context),
                    10.verticalSpace,
                    // _otpResendTextTimerWidget(),
                                              _circularCountDownTimerWidget(),

                  ],
                ),
              ),
            ),
          ),
          Visibility(
              visible: !widget.keyboardVisible,
              child: didntReceiveCodeWidget()),
          25.verticalSpace
        ],
      ),
    );
  }

   Widget _verifyButton(context) {
    return CustomButton(
      text: AppStrings.submitCode,
      onclick: () {
        if (otpKey.currentState!.validate()) {
          // ToastMessage(toastmsg: AppStrings.logIn);

          AuthController.i.verifyUser(
              context: context,
              code: pinController.text,
              email: widget.emailAndPhone,
              type: widget.type);

          // if (widget.type == OtpType.forget.name) {
          //   AppNavigation.navigateReplacementNamed(
          //       context, AppRoutes.resetPasswordScreenRoute);
          //   // AppNavigation.navigateToRemovingAll(context, AppRoutes.userMainMenuScreenRoute);
          // } else {
          //   AppNavigation.navigateReplacementNamed(
          //       context, AppRoutes.createProfileScreenRoute);
          // }

          // AppNavigation.navigateTo(
          //     context, AppRoutes.otpVerificationScreenRoute,
          //     arguments: OtpVerificationRoutingArgument(
          //         type: OtpType.signup.name,
          //         emailAndPhone: OtpCodeType.email.name));
          // emailController.clear();
          // passwordController.clear();
          // AppDialogs.showToast(message: AppStrings.loginSuccessfully);
          // }
          // validate_email(emailController.text);
          // if (error_email == "") {
          //   AuthController.i.signIn(email: emailController.text);
          //   // Get.offNamed(Paths.OTP_VERIFICATION_SCREEN_ROUTE);
          //   AppConstant.is_phone = false;
        }

        FocusScope.of(context).unfocus();
      },
    );
  }

  CustomText passwordRecoveryTextWidget() {
    return CustomText(
      text: AppStrings.verification,
      fontSize: 23.sp,
      fontWeight: FontWeight.bold,
      is_alignLeft: false,
      // color: AppColors.blueDark,
    );
  }

   Widget pinCodeWidget(BuildContext context) {
    return CustomKeyboardActionWidget(
      focusNode: _focusNode,
      child: PinCodeTextField(
        focusNode: _focusNode,
        cursorColor: AppColors.orange,
        autovalidateMode: AutovalidateMode.disabled,
        appContext: context,
        length: 4,

        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],

        textStyle: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.black,
        ),

        pinTheme: PinTheme(
          fieldWidth: 48.w, // ✅ FIXED WIDTH
          fieldHeight: 48.w,
          activeFillColor: Colors.transparent,
          inactiveFillColor: Colors.transparent,
          selectedFillColor: Colors.transparent,
          activeColor: AppColors.orange,
          inactiveColor: AppColors.orange,
          selectedColor: AppColors.orange,
          shape: PinCodeFieldShape.box,
        ),

        separatorBuilder: (context, index) =>
            SizedBox(width: 8.w), // ✅ CONTROL GAP

        showCursor: true,
        animationDuration: const Duration(milliseconds: 300),
        enableActiveFill: true,
        keyboardType: TextInputType.number,

        onChanged: (value) {
          debugPrint(value);
        },

        validator: (value) => value?.validateVerificationCode,
        controller: pinController,

        onCompleted: (value) {
          // handle complete logic
        },
      ),
    );
  }


  Widget _circularCountDownTimerWidget() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          // gradient: AppGradients.buttonGradient,
          // boxShadow: AppShadows.shadow1,
          shape: BoxShape.circle,
        ),
        child: CircularCountDownTimer(
          duration: widget.duration,
          initialDuration: 0,
          controller: AuthController.i.countDownController.value,
          // AuthController.i.countDownController.value,
          width: 0.28.sw,
          height: 0.2.sh,
          strokeWidth: 6,
          ringColor: AppColors.orange,
          fillColor: AppColors.white,
          backgroundColor: AppColors.transparent,
          strokeCap: StrokeCap.round,
          textStyle: const TextStyle(
            fontSize: 18.0,
            color: AppColors.black,
          ),
          textFormat: CountdownTextFormat.MM_SS,
          isReverse: true,
          isReverseAnimation: true,
          isTimerTextShown: true,
          autoStart: true,
          onStart: () {
            debugPrint('Countdown Started');
          },
          onComplete: () {
            setState(() {
              AuthController.i.isTimeComplete.value = true;
            });
            debugPrint('Countdown Ended');
          },
        ),
      ),
    );
  }





  Widget didntReceiveCodeWidget() {
    return Container(
      // padding: EdgeInsets.only(bottom: 50, top: 15),
      alignment: Alignment.center,
      width: 1.sw,
      child: RichTextWidget(
          text: AppStrings.didnotReceiveCode,
          subText: AppStrings.resend,
          subTextColor: AuthController.i.isTimeComplete.value
              ? AppColors.orange
              : AppColors.greyBorder,
          onSubTextPress: () {
            FocusScope.of(context).unfocus();
            FocusScope.of(context).unfocus();
            if (AuthController.i.isTimeComplete.value) {
              setState(() {
                AuthController.i.isTimeComplete.value = false;
              });
              pinController.clear();
              // widget.phone_verication == 'phone'
              //     ? SocialAuthGetX().resendPhoneCode(
              //         context: context,
              //         iso_code: widget.iso_code,
              //         country_code: widget.country_code,
              //         phoneNumber: widget.phone_number.toString(),
              //         getVerificationId: (String? value) {
              //           setState(() {
              //             widget.user_id = value;
              //           });
              //         },
              //         setProgressBar: () => showLoader(),
              //         cancelProgressBar: () => stopLoader())
              //     : AuthController.i.resendCode(id:  widget.user_id.toString());

              if (widget.type == OtpType.forget.name) {
                AuthController.i.forgotPassword(context,
                    email: widget.emailAndPhone, isResendCode: true);
              } else {
                AuthController.i.resendCode(
                  email: widget.emailAndPhone,
                );
              }

              // _countDownController.start();
              // setState(() {
              //   widget.isTimeComplete = false;
              // });
            }
          }),
    );
  }
}
