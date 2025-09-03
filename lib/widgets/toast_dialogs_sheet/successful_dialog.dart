import 'package:ezhandy_user/utils/routes/app_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/utils/asset_path.dart';
import 'package:ezhandy_user/widgets/button_widgets/custom_button.dart';
import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';
import 'package:ezhandy_user/widgets/toast_dialogs_sheet/custom_dialoge.dart';

// ignore: must_be_immutable
class SuccessfulDialog extends StatelessWidget {
  void Function()? onTap1, onTap2;
  String? title, btnTxt1, btnTxt2, image;
  String description;
  bool isDoneShow, barrierDismissible;
  SuccessfulDialog(
      {this.title,
      this.btnTxt1,
      this.btnTxt2,
      this.image,
      this.barrierDismissible = false,
      required this.isDoneShow,
      required this.description,
      this.onTap1,
      this.onTap2,
      super.key});

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
          // isCross: false,
          // backgroundColor: AppColors.white,
          // Heading: title,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              imageWidget(),
              title == null ? SizedBox.shrink() : 10.h.verticalSpace,
              title == null ? SizedBox.shrink() : titleWidget(),
              10.h.verticalSpace,
              textWidget(),
              30.h.verticalSpace,
              Visibility(
                visible: !isDoneShow,
                child: Row(
                  children: [
                    Expanded(
                        child: CustomButton(
                      borderRadius: 35.r,
                      text: btnTxt1 ?? "",
                      onclick: onTap1,
                    )),
                    10.horizontalSpace,
                    Expanded(
                        child: CustomButton(
                      borderRadius: 35.r,
                      text: btnTxt2 ?? "",
                      onclick: onTap2,
                      color: AppColors.black,
                    )),
                  ],
                ),
              )
            ],
          )),
    );
  }

  Image imageWidget() {
    return Image.asset(
      image ?? AssetPath.checkIcon,
      scale: 4.sp,
      // color: AppColors.backButtonPurple,
    );
  }

  CustomText textWidget() {
    return CustomText(
      text: description,
      is_alignLeft: false,
      textDecoration: TextDecoration.none, // ✅ Remove any inherited underlines
    );
  }

  CustomText titleWidget() {
    return CustomText(
      text: title,
      // color: AppColors.blueDark,
      textDecoration: TextDecoration.none,
      fontSize: 24.sp,
      fontWeight: FontWeight.w500,
      is_alignLeft: false,
    );
  }
}
