import 'dart:developer';
import 'dart:io';
import 'package:ezhandy_user/module/auth/controller/auth_controller.dart';
import 'package:ezhandy_user/utils/utils.dart';
import 'package:get/get.dart';
import 'package:ezhandy_user/utils/app_dialogs.dart';
import 'package:ezhandy_user/utils/app_padding.dart';
import 'package:ezhandy_user/utils/app_strings.dart';
import 'package:ezhandy_user/utils/asset_path.dart';
import 'package:ezhandy_user/utils/constant.dart';
import 'package:ezhandy_user/utils/routes/app_navigation.dart';
import 'package:ezhandy_user/utils/routes/app_route.dart';
import 'package:ezhandy_user/utils/validator_extensions.dart';
import 'package:ezhandy_user/widgets/button_widgets/custom_button.dart';
import 'package:ezhandy_user/widgets/logo_and_backgrounds/background.dart';
import 'package:ezhandy_user/widgets/profile_widget/profile_picture_widget.dart';
import 'package:ezhandy_user/widgets/text_fields/custom_text_field.dart';
import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class EditUserProfile extends StatefulWidget {
  EditUserProfile({super.key});

  @override
  State<EditUserProfile> createState() => _EditUserProfileState();
}

class _EditUserProfileState extends State<EditUserProfile> {
  // String? error_email;

  /// Form Key
  final GlobalKey<FormState> editProfileKey = GlobalKey<FormState>();

  /// Text Editing Controllers
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  // final TextEditingController sportController = TextEditingController();
  // final TextEditingController statusController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  File? _profileImage;
  late MaskTextInputFormatter _phoneMaskFormatter;

  // bool switchOff = false;

  bool keyboardVisible = false;
  @override
  void initState() {
    super.initState();
    setController();
  }

  @override
  Widget build(BuildContext context) {
    keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    log(keyboardVisible.toString());
    return BackgroundImage(
        leading: AssetPath.backIcon,
        onclickLead: () {
          Get.back();
        },
        title: AppStrings.editProfile,
        // appBarheight: 50.h,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.padding16,
          ),
          child: Column(
            children: [
              // Non-scrollable content (e.g., logo)

              // Scrollable content starts here
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: editProfileKey,
                    child: Column(
                      children: [
                        10.verticalSpace,
                        profileWidget(),
                        20.verticalSpace,
                        CustomText(text: AppStrings.fullName + "*"),
                        10.verticalSpace,
                        _fullNameTextField(),
                        SizedBox(height: 0.02.sh),
                        CustomText(text: AppStrings.emailAddress),
                        10.verticalSpace,
                        _emailTextField(),
                        SizedBox(height: 0.02.sh),
                        CustomText(
                            text: AppStrings.phoneNumber + AppStrings.optional),
                        10.verticalSpace,
                        _phoneNumberTextField(),
                        SizedBox(height: 0.02.sh),
                        // CustomText(text: AppStrings.referralCode + "*"),
                        // 10.verticalSpace,
                        // _sportTextField(),
                        // SizedBox(height: 0.02.sh),
                        // CustomText(text: AppStrings.status + "*"),
                        // 10.verticalSpace,
                        // _statusTextField(),
                        // SizedBox(height: 0.02.sh),
                      ],
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: !keyboardVisible,
                child: _updateButton(context: context),
              ),
              Visibility(visible: !keyboardVisible, child: 25.verticalSpace)
            ],
          ),
        ));
  }

  ProfilePictureWidget profileWidget() {
    return ProfilePictureWidget(
      showUpload: true,
      setFile: _setFile,
      profileImage: _profileImage,
      assetPath: null,
      profileImageUrl:
          AuthController.i.appUser.value.data?.userModel?.profileImage,
    );
  }

  _setFile(File? file) {
    setState(() {
      _profileImage = file;
    });
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
      inputFormatters: [
        LengthLimitingTextInputFormatter(Constants.nameMaxLength)
      ],
      controller: fullNameController,
      validator: (value) => value?.validateEmpty(AppStrings.fullName),
      // error_text: error_email,
    );
  }

  // Widget _sportTextField() {
  //   return CustomTextField(
  //     hint: AppStrings.enterReferralCode,
  //     divider: false,
  //     prefxicon: AssetPath.convertIcon,
  //     label: false,

  //     // keyboardType: TextInputType.emailAddress,
  //     inputFormatters: [
  //       LengthLimitingTextInputFormatter(Constants.nameMaxLength)
  //     ],
  //     controller: sportController,
  //     validator: (value) => value?.validateEmpty(AppStrings.referralCode),
  //     // error_text: error_email,
  //   );
  // }

  // Widget _statusTextField() {
  //   return CustomTextField(
  //     hint: AppStrings.EnterStatus,
  //     divider: false,
  //     prefxicon: AssetPath.statusUpIcon,
  //     label: false,

  //     // keyboardType: TextInputType.emailAddress,
  //     inputFormatters: [
  //       LengthLimitingTextInputFormatter(Constants.nameMaxLength)
  //     ],
  //     controller: statusController,
  //     validator: (value) => value?.validateEmpty(AppStrings.status),
  //     // error_text: error_email,
  //   );
  // }

  Widget _phoneNumberTextField() {
    return CustomTextField(
      hint: AppStrings.enterPhoneNumber,
      divider: false,
      prefxicon: AssetPath.callIcon,
      label: false,
      keyboardType: TextInputType.number,
      inputFormatters: [_phoneMaskFormatter],
      controller: phoneController,
      // validator: (value) => value?.validateEmpty(AppStrings.phon),
      // error_text: error_email,
    );
  }

  Widget _emailTextField() {
    return CustomTextField(
      hint: AppStrings.enterEmailAddress,
      divider: false,
      prefxicon: AssetPath.emailIcon,
      label: false,
      readOnly: true,
      keyboardType: TextInputType.emailAddress,
      inputFormatters: [
        LengthLimitingTextInputFormatter(Constants.emailMaxLength)
      ],
      controller: emailController,
      validator: (value) => value?.validateEmail,
      // error_text: error_email,
    );
  }

  Widget _updateButton({required BuildContext context}) {
    return CustomButton(
      text: AppStrings.update,
      onclick: () {
        if (editProfileKey.currentState!.validate()) {
          AuthController.i.editProfile(
              context: context,
              media: _profileImage,
              name: fullNameController.text,
              phone: phoneController.text);

        
        }

        FocusScope.of(context).unfocus();
      },
    );
  }

  void setController() {
    fullNameController.text = Utils.capitalizeWords(
        AuthController.i.appUser.value.data?.userModel?.fullName ?? "dummy");
    emailController.text =
        AuthController.i.appUser.value.data?.userModel?.email ?? "";
    final phone =
        AuthController.i.appUser.value.data?.userModel?.mobileNumber?.trim() ??
            '';
    final digits = _nationalPhoneDigits(phone);
    _phoneMaskFormatter = MaskTextInputFormatter(
      mask: '+1 (###) ###-####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy,
      initialText: digits.isEmpty ? null : digits,
    );
    phoneController.text = _phoneMaskFormatter.getMaskedText();
  }

  String _nationalPhoneDigits(String phone) {
    var digits = phone.replaceAll(RegExp(r'\D'), '');
    if (digits.startsWith('1') && digits.length == 11) {
      digits = digits.substring(1);
    } else if (digits.length > 10) {
      digits = digits.substring(digits.length - 10);
    }
    return digits;
  }
}
