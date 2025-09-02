import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/utils/app_dialogs.dart';
import 'package:ezhandy_user/utils/app_padding.dart';
import 'package:ezhandy_user/utils/app_strings.dart';
import 'package:ezhandy_user/utils/asset_path.dart';
import 'package:ezhandy_user/utils/constant.dart';
import 'package:ezhandy_user/utils/routes/app_navigation.dart';
import 'package:ezhandy_user/utils/validator_extensions.dart';
import 'package:ezhandy_user/widgets/button_widgets/custom_button.dart';
import 'package:ezhandy_user/widgets/text_fields/custom_text_field.dart';
import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';

class CustomRejectDialog extends StatefulWidget {
  final Color? backgroundColor;
  final void Function()? onTap1;
  final Widget? child;
  bool isDoneShow;
  String? btnTxt1, image;

  CustomRejectDialog({
    Key? key,
    this.backgroundColor,
    this.onTap1,
    this.image,
    this.btnTxt1,
    this.isDoneShow = true,
    this.child,
  }) : super(key: key);

  @override
  State<CustomRejectDialog> createState() => _CustomRejectDialogState();
}

class _CustomRejectDialogState extends State<CustomRejectDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  final TextEditingController subjectController = TextEditingController();

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
    subjectController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboard = MediaQuery.of(context).viewInsets.bottom;
    final size = MediaQuery.of(context).size;

    return Material(
      color: AppColors.transparent,
      child: WillPopScope(
        onWillPop: () async {
          widget.onTap1?.call();
          return false;
        },
        // This padding animates when the keyboard shows/hides, keeping the dialog visible.
        child: AnimatedPadding(
          padding: EdgeInsets.only(bottom: keyboard),
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          child: SafeArea(
            child: Center(
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.padding18,
                  ),
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      // Dialog Container
                      Container(
                        margin: EdgeInsets.only(bottom: 35.h),
                        decoration: BoxDecoration(
                          color: AppColors.green,
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                        // Constrain height so content can scroll and buttons stay visible
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            // cap dialog height to 85% of screen height
                            maxHeight: size.height * 0.5,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Header (kept)
                              Container(
                                height: 85.h,
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(14.r),
                                    topRight: Radius.circular(14.r),
                                  ),
                                ),
                              ),
                              SizedBox(height: 40.h),

                              // Scrollable content section
                              Expanded(
                                child: SingleChildScrollView(
                                  keyboardDismissBehavior:
                                      ScrollViewKeyboardDismissBehavior.onDrag,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16.w, vertical: 12.h),
                                  child: Column(
                                    children: [
                                      20.verticalSpace,
                                      CustomText(
                                        text: AppStrings.rejectReason,
                                        color: AppColors.white,
                                        textDecoration: TextDecoration.none,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.sp,
                                        is_alignLeft: false,
                                      ),
                                      20.verticalSpace,
                                      _messageField(),
                                      12.verticalSpace,
                                    ],
                                  ),
                                ),
                              ),

                              // Buttons fixed at the bottom (always visible)
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 16.w,
                                  right: 16.w,
                                  bottom: 16.h,
                                  top: 8.h,
                                ),
                                child: buttonRowWidget(),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Floating icon
                      Positioned(
                        top: 30.h,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.white,
                            border: Border.all(
                              color: AppColors.white,
                              width: 5.r,
                            ),
                          ),
                          padding: const EdgeInsets.only(
                              left: 13, right: 4, bottom: 10, top: 10),
                          child: Image.asset(
                            AssetPath.rejectCheckIcon,
                            width: 90.w,
                            height: 90.h,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row buttonRowWidget() {
    return Row(
      children: [
        Expanded(
          child: CustomButton(
            text: AppStrings.reject,
            color: AppColors.white,
            textcolor: AppColors.black,
            onclick: () {
              FocusScope.of(context).unfocus(); // hide keyboard
              AppNavigation.navigatorPop(context);

              AppDialogs.showSuccessDialog(
                context,
                description: AppStrings.yourRescheduleRejectText,
                title: AppStrings.rejectSuccessfully,
                btnTxt1: AppStrings.ok,
                onTap1: () {
                  AppNavigation
                      .navigatorPop(Constants.navigatorKey.currentContext!);
                  AppNavigation
                      .navigatorPop(Constants.navigatorKey.currentContext!);
                },
              );
            },
          ),
        ),
        10.horizontalSpace,
        Expanded(
          child: CustomButton(
            text: AppStrings.cancel,
            onclick: () {
              FocusScope.of(context).unfocus(); // hide keyboard
              AppNavigation.navigatorPop(context);
            },
            color: AppColors.blueDark,
          ),
        ),
      ],
    );
  }

  Widget _messageField() {
    return CustomTextField(
      hint: AppStrings.enterMessage,
      divider: false,
      label: false,
      borderRadius: 10.r,
      lines: 5, // your custom field handles this
      inputFormatters: [
        LengthLimitingTextInputFormatter(Constants.descriptionMaxLength)
      ],
      controller: subjectController,
      validator: (value) => value?.validateEmpty(AppStrings.message),
    );
  }
}
