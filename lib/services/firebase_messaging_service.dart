import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:ezhandy_user/utils/constant.dart';
import 'package:permission_handler/permission_handler.dart';
import 'app_notification_data.dart';

class FirebaseMessagingService {
  static final FirebaseMessagingService _instance =
      FirebaseMessagingService._internal();

  factory FirebaseMessagingService() => _instance;
  FirebaseMessagingService._internal();

  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;

  /// Notification channel IDs
  static const String channelSoundVibrate = 'chat_sound_vibrate';
  static const String channelSoundNoVibrate = 'chat_sound_no_vibrate';
  static const String channelGentleSoundVibrate = 'chat_gentle_sound_vibrate';
  static const String channelGentleSoundNoVibrate =
      'chat_gentle_sound_no_vibrate';
  static const String channelVibrateNoSound = 'chat_vibrate_no_sound';
  static const String channelNoSoundNoVibrate = 'chat_no_sound_no_vibrate';

  /// Initialize service
  Future<void> init() async {
    await _requestPermission();
    await _initializeLocalNotifications();
    await _createNotificationChannels();
    _listenForeground();
    _listenBackgroundTap();
    _listenTerminated();
  }

  /// Request notification permissions
  Future<void> _requestPermission() async {
    if (Platform.isAndroid) {
      if (await Permission.notification.isDenied) {
        await Permission.notification.request();
      }
    }
    await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  /// Initialize FlutterLocalNotificationsPlugin
 Future<void> _initializeLocalNotifications() async {
  const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');

  const darwinInit = DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );

  const initSettings = InitializationSettings(
    android: androidInit,
    iOS: darwinInit, // 🔥 REQUIRED for iOS
  );

  await _localNotifications.initialize(
    initSettings,
    onDidReceiveNotificationResponse: (response) {
      if (response.payload != null) {
        AppNotificationData().backgroundNotificationData(
          context: Constants.navigatorKey.currentContext,
          notificationData: jsonDecode(response.payload!),
        );
      }
    },
  );
}


  /// Create all notification channels
  Future<void> _createNotificationChannels() async {
    final android = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    var vibrationPattern = Int64List.fromList([0, 500, 300, 700]);
    const defaultSound = 'my_sound';

    // Sound + Vibration
    await android?.createNotificationChannel(
      AndroidNotificationChannel(
        channelSoundVibrate,
        'Sound & Vibration',
        description: 'Notifications with sound and vibration',
        importance: Importance.max,
        playSound: true,
        // sound: RawResourceAndroidNotificationSound(defaultSound),
        enableVibration: true,
        vibrationPattern: vibrationPattern,
      ),
    );

    // Sound only
    await android?.createNotificationChannel(
      const AndroidNotificationChannel(
        channelSoundNoVibrate,
        'Sound Only',
        description: 'Notifications with sound but no vibration',
        importance: Importance.high,
        playSound: true,
        // sound: RawResourceAndroidNotificationSound(defaultSound),
        enableVibration: false,
      ),
    );
    // Gentle Sound + Vibration
    await android?.createNotificationChannel(
      AndroidNotificationChannel(
        channelGentleSoundVibrate,
        'Gentle Sound & Vibration',
        description: 'Notifications with Gentle sound and vibration',
        importance: Importance.max,
        playSound: true,
        sound: RawResourceAndroidNotificationSound(defaultSound),
        enableVibration: true,
        vibrationPattern: vibrationPattern,
      ),
    );

    // Gentle Sound only
    await android?.createNotificationChannel(
      const AndroidNotificationChannel(
        channelGentleSoundNoVibrate,
        'Gentle Sound Only',
        description: 'Notifications with Gentle sound but no vibration',
        importance: Importance.high,
        playSound: true,
        sound: RawResourceAndroidNotificationSound(defaultSound),
        enableVibration: false,
      ),
    );

    // Vibration only
    await android?.createNotificationChannel(
      AndroidNotificationChannel(
        channelVibrateNoSound,
        'Vibration Only',
        description: 'Notifications with vibration but no sound',
        importance: Importance.high,
        playSound: false,
        enableVibration: true,
        vibrationPattern: vibrationPattern,
      ),
    );

    // No sound, no vibration
    await android?.createNotificationChannel(
      const AndroidNotificationChannel(
        channelNoSoundNoVibrate,
        'Silent',
        description: 'Notifications with no sound and no vibration',
        importance: Importance.low,
        playSound: false,
        enableVibration: false,
      ),
    );
  }

