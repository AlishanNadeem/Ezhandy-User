import 'package:ezhandy_user/dio_client/dio_client.dart';
import 'package:ezhandy_user/module/core/booking/model/booking_detail_model.dart';
import 'package:ezhandy_user/module/core/booking/model/booking_invoice_model.dart';
import 'package:ezhandy_user/module/core/booking/model/booking_status_helper.dart';
import 'package:ezhandy_user/utils/app_strings.dart';
import 'package:ezhandy_user/utils/listeners.dart';
import 'package:ezhandy_user/utils/network_strings.dart';
import 'package:get/get.dart';

class BookingDetailsController extends GetxController {
  BookingDetailsController({
    required this.bookingId,
    this.initialStatus,
  });

  final int bookingId;
  final String? initialStatus;

  final RxBool isLoading = false.obs;
  final RxBool isCancelling = false.obs;
  final RxBool isEndingWork = false.obs;
  final Rxn<BookingDetail> detail = Rxn<BookingDetail>();
  final RxString statusOverride = ''.obs;

  bool get hasValidBookingId => bookingId > 0;

  String get status {
    if (statusOverride.value.isNotEmpty) return statusOverride.value;
    final d = detail.value;
    if (d != null) {
      return BookingStatusHelper.labelFromApi(d.status, isPaid: d.isPaid);
    }
    return initialStatus ?? '';
  }

  bool get isCompleted {
    final d = detail.value;
    if (d != null && BookingStatusHelper.isCompleted(d.status)) {
      return true;
    }
    return _labelMatches(status, AppStrings.completed) ||
        isCompletedPaid ||
        isCompletedUnPaid;
  }

  /// Status 6 — provider marked work done; user may still verify/pay.
  bool get isProviderCompleted {
    final d = detail.value;
    if (d != null) return d.status == BookingStatusHelper.completed;
    return _labelMatches(status, AppStrings.completed);
  }

  /// Status 7 — user confirmed; payment released.
  bool get isCompletedPaid {
    final d = detail.value;
    if (d != null) {
      return d.status == BookingStatusHelper.userVerifiedIsDone;
    }
    return _matchesStatus(AppStrings.completedPaid) ||
        _matchesStatus(AppStrings.completedPaidUrgent);
  }

  bool get isCompletedUnPaid => isProviderCompleted && !isCompletedPaid;

  bool get isPending =>
      _matchesStatus(AppStrings.pending, codes: [BookingStatusHelper.pending]);
  bool get isAssigned =>
      _matchesStatus(AppStrings.assigned, codes: [BookingStatusHelper.assigned]);
  bool get isAccepted => isAssigned;
  bool get isInRoute =>
      _matchesStatus(AppStrings.inRoute, codes: [BookingStatusHelper.inRoute]);
  bool get isStarted =>
      _matchesStatus(AppStrings.started, codes: [BookingStatusHelper.started]);
  bool get isRejected =>
      _matchesStatus(AppStrings.rejected, codes: [BookingStatusHelper.rejected]);
  bool get isCancelled => _matchesStatus(AppStrings.cancelled,
      codes: [BookingStatusHelper.cancelled]);

  /// Status 3 (Assigned) and 4 (In Route) — no action buttons.
  bool get isAssignedOrInRoute => isAssigned || isInRoute;

  bool get showActionButtons => !isAssignedOrInRoute;

  bool get showProviderDetails => detail.value?.provider != null;

  bool get showStatusReason => isRejected || isCancelled;

  bool get hasExistingReport {
    final d = detail.value;
    if (d == null) return false;
    final msg = d.reportMessage?.trim();
    final type = d.reportType?.trim();
    return msg != null &&
        msg.isNotEmpty &&
        type != null &&
        type.isNotEmpty;
  }

  bool get showReportMessage => hasExistingReport;

  bool get showReportIssueButton => !hasExistingReport;

  bool get showCancelledReportButton => isCancelled && showReportIssueButton;

  /// Status 6 — End Work + Report Issue.
  bool get showProviderCompletedActions =>
      showActionButtons && isProviderCompleted;

  bool get showWorkDocumentsCard =>
      isStarted || isProviderCompleted || isCompletedPaid;

