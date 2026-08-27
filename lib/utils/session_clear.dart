import 'package:ezhandy_user/module/auth/AppUser/model/app_user.dart';
import 'package:ezhandy_user/module/auth/controller/auth_controller.dart';
import 'package:ezhandy_user/module/core/home/controller/home_controller.dart';
import 'package:ezhandy_user/module/core/notification/controller/notification_controller.dart';
import 'package:ezhandy_user/utils/shared_preference.dart';
import 'package:get/get.dart';

/// Clears session prefs and in-memory API/controller cache after logout.
class SessionClear {
  SessionClear._();

  /// [clearAllPrefs] true clears entire SharedPreferences (e.g. delete account).
  /// false clears only auth token/user (logout) and keeps remember-me credentials.
  static Future<void> clearApiCaches({bool clearAllPrefs = false}) async {
    final prefs = SharedPreference();
    await prefs.sharedPreference;
    if (clearAllPrefs) {
      prefs.clear();
    } else {
      prefs.clearSessionOnly();
    }

    // Drops all non-permanent GetX controllers that hold API lists/cache.
    // Auth / Home / Notification stay (registered permanent in main.dart).
    Get.deleteAll();

    if (Get.isRegistered<AuthController>()) {
      AuthController.i.appUser.value = AppUser();
    }

    if (Get.isRegistered<HomeController>()) {
      HomeController.i.selectedTab.value = 0;
      HomeController.i.servicesList.clear();
      HomeController.i.isLoading.value = false;
    }

    if (Get.isRegistered<NotificationController>()) {
      NotificationController.i.clearCache();
    }
  }
}