  /// Foreground notification listener
  void _listenForeground() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      await showNotification(message.data, message: message);
      AppNotificationData().foregroundNotificationData(
        context: Constants.navigatorKey.currentContext,
        notificationData: message,
      );
    });
  }

  /// Background tap handler
  void _listenBackgroundTap() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      AppNotificationData().backgroundNotificationData(
        context: Constants.navigatorKey.currentContext,
        notificationData: message.data,
      );
    });
  }

  /// Handle app launch from terminated state
  void _listenTerminated() async {
    RemoteMessage? message = await _firebaseMessaging.getInitialMessage();
    if (message != null) {
      AppNotificationData().terminateNotificationData(
        context: Constants.navigatorKey.currentContext,
        notificationData: message.data,
      );
    }
  }

  /// Get FCM token
  Future<String?> getToken() async {
    return await _firebaseMessaging.getToken();
  }

  /// Show notification with dynamic channel selection & optional gentle chime
  Future<void> showNotification(Map<String, dynamic> data,
      {RemoteMessage? message}) async {
    final isVibrationEnabled = data["isVibrationEnabled"]?.toString() == "true";
    final isSoundEnabled = data["isSoundEnabled"]?.toString() == "true";
    final isGentleChime = data["isGentleChime"]?.toString() == "true";

    // Determine sound to play
    final soundName = (isSoundEnabled && isGentleChime) ? 'my_sound' : null;

    // Select correct channel
    String channelId;
    if (isSoundEnabled && isGentleChime && isVibrationEnabled) {
      channelId = channelGentleSoundVibrate;
    } else if (isSoundEnabled && isGentleChime && !isVibrationEnabled) {
      channelId = channelGentleSoundNoVibrate;
    }

    /// 🔊 Normal Sound cases
    else if (isSoundEnabled && !isGentleChime && isVibrationEnabled) {
      channelId = channelSoundVibrate;
    } else if (isSoundEnabled && !isGentleChime && !isVibrationEnabled) {
      channelId = channelSoundNoVibrate;
    }

    /// 📳 Vibration only
    else if (!isSoundEnabled && isVibrationEnabled) {
      channelId = channelVibrateNoSound;
    }

    /// 🔕 Default fallback (no sound, no vibration)
    else {
      channelId = channelNoSoundNoVibrate;
    }

    final androidDetails = AndroidNotificationDetails(
      channelId,
      'High Importance Notifications',
      importance: Importance.max,
      priority: Priority.high,
      enableVibration: isVibrationEnabled,
      vibrationPattern:
          isVibrationEnabled ? Int64List.fromList([0, 500, 300, 700]) : null,
      playSound: isSoundEnabled,
      sound: soundName != null
          ? RawResourceAndroidNotificationSound(soundName)
          : null,
    );

    final iosDetails = DarwinNotificationDetails(
  presentAlert: true,
  presentBadge: true,
  presentSound: isSoundEnabled,
);

final details = NotificationDetails(
  android: androidDetails,
  iOS: iosDetails,
);

    await _localNotifications.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      data['title'] ?? message?.notification?.title ?? 'Notification',
      data['body'] ?? message?.notification?.body ?? '',
      details,
      payload: jsonEncode(data),
    );
  }
}

/// Background handler
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  final service = FirebaseMessagingService();
  await service.showNotification(message.data, message: message);
}
