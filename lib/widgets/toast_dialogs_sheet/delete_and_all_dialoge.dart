import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/utils/app_strings.dart';
import 'package:ezhandy_user/utils/asset_path.dart';
import 'package:ezhandy_user/utils/routes/app_navigation.dart';
import 'package:ezhandy_user/widgets/button_widgets/custom_button.dart';
import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';

// ignore: must_be_immutable
class DeleteAndAllDialoge extends StatefulWidget {
  String? message, assetPath, buttonText1, buttonText2;
  // bool showButton2, showTextButton2;
  void Function()? ontapButton1;
  // void Function()? onTap;
  DeleteAndAllDialoge({this.message, this.assetPath, this.buttonText1, this.buttonText2, this.ontapButton1, super.key});

  @override
  State<DeleteAndAllDialoge> createState() => _DeleteAndAllDialogeState();
}

class _DeleteAndAllDialogeState extends State<DeleteAndAllDialoge> with SingleTickerProviderStateMixin {
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
                    // CustomText(
                    //     text: widget.title ?? "",
                    //     // color: AppColors.black,
                    //     fontSize: 18.sp,
                    //     fontWeight: FontWeight.bold,
                    //     is_alignLeft: false),
                    // 5.verticalSpace,
                    CustomText(
                        text: widget.message ?? "",
                        // color: AppColors.black,
                        fontSize: 14.sp,
                        is_alignLeft: false),
                    15.verticalSpace,
                    Row(
                      children: [
                        15.w.horizontalSpace,
                        Expanded(
                          child: CustomButton(
                              color: AppColors.black,
                              height: 45.h,
                              onclick: () {
                                AppNavigation.navigatorPop(context);
                              },
                              fontWeight: FontWeight.normal,
                              text: widget.buttonText2 ?? AppStrings.no),
                        ),
                        15.w.horizontalSpace,
                        Expanded(
                          child: CustomButton(
                            height: 45.h,
                            // isAuth: false,
                            // color: AppColors.lightPink,
                            // textcolor: AppColors.black,
                            text: widget.buttonText1 ?? "",
                            onclick: widget.ontapButton1,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        15.w.horizontalSpace,
                      ],
                    ),
                    15.h.verticalSpace,
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
