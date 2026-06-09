import 'package:ezhandy_user/module/core/booking/controller/booking_details_controller.dart';
import 'package:ezhandy_user/module/core/booking/model/booking_detail_model.dart';
import 'package:ezhandy_user/module/core/booking/routing_arguments/invoice_routing_arguments.dart';
import 'package:ezhandy_user/module/core/rating_review_report/routing_arguments/report_issue_routing_arguments.dart';
import 'package:ezhandy_user/module/core/rating_review_report/routing_arguments/review_routing_arguments.dart';
import 'package:ezhandy_user/module/core/booking/routing_arguments/work_documents_routing_arguments.dart';
import 'package:ezhandy_user/module/core/chat/routing_arguments/chat_routing_arguments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/utils/app_dialogs.dart';
import 'package:ezhandy_user/utils/routes/app_navigation.dart';
import 'package:ezhandy_user/utils/routes/app_route.dart';
import 'package:ezhandy_user/utils/app_padding.dart';
import 'package:ezhandy_user/utils/app_strings.dart';
import 'package:ezhandy_user/utils/asset_path.dart';
import 'package:ezhandy_user/widgets/Container/custom_container.dart';
import 'package:ezhandy_user/widgets/button_widgets/custom_button.dart';
import 'package:ezhandy_user/widgets/logo_and_backgrounds/background.dart';
import 'package:ezhandy_user/widgets/row/two_text_row.dart';
import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';

class BookingDetails extends StatefulWidget {
  final int bookingId;
  final String? initialStatus;

  const BookingDetails({
    required this.bookingId,
    this.initialStatus,
    super.key,
  });

  @override
  State<BookingDetails> createState() => _BookingDetailsState();
}

