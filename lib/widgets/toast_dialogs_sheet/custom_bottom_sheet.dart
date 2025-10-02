import 'dart:io';

import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/utils/app_gradients.dart';
import 'package:ezhandy_user/utils/app_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ezhandy_user/utils/asset_path.dart';
import 'package:ezhandy_user/utils/routes/app_navigation.dart';
import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';

// ignore: must_be_immutable
class CustomBottomSheet extends StatelessWidget {
  double? height;
  Widget? child;
  bool showBar, showCross, isGradient, isPadding, isTopPadding;
  String? title;
  Color? titleColor;

  CustomBottomSheet({
    super.key,
    this.title,
    this.child,
    this.titleColor,
    this.height,
    this.isPadding = true,
    this.isTopPadding = true,
    this.showCross = false,
    this.showBar = false,
    this.isGradient = false,
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? SafeArea(child: bottomsheetWidget(context))
        : bottomsheetWidget(context);
  }

  Container bottomsheetWidget(BuildContext context) {
    return Container(
      height: height ?? 0.2.sh,
      width: 1.sw,
      decoration: BoxDecoration(
          gradient: isGradient ? AppGradients.filterGradient : null,
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.sp),
            topRight: Radius.circular(15.sp),
          )),
      child: Padding(
        padding: EdgeInsets.only(
          top: isTopPadding ? AppPadding.padding20 : 0,
          left: isPadding ? AppPadding.padding12 : 0,
          right: isPadding ? AppPadding.padding12 : 0,
        ),
        child: Column(
          children: [
            showBar
                ? GestureDetector(
                    child: Container(
                      height: 4,
                      width: 0.2.sw,
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(50)),
                    ),
                  )
                : SizedBox.shrink(),
            5.verticalSpace,
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // SizedBox(),
                30.horizontalSpace,
                Spacer(),
                CustomText(
                  text: title,
                  is_alignLeft: false,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: titleColor ?? null,
                ),
                Spacer(),

                showCross
                    ? GestureDetector(
                        onTap: () {
                          AppNavigation.navigatorPop(context);
                        },
                        child: Image.asset(AssetPath.crossIcon, scale: 6.sp))
                    : 20.horizontalSpace,
                5.horizontalSpace,
              ],
            ),
            // SizedBox(
            //   height: 10.h,
            // ),
            child ?? SizedBox.square()
          ],
        ),
      ),
    );
  }
}
