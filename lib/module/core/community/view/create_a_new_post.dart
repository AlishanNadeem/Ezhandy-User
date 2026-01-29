import 'dart:io';

import 'package:ezhandy_user/utils/app_dialogs.dart';
import 'package:ezhandy_user/utils/app_padding.dart';
import 'package:ezhandy_user/utils/constant.dart';
import 'package:ezhandy_user/utils/enums.dart';
import 'package:ezhandy_user/utils/routes/app_navigation.dart';
import 'package:ezhandy_user/utils/routes/app_route.dart';
import 'package:ezhandy_user/utils/validator_extensions.dart';
import 'package:ezhandy_user/widgets/button_widgets/custom_button.dart';
import 'package:ezhandy_user/widgets/logo_and_backgrounds/background.dart';
import 'package:ezhandy_user/widgets/profile_widget/profile_picture_widget.dart';
import 'package:ezhandy_user/widgets/profile_widget/user_image_widget.dart';
import 'package:ezhandy_user/widgets/text_fields/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/utils/app_strings.dart';
import 'package:ezhandy_user/utils/asset_path.dart';
import 'package:ezhandy_user/widgets/dropdown/custom_dropdown.dart';
import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';

class CreateANewPost extends StatefulWidget {
  String? type;
  CreateANewPost({this.type, super.key});

  @override
  State<CreateANewPost> createState() => _CreateANewPostState();
}

class _CreateANewPostState extends State<CreateANewPost> {
  // String? primaryServiceValue;
  // String? secondaryServiceValue;
  TextEditingController noteController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  File? _profileImage;

  String? categoryValue;
  var categoryList = [
    "Adhesives",
    "Allen keys",
    "Angle grinders",
    "Chalk lines",
    "Chisels & hand planes",
    "Circular saws",
    "Circuit testers",
    "Crimping tools",
    "Drill bit sets & blade replacements",
    "Drills",
    "Drop cloths & painter’s tape",
    "Ear protection",
    "Electrical tape",
    "Extension ladders",
    "Faucet & basin wrenches",
    "Fish tape",
    "Hand saws",
    "Hard hats",
    "Hammers",
    "Heat guns",
    "Impact drivers",
    "Jigsaws",
    "Knee pads",
    "Levels",
    "Measuring & marking tools",
    "Nail guns & staplers",
    "Nail sets & hammers",
    "Paint brushes",
    "Paint sprayers",
    "Pipe cutters",
    "Pipe wrenches",
    "Pliers",
    "Power drills",
    "Putty knives & scrapers",
    "Reciprocating saws",
    "Rollers & roller trays",
    "Rotary tools",
    "Safety goggles",
    "Sanders",
    "Sandpaper & sanding blocks",
    "Saws",
    "Screws, nails, bolts, anchors",
    "Screwdrivers",
    "Step ladders",
    "Stud finders",
    "Tape measures & rulers",
    "Teflon tape & sealant tools",
    "Tool belts & pouches",
    "Toolboxes & storage cases",
    "Utility knives & blades",
    "Voltage testers & multimeters",
    "Wire cutters & strippers",
    "Work gloves",
    "Workbenches"
  ];

  // String? filterStartValue;

  // bool isLike=false;

  @override
  void initState() {
    //  primaryServiceValue="All";
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
        leading: AssetPath.backIcon,
        onclickLead: () {
          Get.back();
        },
        title: AddEditType.add.name == widget.type
            ? AppStrings.createANewPost
            : AppStrings.editPost,
        appBarheight: 50,
        child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppPadding.padding12),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(children: [
                        20.verticalSpace,
                        Row(
                          children: [
                            UserImageWidget(
                              size: 20,
                            ),
                            10.horizontalSpace,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: "User Name",
                                  fontWeight: FontWeight.bold,
                                ),
                                CustomText(
                                  text: "2 days",
                                  fontSize: 10.sp,
                                )
                              ],
                            )
                          ],
                        ),
                        20.verticalSpace,
                        CustomText(
                            text: AppStrings.category + "*",
                            fontWeight: FontWeight.w600),
                        10.verticalSpace,
                        categoryDropDown(),
                        20.verticalSpace,
                        _messageField(),
                        10.verticalSpace,
                        GestureDetector(
                          onTap: () {
                            AppDialogs.showImageSourceDialog(context,
                                setFile: _setFile);
                          },
                          child: Row(
                            children: [
                              Icon(Icons.image_outlined,
                                  color: AppColors.orange),
                              5.horizontalSpace,
                              CustomText(text: "Upload Image(s)")
                            ],
                          ),
                        ),
                        10.verticalSpace,
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            height: 100.h,
                            width: 150.w,
                            decoration: BoxDecoration(
                                // color: AppColors.green,
                                // shape: BoxShape.circle,
                                borderRadius: BorderRadius.circular(15.r),
                                image: _profileImage != null
                                    ? DecorationImage(
                                        image: FileImage(_profileImage!),
                                        fit: BoxFit.cover)
                                    : null

                                // profileImageUrl != null && profileImageUrl != ""
                                //     ? DecorationImage(image: NetworkImage(
                                //         // NetworkStrings.BASE_URL +
                                //         profileImageUrl!), fit: BoxFit.cover)
                                //     :
                                //  DecorationImage(
                                //     image: AssetImage(assetPath ?? AssetPath.userIcon),
                                //     scale: assetPath != null ? 2 : 4.0,
                                //     fit: assetPath == null ? null : BoxFit.cover
                                // ),
                                ),
                          ),
                        ),
                      ]),
                    ),
                  ),
                ),
                20.verticalSpace,
                buttonWidget(context),
                25.verticalSpace
              ],
            )));
  }

  _setFile(File? file) {
    setState(() {
      _profileImage = file;
    });
  }

  Widget _messageField() {
    return CustomTextField(
      hint: AppStrings.writeHere,
      divider: false,
      // prefxicon: AssetPath.convertIcon,
      label: false,
      borderRadius: 10.r,
      lines: 7,
      // keyboardType: TextInputType.emailAddress,
      inputFormatters: [
        LengthLimitingTextInputFormatter(Constants.descriptionMaxLength)
      ],
      controller: noteController,
      validator: (value) => value?.validateEmpty(AppStrings.description),
      // error_text: error_email,
    );
  }

  Widget categoryDropDown() {
    return CustomDropDown2(
      // width: 95.w, // 👈 Controls button width
      dropDownWidth: .93.sw, // 👈 Controls dropdown menu width
      dropDownData: categoryList,
      dropDownHeight: 500.h,
      borderRadius: 10.r,
      hintText: AppStrings.selectCategory,
      dropdownValue: categoryValue,
      dropdownListColor: AppColors.white,
      borderColor: AppColors.greyBorder,
      hintTextColor: AppColors.black,
      onChanged: (value) {
        setState(() {
          categoryValue = value.toString();
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return AppStrings.selectCategory;
        }
        return null;
      },
    );
  }

  Widget buttonWidget(context) {
    return CustomButton(
        text: AddEditType.add.name == widget.type
            ? AppStrings.post
            : AppStrings.update,
        onclick: () {
          final isValid = formKey.currentState!.validate();
          if (!isValid) {
            return;
          }
          formKey.currentState!.save();
          AppDialogs.showSuccessDialog(
            context,
            description: AddEditType.add.name == widget.type
                ? "Post has been created successfully."
                : "Post has been Updated successfully.",
            title: AppStrings.congratulation,
            btnTxt1: AppStrings.ok,
            onTap1: () {
              AppNavigation.navigatorPop(context);
              AppNavigation.navigatorPop(
                  Constants.navigatorKey.currentContext!);
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
