import 'dart:io';

import 'package:ezhandy_user/module/auth/controller/auth_controller.dart';
import 'package:ezhandy_user/module/core/community/controller/create_post_controller.dart';
import 'package:ezhandy_user/utils/media_url_helper.dart';
import 'package:ezhandy_user/utils/app_dialogs.dart';
import 'package:ezhandy_user/utils/app_padding.dart';
import 'package:ezhandy_user/utils/constant.dart';
import 'package:ezhandy_user/utils/enums.dart';
import 'package:ezhandy_user/utils/routes/app_navigation.dart';
import 'package:ezhandy_user/utils/validator_extensions.dart';
import 'package:ezhandy_user/widgets/button_widgets/custom_button.dart';
import 'package:ezhandy_user/widgets/logo_and_backgrounds/background.dart';
import 'package:ezhandy_user/widgets/profile_widget/user_image_widget.dart';
import 'package:ezhandy_user/widgets/text_fields/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/utils/app_strings.dart';
import 'package:ezhandy_user/utils/asset_path.dart';
import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';

class CreateANewPost extends StatefulWidget {
  final String? type;
  CreateANewPost({this.type, super.key});

  @override
  State<CreateANewPost> createState() => _CreateANewPostState();
}

class _CreateANewPostState extends State<CreateANewPost> {
  /// Field initializer runs when [State] is created (before [initState]/[build]),
  /// so this stays valid across hot reload; [late] + assignment only in
  /// [initState] can throw [LateInitializationError] after reload.
  final CreatePostController _createPostController =
      Get.put(CreatePostController());

  TextEditingController noteController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  File? _profileImage;

  @override
  void dispose() {
    Get.delete<CreatePostController>();
    noteController.dispose();
    super.dispose();
  }

  Future<void> _onCreatePost() async {
    final ok = await _createPostController.createPost(
      description: noteController.text,
      image: _profileImage,
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
        },
      );
      FocusScope.of(context).unfocus();
    }
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
                                borderRadius: BorderRadius.circular(15.r),
                                image: _profileImage != null
                                    ? DecorationImage(
                                        image: FileImage(_profileImage!),
                                        fit: BoxFit.cover)
                                    : null),
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
    final url = resolveMediaUrl(
      AuthController.i.appUser.value.data?.userModel?.profileImage,
    );
    return url.isEmpty ? null : url;
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
      label: false,
      borderRadius: 10.r,
      lines: 7,
      inputFormatters: [
        LengthLimitingTextInputFormatter(Constants.descriptionMaxLength)
      ],
      controller: noteController,
      validator: (value) => value?.validateEmpty(AppStrings.description),
    );
  }

  Widget buttonWidget(context) {
    return Obx(() {
      final loading = _createPostController.isLoading.value;
      return CustomButton(
          text: AddEditType.add.name == widget.type
              ? AppStrings.post
              : AppStrings.update,
          onclick: loading
              ? () {}
              : () {
                  final isValid = formKey.currentState!.validate();
                  if (!isValid) {
                    return;
                  }
                  formKey.currentState!.save();
                  if (AddEditType.add.name == widget.type) {
                    _onCreatePost();
                  } else {
                    AppDialogs.showSuccessDialog(
                      context,
                      description: "Post has been Updated successfully.",
                      title: AppStrings.congratulation,
                      btnTxt1: AppStrings.ok,
                      onTap1: () {
                        AppNavigation.navigatorPop(context);
                        AppNavigation.navigatorPop(
                            Constants.navigatorKey.currentContext!);
                      },
                    );
                    FocusScope.of(context).unfocus();
                  }
                });
    });
  }
}
