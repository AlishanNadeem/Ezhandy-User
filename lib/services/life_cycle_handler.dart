// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class LifecycleHandler extends StatefulWidget {
//   final Widget child;

//   const LifecycleHandler({super.key, required this.child});

//   @override
//   State<LifecycleHandler> createState() => _LifecycleHandlerState();
// }

// class _LifecycleHandlerState extends State<LifecycleHandler>
//     with WidgetsBindingObserver {
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);
//   }

//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     super.dispose();
//   }

//   // Called when the app changes state
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (state == AppLifecycleState.detached ||
//         state == AppLifecycleState.inactive ||
//         state == AppLifecycleState.paused) {
//       // App is exiting or going into background
//       _hitExitAPI();
//     }
//   }

//   Future<void> _hitExitAPI() async {
//     try {
//       log("api hit");
//       final response = await http.post(
//         Uri.parse('https://your-api.com/on-exit'),
//         body: {'status': 'user exited'},
//       );
//       log('Exit API called: ${response.statusCode}');
//     } catch (e) {
//       log('Error calling exit API: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return widget.child;
//   }
// }