class _BookingDetailsState extends State<BookingDetails> {
  late final BookingDetailsController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.put(
      BookingDetailsController(
        bookingId: widget.bookingId,
        initialStatus: widget.initialStatus,
      ),
      tag: 'booking_${widget.bookingId}',
    );
  }

  @override
  void dispose() {
    Get.delete<BookingDetailsController>(tag: 'booking_${widget.bookingId}');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final status = _controller.status;
      final detail = _controller.detail.value;
      final c = _controller;

      return BackgroundImage(
          leading: AssetPath.backIcon,
          onclickLead: Get.back,
          title: AppStrings.booking,
          actionWidget: c.showChatAction
              ? Padding(
                  padding: const EdgeInsets.only(right: AppPadding.padding12),
                  child: GestureDetector(
                      onTap: () {
                        AppNavigation.navigateTo(
                            context, AppRoutes.chatScreenRoute,
                            arguments:
                                ChatRoutingArgument(isBooking: false));
                      },
                      child: Image.asset(
                        AssetPath.messageIcon,
                        width: 30.w,
                        height: 30.h,
                      )))
              : null,
          child: _controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : (_controller.hasValidBookingId && detail == null)
                  ? Center(
                      child: CustomText(
                        text: AppStrings.noBookingsFound,
                        color: AppColors.greyLight,
                        is_alignLeft: false,
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: AppPadding.padding12),
                            child: Column(
                              children: [
                                15.verticalSpace,
                                CustomContainer(
                                    isPadding: false,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(
                                              AppPadding.padding12),
                                          child: CustomText(
                                              text: AppStrings.service,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Divider(color: AppColors.blueDark),
                                        serviceDetailsWidget(detail),
                                      ],
                                    )),
                                10.verticalSpace,
                                CustomContainer(
                                    isPadding: false,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(
                                              AppPadding.padding12),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              CustomText(
                                                  text: AppStrings
                                                      .bookingDetails,
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.bold),
                                              CustomText(
                                                  text:
                                                      "${AppStrings.status}: $status",
                                                  fontWeight: FontWeight.w600),
                                            ],
                                          ),
                                        ),
                                        Divider(color: AppColors.blueDark),
                                        bookingDetailsWidget(detail),
                                      ],
                                    )),
                                if (c.showProviderDetails) ...[
                                  15.verticalSpace,
                                  CustomContainer(
                                      isPadding: false,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(
                                                AppPadding.padding12),
                                            child: CustomText(
                                                text: AppStrings
                                                    .providerDetails,
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Divider(color: AppColors.blueDark),
                                          providerDetailsWidget(detail),
                                        ],
                                      )),
                                ],
                                if (c.showStatusReason)
                                  rejectReasonWidget(detail),
                                if (c.showReportMessage)
                                  reportMessageWidget(),
                                if (c.showActionButtons && c.isPending) ...[
                                  15.verticalSpace,
                                  CustomButton(
                                    text: AppStrings.cancel,
                                    onclick: () => _showCancelDialog(context),
                                  )
                                ],
                                if (c.showActionButtons &&
                                    c.showCancelledReportButton) ...[
                                  15.verticalSpace,
                                  CustomButton(
                                    color: AppColors.black,
                                    text: AppStrings.reportIssue,
                                    onclick: () {
                                      AppNavigation.navigateTo(
                                        context,
                                        AppRoutes.reportIssueScreenRoute,
                                        arguments: ReportIssueRoutingArgument(
                                          bookingId: _reportBookingId,
                                        ),
                                      );
                                    },
                                  ),
                                ],
                                if (c.showWorkDocumentsCard) ...[
                                  15.verticalSpace,
                                    CustomContainer(
                                        isPadding: false,
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(
                                                  AppPadding.padding12),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  CustomText(
                                                      text: AppStrings
                                                          .workDocuments,
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  if (c.showInvoiceButton)
                                                    CustomText(
                                                        text:
                                                            AppStrings.invoice,
                                                        fontSize: 16.sp,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                ],
                                              ),
                                            ),
                                            Divider(
                                                color: AppColors.blueDark),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  10.horizontalSpace,
                                                  GestureDetector(
                                                    onTap: () {
                                                      if (detail == null) {
                                                        return;
                                                      }
                                                      AppNavigation.navigateTo(
                                                        context,
                                                        AppRoutes
                                                            .workDocumentsScreenRoute,
                                                        arguments:
                                                            WorkDocumentsRoutingArgument(
                                                          serviceTitle: detail
                                                              .service?.title,
                                                          serviceDescription:
                                                              detail.service
                                                                  ?.description,
                                                          beforeImagePaths:
                                                              detail
                                                                  .beforeImagePaths,
                                                          afterImagePaths: detail
                                                              .afterImagePaths,
                                                        ),
                                                      );
                                                    },
                                                    child: Image.asset(
                                                        AssetPath
                                                            .documentTotalIcon,
                                                        width: 50.w,
                                                        height: 50.h),
                                                  ),
                                                  const Spacer(),
                                                  if (c.showInvoiceButton &&
                                                      c.displayInvoice != null)
                                                    GestureDetector(
                                                      onTap: () {
                                                        final invoice =
                                                            c.displayInvoice;
                                                        if (invoice == null) {
                                                          return;
                                                        }
                                                        AppNavigation.navigateTo(
                                                          context,
                                                          AppRoutes
                                                              .invoiceScreenRoute,
                                                          arguments:
                                                              InvoiceRoutingArgument(
                                                            invoice: invoice,
                                                            billToName: detail
                                                                    ?.user
                                                                    ?.fullName ??
                                                                '',
                                                          ),
                                                        );
                                                      },
                                                      child: Image.asset(
                                                          AssetPath
                                                              .documentTotalIcon,
                                                          width: 50.w,
                                                          height: 50.h),
                                                    ),
                                                  10.horizontalSpace,
                                                ],
                                              ),
                                            ),
                                          ],
                                        )),
                                  15.verticalSpace,
                                ],
                                if (c.showActionButtons) ...[
                                  providerCompletedActionsWidget(),
                                  reportReviewButtonWidget(),
                                  refundButtonWidget(),
                                ],
                                if (c.isInRoute) ...[
                                  15.verticalSpace,
                                  CustomContainer(
                                    isPadding: false,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(
                                              AppPadding.padding12),
                                          child: CustomText(
                                            text: AppStrings
                                                .liveProviderLocation,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Divider(color: AppColors.blueDark),
                                        SizedBox(
                                          height: 200.h,
                                          width: double.infinity,
                                          child: Image.asset(
                                            AssetPath.map,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                                25.verticalSpace,
                              ],
                            ),
                          ),
                        ],
                      ),
                    ));
    });
  }

  int get _reportBookingId =>
      _controller.detail.value?.id ?? widget.bookingId;

  void _showCancelDialog(BuildContext context) {
    AppDialogs.showSuccessDialog(context,
        description: "Are you sure you want to cancel this \nbooking?",
        image: AssetPath.tumbIcon,
        isDoneShow: false,
        btnTxt1: AppStrings.yes,
        onTap1: () {
          AppNavigation.navigatorPop(context);
          AppDialogs.showRejectDialog(context,
              barrierDismissible: true,
              title: "Cancellation Reason",
              isDoneShow: false,
              btnTxt1: AppStrings.submit,
              btnTxt2: AppStrings.cancel,
              onTap2: () => AppNavigation.navigatorPop(context),
              onSubmitWithReason: (reason) async {
                final ok = await _controller.cancelBooking(
                  statusReason: reason,
                );
                if (!context.mounted) return;
                if (ok) {
                  AppDialogs.showSuccessDialog(
                    context,
                    description: "Booking has been cancelled successfully.",
                    title: AppStrings.congratulation,
                    isDoneShow: true,
                    btnTxt1: AppStrings.ok,
                    onTap1: () {
                      AppNavigation.navigatorPopUntil(
                          context, AppRoutes.mainMenuScreenRoute);
                    },
                  );
                }
              });
        },
        btnTxt2: AppStrings.no,
        onTap2: () => AppNavigation.navigatorPop(context));
  }

  Widget rejectReasonWidget(BookingDetail? detail) {
    return Column(
      children: [
        15.verticalSpace,
        CustomText(
          text: _controller.isRejected
              ? AppStrings.rejectionReason
              : AppStrings.cancelationReason,
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
        ),
        10.verticalSpace,
        CustomText(
          text: _controller.statusReasonText,
          color: AppColors.grey,
        ),
      ],
    );
  }

  Widget reportMessageWidget() {
    return Column(
      children: [
        15.verticalSpace,
        CustomText(
          text: AppStrings.reportMessage,
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
        ),
        10.verticalSpace,
        CustomText(
          text: _controller.reportMessageText,
          color: AppColors.grey,
        ),
      ],
    );
  }

  Padding serviceDetailsWidget(BookingDetail? detail) {
    final service = detail?.service;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.padding12),
      child: Column(
        children: [
          5.verticalSpace,
          TwoTextRow(
              firstText: "${AppStrings.service}:",
              secondText: service?.title ?? '—'),
          TwoTextRow(
              firstText: "${AppStrings.visitCharges}:",
              secondText: _formatMoney(service?.visitCharges)),
          TwoTextRow(
              firstText: "${AppStrings.hourlyRate}:",
              secondText: _formatMoney(service?.hourlyRate)),
          10.verticalSpace,
        ],
      ),
    );
  }

  Padding bookingDetailsWidget(BookingDetail? detail) {
    final user = detail?.user;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.padding12),
      child: Column(
        children: [
          5.verticalSpace,
          TwoTextRow(
              firstText: "${AppStrings.bookingId}:",
              secondText: detail != null ? '#${detail.id}' : '—'),
          TwoTextRow(
              firstText: "${AppStrings.bookingDate}:",
              secondText: _formatDate(detail?.bookingDate)),
          TwoTextRow(
              firstText: "${AppStrings.userName}:",
              secondText: user?.fullName ?? '—'),
          TwoTextRow(
              firstText: "${AppStrings.phoneNumber}:",
              secondText: user?.mobileNumber ?? '—'),
          TwoTextRow(
              firstText: "${AppStrings.emailAddress}:",
              secondText: user?.email ?? '—'),
          TwoTextRow(
              firstText: "${AppStrings.duration}:",
              secondText: _formatDurationAsHours(detail?.duration)),
          TwoTextRow(
              firstText: "${AppStrings.serviceDate}:",
              secondText: _formatDate(detail?.bookingDate)),
          TwoTextRow(
              firstText: "${AppStrings.serviceTime}:",
              secondText: _formatTimeSlots(detail?.timeSlots)),
          if (detail?.totalAmount != null)
            TwoTextRow(
                firstText: "${AppStrings.charges}:",
                secondText: _formatMoney(detail?.totalAmount)),
          10.verticalSpace,
        ],
      ),
    );
  }

  Padding providerDetailsWidget(BookingDetail? detail) {
    final provider = detail?.provider;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.padding12),
      child: Column(
        children: [
          5.verticalSpace,
          TwoTextRow(
              firstText: "Provider Name:",
              secondText: provider?.fullName ?? '—'),
          TwoTextRow(
              firstText: "${AppStrings.phoneNumber}:",
              secondText: provider?.mobileNumber ?? '—'),
          if (_controller.isStarted || _controller.isCompleted)
            TwoTextRow(
                firstText: "${AppStrings.starttime}:",
                secondText: _formatCreatedTime(detail?.createdAt)),
          10.verticalSpace,
        ],
      ),
    );
  }

  Widget reportReviewButtonWidget() {
    return Visibility(
      visible: _controller.isCompletedPaid,
      child: CustomButton(
        text: "Rate and Review",
        onclick: () {
          final providerId = _controller.detail.value?.provider?.id ?? '';
          AppNavigation.navigateTo(
            context,
            AppRoutes.writeReviewScreenRoute,
            arguments: ReviewRoutingArgument(
              providerId: providerId,
            ),
          );
        },
      ),
    );
  }

  Widget providerCompletedActionsWidget() {
    return Obx(() {
      final endingWork = _controller.isEndingWork.value;
      return Visibility(
        visible: _controller.showProviderCompletedActions,
        child: Row(
          children: [
            Expanded(
              child: CustomButton(
                text: endingWork ? 'Submitting...' : AppStrings.endWork,
                onclick: endingWork ? null : _onEndWork,
              ),
            ),
            if (_controller.showReportIssueButton) ...[
              10.horizontalSpace,
              Expanded(
                child: CustomButton(
                  color: AppColors.black,
                  text: AppStrings.reportIssue,
                  onclick: () {
                    AppNavigation.navigateTo(
                      context,
                      AppRoutes.reportIssueScreenRoute,
                      arguments: ReportIssueRoutingArgument(
                        bookingId: _reportBookingId,
                      ),
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      );
    });
  }

  Future<void> _onEndWork() async {
    final ok = await _controller.endWork();
    if (!mounted) return;

    if (ok) {
      AppDialogs.showSuccessDialog(
        context,
        description: "Work has been ended successfully.",
        title: AppStrings.congratulation,
        isDoneShow: true,
        btnTxt1: AppStrings.ok,
        onTap1: () {
          AppNavigation.navigatorPop(context);
        },
      );
    }
  }

  Widget refundButtonWidget() {
    return Visibility(
        visible: _controller.isAccepted,
        child: CustomButton(
            text: AppStrings.refund,
            onclick: () {
              AppDialogs.showSuccessDialog(context,
                  description: AppStrings.refundPolicyWork,
                  image: AssetPath.tumbIcon,
                  isDoneShow: false,
                  btnTxt1: AppStrings.refund,
                  onTap1: () {
                    AppNavigation.navigatorPop(context);
                    AppDialogs.showSuccessDialog(
                      context,
                      description: AppStrings.oneOfOurRepresentative,
                      title: AppStrings.refundRequestSubmitted,
                      btnTxt1: AppStrings.goToHome,
                      onTap1: () {
                        AppNavigation.navigatorPopUntil(
                            context, AppRoutes.mainMenuScreenRoute);
                      },
                    );
                  },
                  btnTxt2: AppStrings.cancel,
                  onTap2: () => AppNavigation.navigatorPop(context));
            }));
  }

  String _formatDate(String? value) {
    if (value == null || value.isEmpty) return '—';
    final dt = DateTime.tryParse(value);
    if (dt == null) return value;
    return DateFormat('dd MMM yyyy').format(dt);
  }

  String _formatCreatedTime(String? value) {
    if (value == null || value.isEmpty) return '—';
    final dt = DateTime.tryParse(value);
    if (dt == null) return value;
    return DateFormat('hh:mm a').format(dt.toLocal());
  }

  String _formatTimeSlots(List<String>? slots) {
    if (slots == null || slots.isEmpty) return '—';
    return slots
        .map((s) => s
            .replaceAll('_', ' ')
            .toLowerCase()
            .split(' ')
            .map((w) =>
                w.isEmpty ? w : '${w[0].toUpperCase()}${w.substring(1)}')
            .join(' '))
        .join(', ');
  }

  String _formatMoney(String? amount) {
    if (amount == null || amount.isEmpty) return '—';
    return '\$$amount';
  }

  String _formatDurationAsHours(String? durationMinutes) {
    if (durationMinutes == null || durationMinutes.trim().isEmpty) {
      return '—';
    }
    final minutes = int.tryParse(durationMinutes.trim());
    if (minutes == null || minutes <= 0) return '—';

    if (minutes % 60 == 0) {
      final hours = minutes ~/ 60;
      return hours == 1 ? '1 hour' : '$hours hours';
    }

    final hours = minutes / 60;
    final formatted =
        hours.toStringAsFixed(1).replaceAll(RegExp(r'\.0$'), '');
    return '$formatted hours';
  }
}
