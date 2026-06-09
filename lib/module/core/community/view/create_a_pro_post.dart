import 'dart:convert';
import 'dart:io';

import 'package:ezhandy_user/module/core/community/controller/create_pro_post_controller.dart';
import 'package:ezhandy_user/module/auth/controller/auth_controller.dart';
import 'package:ezhandy_user/module/core/home/controller/home_controller.dart';
import 'package:ezhandy_user/utils/app_dialogs.dart';
import 'package:ezhandy_user/utils/app_padding.dart';
import 'package:ezhandy_user/utils/constant.dart';
import 'package:ezhandy_user/utils/enums.dart';
import 'package:ezhandy_user/utils/network_strings.dart';
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

class CreateAProPost extends StatefulWidget {
  // String? type;
  CreateAProPost({super.key});

  @override
  State<CreateAProPost> createState() => _CreateAProPostState();
}

class _CreateAProPostState extends State<CreateAProPost> {
  // String? primaryServiceValue;
  // String? secondaryServiceValue;
  TextEditingController noteController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  File? _profileImage;
  File? _profileVideo;
  File? videoThumbnail;

  String? categoryValue;
  String? selectedCategoryId;

  final CreateProPostController _createProPostController =
      Get.put(CreateProPostController());

  @override
  void dispose() {
    Get.delete<CreateProPostController>();
    noteController.dispose();
    super.dispose();
  }

  Future<void> _onPost() async {
    if (selectedCategoryId == null || selectedCategoryId!.isEmpty) {
      AppDialogs.showToast(message: AppStrings.selectCategory);
      return;
    }

    print(
      '📤 Ask Pro post data → ${jsonEncode({
        'categoryId': selectedCategoryId,
        'categoryName': categoryValue,
        'question': noteController.text.trim(),
        'image': _profileImage?.path,
        'video': _profileVideo?.path,
      })}',
    );

    final ok = await _createProPostController.submitQuery(
      categoryId: selectedCategoryId!,
      question: noteController.text,
      image: _profileImage,
      video: _profileVideo,
    );

    if (!mounted) return;
    if (ok) {
      AppDialogs.showSuccessDialog(
        context,
        description: 'Post has been created successfully.',
        title: AppStrings.congratulation,
        btnTxt1: AppStrings.ok,
        onTap1: () {
          AppNavigation.navigatorPop(context);
          AppNavigation.navigatorPop(
              Constants.navigatorKey.currentContext!);
          HomeController.i.selectedTab.value = 1;
        },
      );
      FocusScope.of(context).unfocus();
    }
  }

  List<String> _categoryNames() {
    return _createProPostController.categories
        .map((category) => category['name']?.toString() ?? '')
        .where((name) => name.isNotEmpty)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
        leading: AssetPath.backIcon,
        onclickLead: () {
          Get.back();
        },
        title: AppStrings.AskAPro,
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
                              image: _myProfileImageUrl(),
                            ),
                            10.horizontalSpace,
                            CustomText(
                              text: _myDisplayName(),
                              fontWeight: FontWeight.bold,
                            ),
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
                              CustomText(text: "Upload Image")
                            ],
                          ),
                        ),
                        10.verticalSpace,
                        Visibility(
                          visible: _profileImage != null,
                          child: Align(
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
                        ),
                        // 10.verticalSpace,
                        Divider(),

                        GestureDetector(
                          onTap: () {
                            AppDialogs.showImageSourceDialog(
                              context,
                              setFile: _setVideoFile,
                              setThumbnail: _setThumbnail,
                              isVideo: true,
                            );
                          },
                          child: Row(
                            children: [
                              Icon(Icons.video_camera_back_outlined,
                                  color: AppColors.orange),
                              5.horizontalSpace,
                              CustomText(text: "Upload Video")
                            ],
                          ),
                        ),
                        10.verticalSpace,
                        Visibility(
                          visible: videoThumbnail != null,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              height: 100.h,
                              width: 150.w,
                              decoration: BoxDecoration(
                                  // color: AppColors.green,
                                  // shape: BoxShape.circle,
                                  borderRadius: BorderRadius.circular(15.r),
                                  image: videoThumbnail != null
                                      ? DecorationImage(
                                          image: FileImage(videoThumbnail!),
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
                              child: Icon(Icons.play_circle_outline_outlined,
                                  color: AppColors.white, size: 30.sp),
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

  String _myDisplayName() {
    return AuthController.i.appUser.value.data?.userModel?.fullName?.trim() ??
        '';
  }

  String? _myProfileImageUrl() {
    final profileImage =
        AuthController.i.appUser.value.data?.userModel?.profileImage?.trim();
    if (profileImage == null || profileImage.isEmpty) return null;
    return '${NetworkStrings.IMAGE_BASE_URL}$profileImage';
  }

  _setThumbnail(File? path) {
    setState(() {
      videoThumbnail = path;
    });
  }

  _setFile(File? file) {
    setState(() {
      _profileImage = file;
    });
  }

  _setVideoFile(File? file) {
    setState(() {
      _profileVideo = file;
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
    return Obx(() {
      if (_createProPostController.categoriesLoading.value &&
          _createProPostController.categories.isEmpty) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: CircularProgressIndicator(color: AppColors.orange),
          ),
        );
      }

      final categories = _categoryNames();
      if (categories.isEmpty) {
        return CustomText(
          text: 'No categories found',
          color: AppColors.greyLight,
        );
      }

      return CustomDropDown2(
        dropDownWidth: .93.sw,
        dropDownHeight: 500.h,
        borderRadius: 10.r,
        hintText: AppStrings.selectCategory,
        dropdownValue: categoryValue,
        dropDownData: categories,
        dropdownListColor: AppColors.white,
        borderColor: AppColors.greyBorder,
        hintTextColor: AppColors.black,
        onChanged: (value) {
          setState(() {
            categoryValue = value.toString();
            final selected = _createProPostController.categories.firstWhere(
              (category) => category['name']?.toString() == value,
              orElse: () => null,
            );
            selectedCategoryId = selected?['id']?.toString();
            print(
              '✅ Ask Pro selected category → '
              'name=$categoryValue, id=$selectedCategoryId, raw=$selected',
            );
          });
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return AppStrings.selectCategory;
          }
          return null;
        },
      );
    });
  }

  Widget buttonWidget(context) {
    return Obx(() {
      final loading = _createProPostController.isLoading.value;
      return CustomButton(
        text: AppStrings.post,
        onclick: loading
            ? () {}
            : () {
                final isValid = formKey.currentState!.validate();
                if (!isValid) {
                  return;
                }
                formKey.currentState!.save();
                _onPost();
              },
      );
    });
  }
}
