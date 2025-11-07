import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/utils/app_dialogs.dart';
import 'package:ezhandy_user/utils/app_padding.dart';
import 'package:ezhandy_user/utils/app_strings.dart';
import 'package:ezhandy_user/utils/asset_path.dart';
import 'package:ezhandy_user/utils/routes/app_navigation.dart';
import 'package:ezhandy_user/utils/routes/app_route.dart';
import 'package:ezhandy_user/utils/validator_extensions.dart';
import 'package:ezhandy_user/widgets/button_widgets/custom_button.dart';
import 'package:ezhandy_user/widgets/logo_and_backgrounds/app_logo.dart';
import 'package:ezhandy_user/widgets/text_fields/custom_text_field.dart';
import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';
import 'package:ezhandy_user/widgets/toast_dialogs_sheet/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResetPasswordForm extends StatefulWidget {
  const ResetPasswordForm({super.key});

  @override
  State<ResetPasswordForm> createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  /// Form Key
  final GlobalKey<FormState> rsesetpassKey = GlobalKey<FormState>();

  /// Text Editing Controllers
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.padding16),
      child: Column(
        children: [
          // Non-scrollable content (e.g., logo)
          // AppLogo(scale: 5.sp),
         AppLogo(scale: 3.5.sp),
          15.verticalSpace,
          passwordRecoveryTextWidget(),
         
          5.verticalSpace,
          // Scrollable content starts here
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: rsesetpassKey,
                child: Column(children: [
                  //----------------Email Address Field----------------
                  CustomText(is_alignLeft: false ,text: AppStrings.forgotYourPasswordNoWorries),
                  20.verticalSpace,
                  CustomText(text: AppStrings.password ),
                  10.verticalSpace,
                  _passwordTextField(),
                  20.verticalSpace,
                  CustomText(text: AppStrings.confirmPassword ),
                  10.verticalSpace,
                  _confirmPasswordTextField(),
                  SizedBox(height: 30.h),
                  //----------------Get Code Button----------------
                  buttonWidget(context),
                ]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _passwordTextField() {
    return CustomTextField(
        divider: false,
        label: false,
        hint: AppStrings.enterPassword,
        prefxicon: AssetPath.lockIcon,
        inputFormatters: [LengthLimitingTextInputFormatter(35)],
        sufixImage: Icon(
          FieldValidator.isHidepassword
              ? Icons.visibility_off_outlined
              : Icons.visibility_outlined,
          size: 20.sp,
          color: AppColors.orange,
        ),
        obscureText: FieldValidator.isHidepassword,
        onclickSufix: () {
          setState(() {
            FieldValidator.passwordHideIcon();
          });
        },
        controller: passwordController,
        validator: (value) {
          return FieldValidator.validateLoginPassword(value!, "Password");
        });
  }

  Widget _confirmPasswordTextField() {
    return CustomTextField(
        divider: false,
        label: false,
        hint: AppStrings.confirmPassword,
        prefxicon: AssetPath.lockIcon,
        // prefixRIghtPadding: 8.w,
        inputFormatters: [LengthLimitingTextInputFormatter(35)],
        sufixImage: Icon(
          FieldValidator.isHideconfirmpassword
              ? Icons.visibility_off
              : Icons.visibility,
          size: 20.sp,
          color: AppColors.orange,
        ),
        obscureText: FieldValidator.isHideconfirmpassword,
        onclickSufix: () {
          setState(() {
            FieldValidator.confirmPasswordHideIcon();
          });
        },
        controller: confirmPasswordController,
        validator: (value) {
          return FieldValidator.validateConfirmPassword(
              value!, passwordController.text, AppStrings.confirmPassword);
        });
  }

  CustomText passwordRecoveryTextWidget() {
    return CustomText(
      text: AppStrings.resetYourPassword,
      is_alignLeft: false,
      fontSize: 23.sp,
      fontWeight: FontWeight.bold,
      color: AppColors.orange,
    );
  }

  Widget buttonWidget(context) {
    return CustomButton(
        text: AppStrings.updatePassword,
        onclick: () {
          final isValid = rsesetpassKey.currentState!.validate();
          if (!isValid) {
            return;
          }
          rsesetpassKey.currentState!.save();
          AppDialogs.showSuccessDialog(
            context,
            description: AppStrings.passwordUpdatedSuccessfully,
            title: AppStrings.passwordUpdated,
            btnTxt1: AppStrings.backToLogin,
            onTap1: () {
              AppNavigation.navigateToRemovingAll(
                  context, AppRoutes.loginScreenRoute);
            },
          );
          // AppNavigation.navigateTo(
          //     context, AppRoutes.otpVerificationScreenRoute,
          //     arguments: OtpVerificationRoutingArgument(
          //         type: OtpType.forget.name,
          //         emailAndPhone: emailController.text,
          //         text: emailController.text));
          // AuthController.i
          //     .forgotPass(email: forgotPassRepo.email_controller.text);
          // ToastMessage(toastmsg: AppStrings.otpSendedToYourEmail);
          FocusScope.of(context).unfocus();
        });
  }
}
