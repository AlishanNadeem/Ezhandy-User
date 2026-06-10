import 'package:ezhandy_user/dio_client/dio_client.dart';
import 'package:ezhandy_user/utils/listeners.dart';
import 'package:ezhandy_user/utils/network_strings.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  final RxList<Map<String, dynamic>> notifications =
      <Map<String, dynamic>>[].obs;
  final RxBool isLoading = false.obs;
  final Rxn<String> markingReadId = Rxn<String>();
  final RxString readFilter = 'All'.obs;

  static const readFilterOptions = ['All', 'Read', 'Unread'];

  List<Map<String, dynamic>> get filteredNotifications {
    final list = notifications;
    switch (readFilter.value) {
      case 'Read':
        return list.where(isNotificationRead).toList();
      case 'Unread':
        return list.where((n) => !isNotificationRead(n)).toList();
      default:
        return List<Map<String, dynamic>>.from(list);
    }
  }

  static bool isNotificationRead(Map<String, dynamic> notification) {
    final value = notification['isRead'];
    if (value == true || value == 1) return true;
    return value?.toString().toLowerCase() == 'true';
  }

  void updateReadFilter(String value) => readFilter.value = value;

  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
  }

  Future<void> fetchNotifications() async {
    isLoading.value = true;
    try {
      final response = await DioClient().getRequest(
        endPoint: NetworkStrings.notificationsEndpoint,
        isHeaderRequire: true,
        isLoader: false,
      );

      await DioClient().validateResponse(
        response: response,
        responseListener: CallbackResponseListener(
          onSuccessCallback: (res) {
            final raw = res is Map ? res['data'] : null;
            if (raw is List) {
              notifications.assignAll(
                raw
                    .whereType<Map>()
                    .map((e) => Map<String, dynamic>.from(e))
                    .where((n) => n['isDeleted'] != true)
                    .toList(),
              );
            } else {
              notifications.clear();
            }
          },
          onFailureCallback: (_) => notifications.clear(),
        ),
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> markAsRead(String notificationId) async {
    final id = notificationId.trim();
    if (id.isEmpty || markingReadId.value != null) return;

    markingReadId.value = id;
    var success = false;

    try {
      final response = await DioClient().patchRequest(
        endPoint: NetworkStrings.notificationRead(id),
        isHeaderRequire: true,
        isLoader: false,
      );

      await DioClient().validateResponse(
        response: response,
        responseListener: CallbackResponseListener(
          onSuccessCallback: (_) => success = true,
          onFailureCallback: (_) => success = false,
        ),
      );

      if (success) {
        await fetchNotifications();
      }
    } finally {
      markingReadId.value = null;
    }
  }
}
