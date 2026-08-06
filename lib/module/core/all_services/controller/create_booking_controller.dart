import 'package:ezhandy_user/dio_client/dio_client.dart';
import 'package:ezhandy_user/module/core/all_services/routing_arguments/service_routing_arguments.dart';
import 'package:ezhandy_user/utils/api_enums.dart';
import 'package:ezhandy_user/utils/app_dialogs.dart';
import 'package:ezhandy_user/utils/checkout_browser.dart';
import 'package:ezhandy_user/utils/listeners.dart';
import 'package:ezhandy_user/utils/network_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateBookingController extends GetxController {
  final RxBool isSubmitting = false.obs;

  /// Starts the booking checkout flow:
  /// 1) POST [payment/create-booking-draft-checkout] to create a draft
  ///    booking + Stripe checkout session, receiving back a `url` and
  ///    `sessionId`.
  /// 2) Opens the returned Stripe checkout `url` in a webview.
  /// 3) When the webview redirects to `successUrl`, POST
  ///    [payment/verify-booking-checkout] with the `sessionId` to confirm
  ///    the booking, then invoke [onSuccess].
  Future<void> startBookingCheckout({
    required BuildContext context,
    required ServiceRoutingArgument args,
    required int durationMinutes,
    int? secondaryServiceId,
    VoidCallback? onSuccess,
  }) async {
    if (isSubmitting.value) return;

    final serviceId = _resolveServiceId(args);
    final bookingDate = args.selectedDate;
    final timeSlot = args.selectedTimeSlot;

    if (serviceId == null) return;
    if (bookingDate == null) return;
    if (timeSlot == null) return;
    if (durationMinutes <= 0) return;

    isSubmitting.value = true;

    final bookings = <Map<String, dynamic>>[
      _buildBookingItem(
        serviceId: serviceId,
        bookingDate: bookingDate,
        timeSlot: timeSlot,
        durationMinutes: durationMinutes,
      ),
    ];

    if (secondaryServiceId != null) {
      bookings.add(
        _buildBookingItem(
          serviceId: secondaryServiceId,
          bookingDate: bookingDate,
          timeSlot: timeSlot,
          durationMinutes: durationMinutes,
          bookingType: ApiBookingType.secondary,
        ),
      );
    }

    try {
      final response = await DioClient().postRequest(
        endPoint: NetworkStrings.createBookingDraftCheckoutEndpoint,
        data: <String, dynamic>{
          'bookings': bookings,
          'currency': 'usd',
          'successUrl': NetworkStrings.bookingCheckoutSuccessUrl,
          'cancelUrl': NetworkStrings.bookingCheckoutCancelUrl,
        },
        isHeaderRequire: true,
      );

      Map<String, dynamic>? checkoutData;

      await DioClient().validateResponse(
        response: response,
        responseListener: CallbackResponseListener(
          onSuccessCallback: (r) => checkoutData = _extractCheckoutData(r),
          onFailureCallback: (_) {},
        ),
        message: true,
      );

      final checkoutUrl = checkoutData?['url']?.toString().trim();
      final sessionId = checkoutData?['sessionId']?.toString().trim();

      if (checkoutUrl == null || checkoutUrl.isEmpty) {
        AppDialogs.showToast(message: 'Unable to start checkout');
        return;
      }
      if (sessionId == null || sessionId.isEmpty) {
        AppDialogs.showToast(message: 'Unable to start checkout session');
        return;
      }

      CheckoutBrowser.open(
        context,
        checkoutUrl: checkoutUrl,
        successUrl: NetworkStrings.bookingCheckoutSuccessUrl,
        cancelUrl: NetworkStrings.bookingCheckoutCancelUrl,
        navigateOnSuccess: false,
        confirmSessionId: sessionId,
        confirmSession: verifyBookingCheckout,
        onSuccess: onSuccess,
      );
    } finally {
      isSubmitting.value = false;
    }
  }

  /// POST [payment/verify-booking-checkout] — confirms the booking once the
  /// Stripe checkout redirects to the success url.
  static Future<bool> verifyBookingCheckout(String sessionId) async {
    final id = sessionId.trim();
    if (id.isEmpty) return false;

    var success = false;

    final response = await DioClient().postRequest(
      endPoint: NetworkStrings.verifyBookingCheckoutEndpoint,
      data: <String, dynamic>{'sessionId': id},
      isHeaderRequire: true,
    );

    await DioClient().validateResponse(
      response: response,
      responseListener: CallbackResponseListener(
        onSuccessCallback: (_) => success = true,
        onFailureCallback: (_) => success = false,
      ),
      message: true,
    );

    return success;
  }

  static Map<String, dynamic>? _extractCheckoutData(dynamic response) {
    final outer = response is Map ? response['data'] : null;

    if (outer is Map) {
      final inner = outer['data'];
      if (inner is Map) return Map<String, dynamic>.from(inner);
      if (outer['url'] != null || outer['sessionId'] != null) {
        return Map<String, dynamic>.from(outer);
      }
    }

    if (response is Map &&
        (response['url'] != null || response['sessionId'] != null)) {
      return Map<String, dynamic>.from(response);
    }

    return null;
  }

  static Map<String, dynamic> _buildBookingItem({
    required int serviceId,
    required DateTime bookingDate,
    required TimeSlotEnum timeSlot,
    required int durationMinutes,
    ApiBookingType bookingType = ApiBookingType.primary,
  }) {
    return <String, dynamic>{
      'bookingDate': _formatBookingDate(bookingDate),
      'bookingType': bookingType.apiValue,
      'duration': durationMinutes,
      'serviceId': serviceId,
      'timeSlot': timeSlot.apiValue,
    };
  }

  static int? _resolveServiceId(ServiceRoutingArgument args) {
    final fromRoute = int.tryParse(args.providerServiceId?.trim() ?? '');
    if (fromRoute != null) return fromRoute;

    final service = args.service;
    if (service != null) {
      for (final key in ['id', 'providerServiceId', 'serviceId']) {
        final value = service[key];
        if (value is int) return value;
        final parsed = int.tryParse(value?.toString() ?? '');
        if (parsed != null) return parsed;
      }
    }

    return args.serviceId;
  }

  static String _formatBookingDate(DateTime date) {
    final y = date.year;
    final m = date.month.toString().padLeft(2, '0');
    final d = date.day.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }
}
