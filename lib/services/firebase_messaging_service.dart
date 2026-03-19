import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ezhandy_user/services/app_notification_data.dart';
import 'package:ezhandy_user/utils/constant.dart';

class FirebaseMessagingService {
  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  AppNotificationData? appNotificationData;
  AndroidNotificationChannel? androidNotificationchannel;
  static FirebaseMessagingService? _messagingService;

  static FirebaseMessaging? _firebaseMessaging;

  FirebaseMessagingService._createInstance();

  factory FirebaseMessagingService() {
    // factory with constructor, return some value
    if (_messagingService == null) {
      _messagingService = FirebaseMessagingService._createInstance(); // This is executed only once, singleton object

      _firebaseMessaging = _getMessagingService();
    }
    return _messagingService!;
  }

  static FirebaseMessaging _getMessagingService() {
    return _firebaseMessaging ??= FirebaseMessaging.instance;
  }

  Future<String?> getToken() async {
    try {
      return await _firebaseMessaging!.getToken();
    } catch (error) {
      return null;
    }
  }

  Future initializeNotificationSettings() async {
    if (Platform.isAndroid) {
      if (await Permission.notification.isDenied) {
        await Permission.notification.request();
      }
    }

    NotificationSettings settings = await _firebaseMessaging!.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else {
      print('User declined or has not accepted permission');
    }

    AndroidNotificationChannel channel = AndroidNotificationChannel(
      'chat', // id
      'High Importance Notifications', // title
      // 'This channel is used for important notifications.', // description
      importance: Importance.max,
    );
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    //
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  //This will execute when the app is open and in foreground
  void foregroundNotification() {
    print('Got a message whilst in the foreground!');
    //
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');
      // print('Message request id: ${message.data["request_id"]}');
      //AppDialogs.showToast(message: "Data on foreground");
      appNotificationData = AppNotificationData();
      appNotificationData!.foregroundNotificationData(context: Constants.navigatorKey.currentContext, notificationData: message);
    });
    // StaticData.notificationForegroundListenerEnable = true;
  }

  //This will excute when the app is in background but not killed and tap on that notification
  void backgroundTapNotification() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      RemoteMessage? terminatedMessage = await _firebaseMessaging!.getInitialMessage();
      print('Got a message whilst in the background!');
      print('Messaged:${terminatedMessage?.data}');
      // print('Message data: ${message.data}');
      // print("Current Data Time:${DateTime.now()}");
      // AppDialogs.showToast(
      //     message: "Data on background but not killed:${message.sentTime}");
      appNotificationData = AppNotificationData();
      appNotificationData!.backgroundNotificationData(context: Constants.navigatorKey.currentContext, notificationData: message.data);
    });
  }

  //This will work when the app is killed and notification comes and tap on that notification
  void terminateTapNotification() async {
    RemoteMessage? terminatedMessage = await _firebaseMessaging!.getInitialMessage();
    print('Got a message whilst in the terminate!');
    print('Message:${terminatedMessage?.data}');
    //print("Terminated message notification:"+terminatedMessage.notification.title.toString());
    // AppDialogs.showToast(
    //     message: "Data on term
    //     ?inated background");

    if (terminatedMessage != null) {
      //When there is no notification error is beacuse of firebase messaging plugin
      if (terminatedMessage.notification != null) {
        //print("Terminated message:${terminatedMessage.data.toString()}");
        // AppDialogs.showToast(
        //     message: "Data on terminated background when notification tap${terminatedMessage
        //         .data} Notification Time${terminatedMessage.notification}");

        appNotificationData = AppNotificationData();
        appNotificationData?.terminateNotificationData(
          context: Constants.navigatorKey.currentContext,
          notificationData: terminatedMessage.data,
        );
      }
    }
  }

// Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//     print("data available ha");
// }
}

class StaticData {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static bool notificationForegroundListenerEnable = false;
  static bool notificationBackgroundListenerEnable = false;
}
