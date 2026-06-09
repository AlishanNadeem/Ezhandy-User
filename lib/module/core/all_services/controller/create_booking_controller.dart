import 'package:ezhandy_user/dio_client/dio_client.dart';
import 'package:ezhandy_user/module/core/all_services/routing_arguments/service_routing_arguments.dart';
import 'package:ezhandy_user/utils/api_enums.dart';
import 'package:ezhandy_user/utils/listeners.dart';
import 'package:ezhandy_user/utils/network_strings.dart';
import 'package:get/get.dart';

class CreateBookingController extends GetxController {
  final RxBool isSubmitting = false.obs;

  Future<String?> startBookingDraftCheckout({
    required ServiceRoutingArgument args,
    required int durationMinutes,
    required double totalAmount,
  }) async {
    if (isSubmitting.value) return null;

    final serviceId = _resolveServiceId(args);
    final bookingDate = args.selectedDate;
    final timeSlot = args.selectedTimeSlot;

    if (serviceId == null) return null;
    if (bookingDate == null) return null;
    if (timeSlot == null) return null;
    if (durationMinutes <= 0) return null;

    isSubmitting.value = true;
    String? checkoutUrl;

    try {
      final response = await DioClient().postRequest(
        endPoint: NetworkStrings.createBookingDraftCheckoutEndpoint,
        data: <String, dynamic>{
          'bookings': [
            _buildBookingItem(
              serviceId: serviceId,
              bookingDate: bookingDate,
              timeSlot: timeSlot,
              durationMinutes: durationMinutes,
              totalAmount: totalAmount,
            ),
          ],
          'currency': 'usd',
          'successUrl': NetworkStrings.bookingCheckoutSuccessUrl,
          'cancelUrl': NetworkStrings.bookingCheckoutCancelUrl,
        },
        isHeaderRequire: true,
      );

      await DioClient().validateResponse(
        response: response,
        responseListener: CallbackResponseListener(
          onSuccessCallback: (res) {
            checkoutUrl = _extractCheckoutUrl(res);
          },
          onFailureCallback: (_) => checkoutUrl = null,
        ),
        message: true,
      );
    } finally {
      isSubmitting.value = false;
    }

    return checkoutUrl;
  }

  static Map<String, dynamic> _buildBookingItem({
    required int serviceId,
    required DateTime bookingDate,
    required TimeSlotEnum timeSlot,
    required int durationMinutes,
    required double totalAmount,
  }) {
    return <String, dynamic>{
      'bookingDate': _formatBookingDate(bookingDate),
      'bookingType': ApiBookingType.primary.apiValue,
      'duration': durationMinutes,
      'serviceId': serviceId,
      'timeSlot': timeSlot.apiValue,
      'totalAmount': _formatTotalAmount(totalAmount),
    };
  }

  static String? _extractCheckoutUrl(dynamic response) {
    dynamic payload = response;
    if (payload is Map && payload['data'] != null) {
      payload = payload['data'];
    }
    if (payload is Map && payload['data'] != null) {
      payload = payload['data'];
    }
    if (payload is! Map) return null;

    final map = payload is Map<String, dynamic>
        ? payload
        : Map<String, dynamic>.from(payload);

    for (final key in ['url', 'checkoutUrl', 'sessionUrl']) {
      final value = map[key];
      if (value is String && value.trim().isNotEmpty) {
        return value.trim();
      }
    }
    return null;
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

  static num _formatTotalAmount(double amount) {
    if (amount == amount.roundToDouble()) {
      return amount.round();
    }
    return double.parse(amount.toStringAsFixed(2));
  }
}
