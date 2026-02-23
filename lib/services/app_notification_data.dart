import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:ezhandy_user/utils/constant.dart';

class AppNotificationData {
  // Foreground notifications
  void foregroundNotificationData({
    required BuildContext? context,
    required dynamic notificationData,
  }) {
    log("Foreground Notification: ${notificationData.data}");
    // Parse your notificationData and navigate if needed
  }

  // Background (notification tap)
  void backgroundNotificationData({
    required BuildContext? context,
    required Map<String, dynamic> notificationData,
  }) {
    log("Background Notification: ${notificationData.toString()}");
    // Parse your notificationData and navigate if needed
  }

  // Terminated (app launch)
  void terminateNotificationData({
    required BuildContext? context,
    required Map<String, dynamic> notificationData,
  }) {
    log("Terminated Notification: ${notificationData.toString()}");
    // Parse your notificationData and navigate if needed
  }
}
