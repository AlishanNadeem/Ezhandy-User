import 'package:ezhandy_user/dio_client/dio_client.dart';
import 'package:ezhandy_user/module/core/booking/routing_arguments/booking_routing_arguments.dart';
import 'package:ezhandy_user/module/core/chat/routing_arguments/chat_routing_arguments.dart';
import 'package:ezhandy_user/utils/listeners.dart';
import 'package:ezhandy_user/utils/network_strings.dart';
import 'package:ezhandy_user/utils/routes/app_navigation.dart';
import 'package:ezhandy_user/utils/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  static NotificationController get i {
    if (!Get.isRegistered<NotificationController>()) {
      Get.put(NotificationController(), permanent: true);
    }
    return Get.find<NotificationController>();
  }

  final RxList<Map<String, dynamic>> notifications =
      <Map<String, dynamic>>[].obs;
  final RxInt unreadCount = 0.obs;
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

  void clearCache() {
    notifications.clear();
    unreadCount.value = 0;
    readFilter.value = 'All';
    isLoading.value = false;
    markingReadId.value = null;
  }

  @override
  void onInit() {
    super.onInit();
    // Loaded after auth from MainMenu / NotificationScreen.
  }

  Future<void> fetchUnreadCount() async {
    final response = await DioClient().getRequest(
      endPoint: NetworkStrings.notificationsUnreadCountEndpoint,
      isHeaderRequire: true,
      isLoader: false,
    );

    await DioClient().validateResponse(
      response: response,
      responseListener: CallbackResponseListener(
        onSuccessCallback: (res) {
          unreadCount.value = _parseUnreadCount(res);
        },
        onFailureCallback: (_) {},
      ),
    );
  }

  int _parseUnreadCount(dynamic res) {
    if (res is! Map) return 0;
    final data = res['data'];
    if (data is int) return data;
    if (data is num) return data.toInt();
    if (data is String) return int.tryParse(data) ?? 0;
    if (data is Map) {
      final raw = data['count'] ?? data['unreadCount'] ?? data['unread'];
      if (raw is int) return raw;
      if (raw is num) return raw.toInt();
      return int.tryParse(raw?.toString() ?? '') ?? 0;
    }
    return int.tryParse(data?.toString() ?? '') ?? 0;
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
      await fetchUnreadCount();
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

  /// Marks read, then navigates by notification [type].
  Future<void> onNotificationTap(
    BuildContext context,
    Map<String, dynamic> notification,
  ) async {
    final notificationId = notification['id']?.toString() ?? '';
    if (notificationId.isNotEmpty && !isNotificationRead(notification)) {
      await markAsRead(notificationId);
    }

    if (!context.mounted) return;

    final type = (notification['type']?.toString() ?? '').toUpperCase();

    if (type.contains('BOOKING')) {
      final bookingId = _bookingIdFromNotification(notification);
      if (bookingId == null || bookingId <= 0) return;

      AppNavigation.navigateTo(
        context,
        AppRoutes.bookingScreenRoute,
        arguments: BookingRoutingArgument(
          bookingId: bookingId,
          Status: '',
        ),
      );
      return;
    }

    if (type.contains('CHAT')) {
      final chatId = _chatIdFromNotification(notification);
      if (chatId == null || chatId.isEmpty) return;

      AppNavigation.navigateTo(
        context,
        AppRoutes.chatScreenRoute,
        arguments: ChatRoutingArgument(
          isBooking: false,
          chatId: chatId,
        ),
      );
      return;
    }

    if (type.contains('COMMUNITY')) {
      AppNavigation.navigateTo(context, AppRoutes.myPostsScreenRoute);
    }
  }

  int? _bookingIdFromNotification(Map<String, dynamic> notification) {
    final data = notification['data'];
    dynamic raw;
    if (data is Map) {
      raw = data['bookingId'];
    } else {
      raw = notification['bookingId'];
    }
    if (raw == null) return null;
    if (raw is int) return raw;
    return int.tryParse(raw.toString());
  }

  String? _chatIdFromNotification(Map<String, dynamic> notification) {
    final data = notification['data'];
    dynamic raw;
    if (data is Map) {
      raw = data['chatId'];
    } else {
      raw = notification['chatId'];
    }
    final id = raw?.toString().trim();
    if (id == null || id.isEmpty) return null;
    return id;
  }
}
