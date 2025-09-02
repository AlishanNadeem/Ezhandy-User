// ignore_for_file: must_be_immutable
import 'dart:io';

import 'package:ezhandy_user/module/auth/verification/routing_arguments/otp_verification_routing_arguments.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/utils/app_dialogs.dart';
import 'package:ezhandy_user/utils/app_padding.dart';
import 'package:ezhandy_user/utils/app_strings.dart';
import 'package:ezhandy_user/utils/asset_path.dart';
import 'package:ezhandy_user/utils/constant.dart';
import 'package:ezhandy_user/utils/enums.dart';
import 'package:ezhandy_user/utils/routes/app_navigation.dart';
import 'package:ezhandy_user/utils/routes/app_route.dart';
import 'package:ezhandy_user/utils/validator_extensions.dart';
import 'package:ezhandy_user/widgets/button_widgets/custom_button.dart';
import 'package:ezhandy_user/widgets/logo_and_backgrounds/app_logo.dart';
import 'package:ezhandy_user/widgets/profile_widget/profile_picture_widget.dart';
import 'package:ezhandy_user/widgets/text_fields/custom_text_field.dart';
import 'package:ezhandy_user/widgets/text_widgets/rich_text_widget.dart';
import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpForm extends StatefulWidget {
  bool keyboardVisible;
  SignUpForm({required this.keyboardVisible, super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  // String? error_email;

  /// Form Key
  final GlobalKey<FormState> signUpKey = GlobalKey<FormState>();

  /// Text Editing Controllers
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController sportController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController uploadController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  File? _profileImage;

  // bool switchOff = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.padding16,
      ),
      child: Column(
        children: [
          // Non-scrollable content (e.g., logo)
          AppLogo(scale: 5.sp),
          15.verticalSpace,
          createAccountTextWidget(),
          5.verticalSpace,
          CustomText(is_alignLeft: false ,text: AppStrings.createYouAccountText),
          25.verticalSpace,
          // Scrollable content starts here
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: signUpKey,
                child: Column(
                  children: [
                    CustomText(text: AppStrings.fullName + "*"),
                    10.verticalSpace,
                    _fullNameTextField(),
                    SizedBox(height: 0.02.sh),
                    CustomText(text: AppStrings.emailAddress + "*"),
                    10.verticalSpace,
                    _emailTextField(),
                    SizedBox(height: 0.02.sh),
                    CustomText(
                        text: AppStrings.phoneNumber + AppStrings.optional),
                    10.verticalSpace,
                    _phoneNumberTextField(),
                    SizedBox(height: 0.02.sh),
                    CustomText(text: AppStrings.password + "*"),
                    10.verticalSpace,
                    _passwordTextField(),
                    SizedBox(height: 0.02.sh),
                    CustomText(text: AppStrings.confirmPassword + "*"),
                    10.verticalSpace,
                    _confirmPasswordTextField(),
                    SizedBox(height: 0.02.sh),
                    CustomText(text: AppStrings.sport + "*"),
                    10.verticalSpace,
                    _sportTextField(),
                    // SizedBox(height: 0.02.sh),
                    // CustomText(text: AppStrings.status + "*"),
                    // 10.verticalSpace,
                    // _statusTextField(),
                    SizedBox(height: 0.02.sh),
                    CustomText(text: AppStrings.uploadProfileImage + "*"),
                    10.verticalSpace,
                    _uploadTextField(),
                    SizedBox(height: 0.02.sh),
                    _signUpButton(context: context),
                    SizedBox(height: 0.02.sh),
                  ],
                ),
              ),
            ),
          ),
          Visibility(
              visible: !widget.keyboardVisible,
              child: alreadyHaveAnAccountWidget()),
          Visibility(visible: !widget.keyboardVisible, child: 25.verticalSpace)
        ],
      ),
    );
  }

  ProfilePictureWidget profileWidget() {
    return ProfilePictureWidget(
        showUpload: true,
        setFile: _setFile,
        profileImage: _profileImage,
        assetPath: null);
  }

  _setFile(File? file) {
    setState(() {
      _profileImage = file;
      uploadController.text = file?.path ?? "";
    });
  }

  CustomText createAccountTextWidget() {
    return CustomText(
      text: AppStrings.createAccount,
      is_alignLeft: false,
      fontSize: 25.sp,
      fontWeight: FontWeight.bold,
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

  Widget alreadyHaveAnAccountWidget() {
    return RichTextWidget(
        text: AppStrings.alreadyHaveAnAccount,
        subText: AppStrings.logIn,
        onSubTextPress: () {
          FocusScope.of(context).unfocus();
          AppNavigation.navigatorPop(context);

          // AppNavigation.navigateTo(context, AppRoutes.signupScreenRoute);
          // Get.toNamed(Paths.SIGNUP_SCREEN_ROUTE);
        });
  }

  Widget _uploadTextField() {
    return CustomTextField(
      hint: AppStrings.upload,
      divider: false,
      prefxicon: AssetPath.uploadIcon,
      label: false,
      readOnly: true,
      onTap: () {
        AppDialogs.showImageSourceDialog(context, setFile: _setFile);
        // Utils.showImageSourceSheet(context: context, setFile: _setFile);
      },
      // keyboardType: TextInputType.emailAddress,
      // inputFormatters: [
      //   LengthLimitingTextInputFormatter(Constants.nameMaxLength)
      // ],
      controller: uploadController,
      validator: (value) => value?.validateEmpty(AppStrings.upload),
      // error_text: error_email,
    );
  }

  Widget _fullNameTextField() {
    return CustomTextField(
      hint: AppStrings.enterFullName,
      divider: false,
      prefxicon: AssetPath.profileCircleIcon,
      label: false,
      // readOnly: true,
      // onTap: () {},
      // keyboardType: TextInputType.emailAddress,
      // inputFormatters: [
      //   LengthLimitingTextInputFormatter(Constants.nameMaxLength)
      // ],
      controller: fullNameController,
      validator: (value) => value?.validateEmpty(AppStrings.fullName),
      // error_text: error_email,
    );
  }

  Widget _sportTextField() {
    return CustomTextField(
      hint: AppStrings.enterSport,
      divider: false,
      prefxicon: AssetPath.convertIcon,
      label: false,

      // keyboardType: TextInputType.emailAddress,
      inputFormatters: [
        LengthLimitingTextInputFormatter(Constants.nameMaxLength)
      ],
      controller: sportController,
      validator: (value) => value?.validateEmpty(AppStrings.sport),
      // error_text: error_email,
    );
  }

  Widget _statusTextField() {
    return CustomTextField(
      hint: AppStrings.EnterStatus,
      divider: false,
      prefxicon: AssetPath.statusUpIcon,
      label: false,

      // keyboardType: TextInputType.emailAddress,
      inputFormatters: [
        LengthLimitingTextInputFormatter(Constants.nameMaxLength)
      ],
      controller: statusController,
      validator: (value) => value?.validateEmpty(AppStrings.status),
      // error_text: error_email,
    );
  }

  Widget _phoneNumberTextField() {
    return CustomTextField(
      hint: AppStrings.enterPhoneNumber,
      divider: false,
      prefxicon: AssetPath.callIcon,
      label: false,
      keyboardType: TextInputType.number,
      inputFormatters: [Constants.maskTextInputFormatterPhoneUSWithCode],
      controller: phoneController,
      // validator: (value) => value?.validateEmpty(AppStrings.phon),
      // error_text: error_email,
    );
  }

  Widget _emailTextField() {
    return CustomTextField(
      hint: AppStrings.enterUserEmail,
      divider: false,
      prefxicon: AssetPath.emailIcon,
      label: false,

      keyboardType: TextInputType.emailAddress,
      inputFormatters: [
        LengthLimitingTextInputFormatter(Constants.emailMaxLength)
      ],
      controller: emailController,
      validator: (value) => value?.validateEmail,
      // error_text: error_email,
    );
  }

  Widget _signUpButton({required BuildContext context}) {
    return CustomButton(
      text: AppStrings.createAccount,
      onclick: () {
        if (!signUpKey.currentState!.validate()) {
          // ToastMessage(toastmsg: AppStrings.logIn);
          // if (AuthController.i.role.value == RoleType.single.name || AuthController.i.role.value == RoleType.committed.name) {
          // AppNavigation.navigateToRemovingAll(context, AppRoutes.userMainMenuScreenRoute);
          // } else {
          //   AppNavigation.navigateToRemovingAll(context, AppRoutes.sellerMainMenuScreenRoute);
          // }
          AppNavigation.navigateTo(
              context, AppRoutes.verificationSelectionScreenRoute,
              arguments:
                  OtpVerificationRoutingArgument(type: OtpType.signup.name));

          emailController.clear();
          passwordController.clear();
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
}
