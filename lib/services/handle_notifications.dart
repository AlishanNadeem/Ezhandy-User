// import 'dart:convert';
// import 'dart:developer';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:get/get.dart';

// const AndroidNotificationChannel channel = AndroidNotificationChannel(
//   'my_channel', // id
//   'My Channel', // title
//   importance: Importance.high,
// );

// class HandlePushNotifications {
//   HandlePushNotifications(this.context);
//   BuildContext context;


//   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   void listenAndHandle() {
//     setupLocalNotification();
//     setupInteractedMessage();
//   }

//   setupLocalNotification() async {
//     flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

//     ///android initialization
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('ic_stat_notification_icon');

//     ///ios initialization
//     final IOSInitializationSettings initializationSettingsIOS =
//         IOSInitializationSettings(
//       requestAlertPermission: true,
//           onDidReceiveLocalNotification: onDidReceiveLocalNotification,
//       requestBadgePermission: false,
//       requestSoundPermission: false,
//     );

//     ///macOs initialization
//     const MacOSInitializationSettings initializationSettingsMacOS =
//         MacOSInitializationSettings(
//       requestAlertPermission: false,
//       requestBadgePermission: false,
//       requestSoundPermission: false,
//     );

//     ///combining all initializations in a variable of "initializationSettings"
//     final InitializationSettings initializationSettings =
//         InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: initializationSettingsIOS,
//       macOS: initializationSettingsMacOS,
//     );

//     ///initializing local notification with all the "initializationSettings"
//     await flutterLocalNotificationsPlugin.initialize(initializationSettings,
//         onSelectNotification: (String? payload) async {
//       // Get.to(MyOrderPage());
//     });
//   }


//   Future<void> setupInteractedMessage() async {
//     RemoteMessage? initialMessage =
//         await FirebaseMessaging.instance.getInitialMessage();

//     if (initialMessage != null) {
//       _handleMessage(initialMessage);
//     }

//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       log(message.data.toString());
//       RemoteNotification? notification = message.notification;
//       AndroidNotification? android = message.notification?.android;
//       if (notification != null && android != null) {
//         flutterLocalNotificationsPlugin.show(
//           notification.hashCode,
//           notification.title,
//           notification.body,
//           NotificationDetails(
//             android: AndroidNotificationDetails(
//               channel.id,
//               channel.name,
//               icon: 'ic_stat_notification_icon',
//             ),
//           ),
//         );
//       }
//     });

//     FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
//   }


//   void _handleMessage(RemoteMessage message) {
//     ///navigate accordingly
//     // Get.to(MyOrderPage());
//   }

//   void onDidReceiveLocalNotification(
//       int id, String? title, String? body, String? payload) async {
//     // display a dialog with the notification details, tap ok to go to another page
//     showDialog(
//       context: context,
//       builder: (BuildContext context) => CupertinoAlertDialog(
//         title: Text(title!),
//         content: Text(body!),
//         actions: [
//           CupertinoDialogAction(
//             isDefaultAction: true,
//             child: Text('Ok'),
//             onPressed: () async {
//               Navigator.of(context, rootNavigator: true).pop();
//               // await Navigator.push(
//               //   context,
//               //   MaterialPageRoute(
//               //     builder: (context) => MyOrderPage(),
//               //   ),
//               // );
//             },
//           )
//         ],
//       ),
//     );
//   }
// }
