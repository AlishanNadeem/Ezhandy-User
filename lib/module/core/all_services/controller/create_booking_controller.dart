import 'package:ezhandy_user/dio_client/dio_client.dart';
import 'package:ezhandy_user/module/core/all_services/routing_arguments/service_routing_arguments.dart';
import 'package:ezhandy_user/utils/api_enums.dart';
import 'package:ezhandy_user/utils/listeners.dart';
import 'package:ezhandy_user/utils/network_strings.dart';
import 'package:get/get.dart';

class CreateBookingController extends GetxController {
  final RxBool isSubmitting = false.obs;

  Future<bool> createBookingAndPay({
    required ServiceRoutingArgument args,
    required int durationMinutes,
  }) async {
    if (isSubmitting.value) return false;

    final serviceId = _resolveServiceId(args);
    final bookingDate = args.selectedDate;
    final timeSlot = args.selectedTimeSlot;

    if (serviceId == null) return false;
    if (bookingDate == null) return false;
    if (timeSlot == null) return false;
    if (durationMinutes <= 0) return false;

    isSubmitting.value = true;
    var success = false;

    try {
      final response = await DioClient().postRequest(
        endPoint: NetworkStrings.createBookingAndPayEndpoint,
        data: <String, dynamic>{
          'bookings': [
            _buildBookingItem(
              serviceId: serviceId,
              bookingDate: bookingDate,
              timeSlot: timeSlot,
              durationMinutes: durationMinutes,
            ),
          ],
          'paymentMethodId': 1,
          'currency': 'usd',
          'token': 'manual-payment-reference-123',
          'stripePaymentMethodId': 'pm_manual_123',
          'stripePaymentIntentId': 'pi_manual_123',
          'returnUrl': NetworkStrings.bookingPaymentReturnUrl,
          'platform': 2,
        },
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
    } finally {
      isSubmitting.value = false;
    }

    return success;
  }

  static Map<String, dynamic> _buildBookingItem({
    required int serviceId,
    required DateTime bookingDate,
    required TimeSlotEnum timeSlot,
    required int durationMinutes,
  }) {
    return <String, dynamic>{
      'bookingDate': _formatBookingDate(bookingDate),
      'bookingType': ApiBookingType.primary.apiValue,
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
