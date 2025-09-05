import 'dart:async';
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

  int _remainingTime = 0;
  Timer? _otpTextTimer;
  bool _isTimeComplete = false;

  @override
  void initState() {
    super.initState();
    _remainingTime = widget.duration;
    _startOtpTimer(() {
      setState(() {
        _isTimeComplete = true;
      });
    });
  }

  @override
  void dispose() {
    _otpTextTimer?.cancel();
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
                    CustomText(is_alignLeft: false,
                        text: widget.type == OtpType.forget.name
                            ? AppStrings.otpCodeForgetMessage
                            : widget.emailAndPhone == OtpCodeType.email.name
                                ? AppStrings.otpCodeEmailMessage
                                : AppStrings.otpCodePhoneMessage),
                    20.verticalSpace,
                    // CustomText(text: AppStrings.verificationCode + "*"),
                    // 10.verticalSpace,
                    pinCodeWidget(context),
                    20.verticalSpace,
                    _verifyButton(context),
                    10.verticalSpace,
                    _otpResendTextTimerWidget(),
                  ],
                ),
              ),
            ),
          ),
          // Visibility(
          //     visible: !widget.keyboardVisible,
          //     child: didntReceiveCodeWidget()),
          // 25.verticalSpace
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
          if (widget.type == OtpType.forget.name) {
            AppNavigation.navigateReplacementNamed(
                context, AppRoutes.resetPasswordScreenRoute);
            // AppNavigation.navigateToRemovingAll(context, AppRoutes.userMainMenuScreenRoute);
          } else {
                                AuthController.i.isLoginSignUp.value = true;

            AppNavigation.navigateToRemovingAll(context, AppRoutes.mainMenuScreenRoute);
          }
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
          fieldHeight: .06.sh,
          fieldWidth: .19.sw,
          activeFillColor: AppColors.transparent,
          inactiveFillColor: AppColors.transparent,
          selectedFillColor: AppColors.transparent,
          activeColor: AppColors.orange,
          inactiveColor: AppColors.orange,
          selectedColor: AppColors.orange,
          shape: PinCodeFieldShape.underline,
        ),
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

  Widget _otpResendTextTimerWidget() {
    return Align(
      alignment: Alignment.center,
      child: RichText(
        text: TextSpan(
          text: !_isTimeComplete
              ? 'Wait for ${_formatMMSS(_remainingTime)} '
              : '00:00 ',
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.black,
          ),
          children: [
            TextSpan(
              text: 'Send Again',
              style: TextStyle(
                fontSize: 14,
                color: _isTimeComplete ? AppColors.orange : AppColors.grey,
                decoration: TextDecoration.underline,
              ),
              recognizer: _isTimeComplete
                  ? (TapGestureRecognizer()
                    ..onTap = () {
                      FocusScope.of(context).unfocus();
                      pinController.clear();
                      ToastMessage(
                          toastmsg:
                              "We have resend OTP verification code at your email address.");
                      setState(() {
                        _remainingTime = widget.duration;
                        _isTimeComplete = false;
                      });
                      _startOtpTimer(() {
                        setState(() {
                          _isTimeComplete = true;
                        });
                      });
                    })
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  void _startOtpTimer(VoidCallback onComplete) {
    _otpTextTimer?.cancel();
    _otpTextTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 1) {
        setState(() {
          _remainingTime--;
        });
      } else {
        timer.cancel();
        onComplete();
      }
    });
  }

  String _formatMMSS(int seconds) {
    final m = (seconds ~/ 60).toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');
    return "$m:$s";
  }

  Widget didntReceiveCodeWidget() {
    return Container(
      alignment: Alignment.center,
      width: 1.sw,
      child: RichTextWidget(
        text: AppStrings.didnotReceiveCode,
        subText: AppStrings.resend,
        subTextColor:
            _isTimeComplete ? AppColors.blueDark : AppColors.greyBorder,
        onSubTextPress: () {
          if (_isTimeComplete) {
            FocusScope.of(context).unfocus();
            pinController.clear();
            ToastMessage(
                toastmsg:
                    "We have resend OTP verification code at your email address.");
            setState(() {
              _remainingTime = widget.duration;
              _isTimeComplete = false;
            });
            _startOtpTimer(() {
              setState(() {
                _isTimeComplete = true;
              });
            });
          }
        },
      ),
    );
  }
}
