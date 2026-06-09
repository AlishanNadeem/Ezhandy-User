import 'package:ezhandy_user/module/core/rating_review_report/controller/report_issue_controller.dart';
import 'package:ezhandy_user/module/core/rating_review_report/routing_arguments/report_issue_routing_arguments.dart';
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
import 'package:ezhandy_user/widgets/text_fields/custom_text_field.dart';
import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';

class ReportIssue extends StatefulWidget {
  final int bookingId;

  const ReportIssue({super.key, this.bookingId = 0});

  factory ReportIssue.fromArgs(dynamic args) {
    if (args is ReportIssueRoutingArgument) {
      return ReportIssue(bookingId: args.bookingId);
    }
    if (args is int) {
      return ReportIssue(bookingId: args);
    }
    if (args is Map) {
      final id = args['bookingId'] ?? args['id'];
      if (id is int) return ReportIssue(bookingId: id);
      if (id != null) {
        return ReportIssue(bookingId: int.tryParse(id.toString()) ?? 0);
      }
    }
    return const ReportIssue();
  }

  @override
  State<ReportIssue> createState() => _ReportIssueState();
}

class _ReportIssueState extends State<ReportIssue> {
  final TextEditingController _messageController = TextEditingController();
  late final ReportIssueController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.put(
      ReportIssueController(bookingId: widget.bookingId),
      tag: 'report_issue_${widget.bookingId}',
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    Get.delete<ReportIssueController>(
      tag: 'report_issue_${widget.bookingId}',
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
        leading: AssetPath.backIcon,
        onclickLead: () {
          Get.back();
        },
        title: AppStrings.reportIssue,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.padding12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.verticalSpace,
              CustomText(
                text: AppStrings.reportIssue,
                fontSize: 18.sp,
              ),
              10.verticalSpace,
              textField(),
              10.verticalSpace,
              buttonWidget(),
              25.verticalSpace,
            ],
          ),
        ));
  }

  Widget buttonWidget() {
    return Obx(() {
      final submitting = _controller.isSubmitting.value;
      return CustomButton(
        text: submitting ? 'Submitting...' : AppStrings.submit,
        onclick: submitting ? null : _onSubmit,
      );
    });
  }

  Future<void> _onSubmit() async {
    if (!_controller.hasValidBookingId) {
      AppDialogs.showToast(message: 'Booking not found.');
      return;
    }

    if (!_controller.hasValidUserId) {
      AppDialogs.showToast(message: 'User not found. Please log in again.');
      return;
    }

    final message = _messageController.text.trim();
    if (message.isEmpty) {
      AppDialogs.showToast(message: 'Please describe the issue.');
      return;
    }

    final ok = await _controller.submitReport(message: message);
    if (!mounted) return;

    if (ok) {
      AppDialogs.showSuccessDialog(
        context,
        description: AppStrings.issueHasBeenReportedSuccessfully,
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
      hint: AppStrings.saySomeThing,
      inputFormatters: [LengthLimitingTextInputFormatter(275)],
      controller: _messageController,
    );
  }
}
