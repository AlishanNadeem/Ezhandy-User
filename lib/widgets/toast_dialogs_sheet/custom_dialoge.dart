import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/utils/app_padding.dart';
import 'package:ezhandy_user/utils/asset_path.dart';
import 'package:ezhandy_user/widgets/button_widgets/custom_button.dart';

class CustomDialogs extends StatefulWidget {
  final Color? backgroundColor;
  final void Function()? onTap1;
  final Widget? child;
  bool isDoneShow;
  String? btnTxt1, image;

  CustomDialogs({
    Key? key,
    this.backgroundColor,
    this.onTap1,
    this.image,
    this.btnTxt1,
    this.isDoneShow = true,
    this.child,
  }) : super(key: key);

  @override
  State<CustomDialogs> createState() => _CustomDialogsState();
}

class _CustomDialogsState extends State<CustomDialogs>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _scaleAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget.onTap1?.call();
        return false;
      },
      child: Center(
        child: ScaleTransition(
          
          scale: _scaleAnimation,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppPadding.padding18),
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                // Dialog Container
                Container(
                  margin: EdgeInsets.only(bottom: 35.h),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Header with green background and space for icon
                      // Container(
                      //   height: 85.h,
                      //   decoration: BoxDecoration(
                      //     color: AppColors.green,
                      //     borderRadius: BorderRadius.only(
                      //       topLeft: Radius.circular(14.r),
                      //       topRight: Radius.circular(14.r),
                      //     ),
                      //   ),
                      // ),
                      // Space below icon
                      // SizedBox(height: 40.h),
                      // Content
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 12.h),
                        child: widget.child ?? const SizedBox(),
                      ),
                      // SizedBox(height: 35.h), // Space for the button
                    ],
                  ),
                ),

                // Positioned Icon (floating above green area)
                // Positioned(
                //   top: 30.h,
                //   child: Image.asset(
                //     widget.image ?? AssetPath.checkIcon,
                //     // scale: 3.sp,
                //     width: widget.image != null ? 60.w : 90.w,
                //     height: widget.image != null ? 60.h : 90.h,
                //   ),
                // ),

                // Positioned Button (overlapping bottom)
                Visibility(
                  visible: widget.isDoneShow,
                  child: Positioned(
                    bottom: 10,
                    child: CustomButton(
                      text: widget.btnTxt1 ?? "",
                      width: 150.w,
                      borderRadius:35.r,
                      onclick: widget.onTap1,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
