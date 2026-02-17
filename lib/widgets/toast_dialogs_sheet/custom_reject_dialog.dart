import 'package:ezhandy_user/utils/app_strings.dart';
import 'package:ezhandy_user/utils/constant.dart';
import 'package:ezhandy_user/utils/routes/app_navigation.dart';
import 'package:ezhandy_user/utils/validator_extensions.dart';
import 'package:ezhandy_user/widgets/text_fields/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/utils/asset_path.dart';
import 'package:ezhandy_user/widgets/button_widgets/custom_button.dart';
import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';
import 'package:ezhandy_user/widgets/toast_dialogs_sheet/custom_dialoge.dart';

// ignore: must_be_immutable
class CustomRejectDialog extends StatelessWidget {
  void Function()? onTap1, onTap2;
  String? title, btnTxt1, btnTxt2, image;
  bool isDoneShow, barrierDismissible;

  CustomRejectDialog({
    this.title,
    this.btnTxt1,
    this.btnTxt2,
    this.image,
    this.barrierDismissible = false,
    required this.isDoneShow,
    this.onTap1,
    this.onTap2,
    super.key,
  });

  final TextEditingController subjectController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap1,
      child: CustomDialogs(
        image: image,
        onTap1: barrierDismissible
            ? () {
                AppNavigation.navigatorPop(context);
              }
            : onTap1,
        btnTxt1: btnTxt1,
        isDoneShow: isDoneShow,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.75,
          ),
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              imageWidget(),
              title == null ? const SizedBox.shrink() : 10.h.verticalSpace,
              title == null ? const SizedBox.shrink() : titleWidget(),
              10.h.verticalSpace,
              textWidget(),
              10.h.verticalSpace,
              _messageField(),
              30.h.verticalSpace,
              Visibility(
                visible: !isDoneShow,
                child: Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                          borderRadius: 35.r,
                          text: btnTxt1 ?? "",
                          onclick: onTap1),
                    ),
                    10.horizontalSpace,
                    Expanded(
                      child: CustomButton(
                          borderRadius: 35.r,
                          text: btnTxt2 ?? "",
                          onclick: onTap2,
                          color: AppColors.black),
                    ),
                  ],
                ),
              ),
              15.h.verticalSpace,
            ]),
          ),
        ),
      ),
    );
  }

  Image imageWidget() {
    return Image.asset(image ?? AssetPath.checkIcon, scale: 4.sp);
  }

  CustomText textWidget() {
    return CustomText(
        text: "Write Reason", textDecoration: TextDecoration.none);
  }

  CustomText titleWidget() {
    return CustomText(
        text: title,
        textDecoration: TextDecoration.none,
        fontSize: 24.sp,
        fontWeight: FontWeight.w500,
        is_alignLeft: false);
  }

  Widget _messageField() {
    return CustomTextField(
      hint: "Write here",
      divider: false,
      label: false,
      borderRadius: 10.r,
      lines: 5,
      inputFormatters: [
        LengthLimitingTextInputFormatter(Constants.descriptionMaxLength)
      ],
      controller: subjectController,
      validator: (value) => value?.validateEmpty(AppStrings.message),
    );
  }
}
