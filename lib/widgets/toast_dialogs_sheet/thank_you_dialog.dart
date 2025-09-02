import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/utils/app_padding.dart';
import 'package:ezhandy_user/utils/asset_path.dart';
import 'package:ezhandy_user/utils/routes/app_navigation.dart';
import 'package:ezhandy_user/widgets/button_widgets/custom_button.dart';
import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';

// ignore: must_be_immutable
class ThankYouDialog extends StatefulWidget {
  String? title, message, assetPath, buttonText1;
  // bool showButton2, showTextButton2;
  void Function()? ontapButton1;
  // void Function()? onTap;
  ThankYouDialog({this.title, this.message, this.assetPath, this.buttonText1, this.ontapButton1, super.key});

  @override
  State<ThankYouDialog> createState() => _ThankYouDialogState();
}

class _ThankYouDialogState extends State<ThankYouDialog> with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 400));
    _scaleAnimation = CurvedAnimation(parent: _animationController!, curve: Curves.easeIn);
    _animationController!.addListener(() {
      setState(() {});
    });
    _animationController!.forward();
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Execute your method here
        // if (widget.onTap != null) {
        //   widget.onTap!();
        // } else {
        AppNavigation.navigatorPop(context);
        // }
        return false; // Return true to allow back navigation, false to prevent it
      },
      child: ScaleTransition(
          scale: _scaleAnimation!,
          child: Dialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 20.sp),
            backgroundColor: AppColors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
              // side: const BorderSide(color: AppColors.white)
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.padding12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    children: [
                      // addNewWidget(context),
                      15.h.verticalSpace,
                      Image.asset(
                        widget.assetPath ?? AssetPath.deleteIcon,
                        scale: 4.sp,
                        // color: AppColors.white,
                      ),

                      10.verticalSpace,
                      CustomText(
                          text: widget.title ?? "",
                          // color: AppColors.black,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          is_alignLeft: false),
                      5.verticalSpace,
                      CustomText(
                          text: widget.message ?? "",
                          // color: AppColors.black,
                          fontSize: 14.sp,
                          is_alignLeft: false),
                      15.verticalSpace,
                      CustomButton(
                        height: 45.h,
                        // isAuth: false,
                        // color: AppColors.lightPink,
                        // textcolor: AppColors.black,
                        text: widget.buttonText1 ?? "",
                        onclick: widget.ontapButton1,
                        fontWeight: FontWeight.normal,
                      ),
                      15.h.verticalSpace,
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