  bool get showInvoiceButton => isProviderCompleted || isCompletedPaid;

  BookingInvoice? get displayInvoice {
    final d = detail.value;
    if (d == null) return null;
    if (d.invoice != null) return d.invoice;
    if (!showInvoiceButton) return null;
    final service = d.service;
    return BookingInvoice.fromBookingDetail(
      bookingId: d.id,
      totalAmount: d.totalAmount,
      durationMinutes: d.duration,
      userId: d.user?.id ?? '',
      providerId: d.provider?.id ?? '',
      serviceTitle: service?.title,
      visitCharges: service?.visitCharges ?? '0',
      hourlyRate: service?.hourlyRate ?? '0',
      createdAt: d.createdAt,
      isPaid: d.isPaid,
    );
  }

  bool get showChatAction =>
      showActionButtons &&
      (isInRoute || isStarted || isCompletedUnPaid);

  @override
  void onInit() {
    super.onInit();
    if (hasValidBookingId) {
      fetchBookingDetail();
    }
  }

  Future<void> fetchBookingDetail({bool showLoader = true}) async {
    if (!hasValidBookingId) return;

    if (showLoader) isLoading.value = true;
    try {
      final response = await DioClient().getRequest(
        endPoint: NetworkStrings.bookingDetail(bookingId),
        isHeaderRequire: true,
      );

      await DioClient().validateResponse(
        response: response,
        responseListener: CallbackResponseListener(
          onSuccessCallback: (res) {
            final raw = res is Map ? res['data'] : null;
            if (raw is Map) {
              detail.value = BookingDetail.fromJson(
                Map<String, dynamic>.from(raw),
              );
            } else {
              detail.value = null;
            }
          },
          onFailureCallback: (_) => detail.value = null,
        ),
      );
    } finally {
      if (showLoader) isLoading.value = false;
    }
  }

  void markAsPaidLocally() {
    statusOverride.value = AppStrings.completedPaid;
  }

  Future<bool> cancelBooking({required String statusReason}) async {
    final reason = statusReason.trim();
    if (reason.isEmpty) return false;

    return _patchBookingStatus(
      status: BookingStatusHelper.cancelled,
      statusReason: reason,
      loadingFlag: isCancelling,
    );
  }

  Future<bool> endWork() async {
    return _patchBookingStatus(
      status: BookingStatusHelper.userVerifiedIsDone,
      loadingFlag: isEndingWork,
    );
  }

  Future<bool> _patchBookingStatus({
    required int status,
    String? statusReason,
    required RxBool loadingFlag,
  }) async {
    if (!hasValidBookingId || loadingFlag.value) return false;

    loadingFlag.value = true;
    var success = false;

    try {
      final data = <String, dynamic>{
        'bookingId': bookingId,
        'status': status,
      };
      if (statusReason != null && statusReason.trim().isNotEmpty) {
        data['statusReason'] = statusReason.trim();
      }

      final response = await DioClient().patchRequest(
        endPoint: NetworkStrings.bookingStatusEndpoint,
        isHeaderRequire: true,
        data: data,
      );

      await DioClient().validateResponse(
        response: response,
        responseListener: CallbackResponseListener(
          onSuccessCallback: (_) => success = true,
          onFailureCallback: (_) => success = false,
        ),
        message: true,
      );

      if (success) {
        await fetchBookingDetail(showLoader: false);
      }
    } finally {
      loadingFlag.value = false;
    }

    return success;
  }

  bool _matchesStatus(String expected, {List<int>? codes}) {
    if (_labelMatches(status, expected)) return true;
    final d = detail.value;
    if (d != null && codes != null && codes.contains(d.status)) {
      return true;
    }
    return false;
  }

  String get statusReasonText {
    final reason = detail.value?.statusReason?.trim();
    if (reason != null && reason.isNotEmpty) return reason;
    return '—';
  }

  String get reportMessageText {
    final msg = detail.value?.reportMessage?.trim();
    if (msg != null && msg.isNotEmpty) return msg;
    return '—';
  }

  bool _labelMatches(String a, String b) =>
      a.trim().toLowerCase() == b.trim().toLowerCase();
}
