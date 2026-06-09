import 'package:ezhandy_user/module/core/rating_review_report/controller/write_review_controller.dart';
import 'package:ezhandy_user/module/core/rating_review_report/routing_arguments/review_routing_arguments.dart';
import 'package:ezhandy_user/utils/app_dialogs.dart';
import 'package:ezhandy_user/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/utils/app_padding.dart';
import 'package:ezhandy_user/utils/app_strings.dart';
import 'package:ezhandy_user/utils/asset_path.dart';
import 'package:ezhandy_user/utils/routes/app_navigation.dart';
import 'package:ezhandy_user/widgets/button_widgets/custom_button.dart';
import 'package:ezhandy_user/widgets/logo_and_backgrounds/background.dart';
import 'package:ezhandy_user/widgets/rating_star/rating_star.dart';
import 'package:ezhandy_user/widgets/text_fields/custom_text_field.dart';
import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';

class WriteReviewScreen extends StatefulWidget {
  final String providerId;

  const WriteReviewScreen({required this.providerId, super.key});

  factory WriteReviewScreen.fromArgs(ReviewRoutingArgument? args) {
    return WriteReviewScreen(providerId: args?.providerId ?? '');
  }

  @override
  State<WriteReviewScreen> createState() => _WriteReviewScreenState();
}

class _WriteReviewScreenState extends State<WriteReviewScreen> {
  final TextEditingController _reviewController = TextEditingController();
  double _rating = 0.0;
  late final WriteReviewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.put(
      WriteReviewController(providerId: widget.providerId),
      tag: 'write_review_${widget.providerId}',
    );
  }

  @override
  void dispose() {
    _reviewController.dispose();
    Get.delete<WriteReviewController>(tag: 'write_review_${widget.providerId}');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
        leading: AssetPath.backIcon,
        onclickLead: Get.back,
        title: AppStrings.rateProvider,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.padding12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.verticalSpace,
              ratingWidget(),
              15.verticalSpace,
              CustomText(
                text: AppStrings.review,
                fontSize: 18.sp,
              ),
              10.verticalSpace,
              textField(),
              10.verticalSpace,
              Obx(() => buttonWidget()),
              25.verticalSpace,
            ],
          ),
        ));
  }

  Widget ratingWidget() {
    return RatingStar(
      itemSize: 25.sp,
      initialRating: _rating,
      onRatingUpdate: (rating) {
        setState(() => _rating = rating);
      },
    );
  }

  Widget buttonWidget() {
    final submitting = _controller.isSubmitting.value;
    return CustomButton(
      text: submitting ? 'Submitting...' : AppStrings.submit,
      onclick: submitting ? null : _onSubmit,
    );
  }

  Future<void> _onSubmit() async {
    if (widget.providerId.trim().isEmpty) {
      AppDialogs.showToast(message: 'Provider not found for this booking.');
      return;
    }

    final stars = _rating.round().clamp(1, 5);
    if (_rating <= 0) {
      AppDialogs.showToast(message: 'Please select a rating.');
      return;
    }

    final review = _reviewController.text.trim();
    if (review.isEmpty) {
      AppDialogs.showToast(message: 'Please write a review.');
      return;
    }

    final ok = await _controller.submitRating(
      rating: stars,
      review: review,
    );

    if (!mounted) return;

    if (ok) {
      AppDialogs.showSuccessDialog(
        context,
        description: AppStrings.reviewSubmittedSuccessfully,
        title: AppStrings.congratulation,
        btnTxt1: AppStrings.ok,
        onTap1: () {
          AppNavigation.navigatorPop(context);
          AppNavigation.navigatorPop(Constants.navigatorKey.currentContext!);
        },
      );
    }
  }

  Widget textField() {
    return CustomTextField(
      borderRadius: 15.r,
      fontColor: AppColors.black,
      hintColor: AppColors.grey,
      prefixIconColor: AppColors.green,
      divider: false,
      label: false,
      lines: 10,
      hint: AppStrings.writeAReview,
      inputFormatters: [LengthLimitingTextInputFormatter(275)],
      controller: _reviewController,
    );
  }
}
