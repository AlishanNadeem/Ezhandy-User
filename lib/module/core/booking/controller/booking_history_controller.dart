import 'package:ezhandy_user/dio_client/dio_client.dart';
import 'package:ezhandy_user/module/core/booking/model/user_booking_model.dart';
import 'package:ezhandy_user/utils/listeners.dart';
import 'package:ezhandy_user/utils/network_strings.dart';
import 'package:get/get.dart';

class BookingHistoryController extends GetxController {
  final RxList<UserBooking> bookings = <UserBooking>[].obs;
  final RxBool isLoading = false.obs;
  final RxString searchQuery = ''.obs;

  List<UserBooking> get filteredBookings {
    final q = searchQuery.value.trim().toLowerCase();
    if (q.isEmpty) return bookings;
    return bookings.where((b) {
      return b.bookingId.toString().contains(q) ||
          b.serviceName.toLowerCase().contains(q) ||
          b.providerName.toLowerCase().contains(q) ||
          b.statusLabel.toLowerCase().contains(q);
    }).toList();
  }

  @override
  void onInit() {
    super.onInit();
    fetchUserBookings();
  }

  Future<void> fetchUserBookings() async {
    isLoading.value = true;
    try {
      final response = await DioClient().getRequest(
        endPoint: NetworkStrings.userBookingsEndpoint,
        isHeaderRequire: true,
      );

      await DioClient().validateResponse(
        response: response,
        responseListener: CallbackResponseListener(
          onSuccessCallback: (res) {
            final raw = res is Map ? res['data'] : null;
            if (raw is List) {
              bookings.assignAll(
                raw
                    .map(
                      (e) => UserBooking.fromJson(
                        Map<String, dynamic>.from(e as Map),
                      ),
                    )
                    .toList(),
              );
            } else {
              bookings.clear();
            }
          },
          onFailureCallback: (_) => bookings.clear(),
        ),
      );
    } finally {
      isLoading.value = false;
    }
  }

  void updateSearch(String value) => searchQuery.value = value;
}
