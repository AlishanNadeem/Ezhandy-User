import 'dart:developer';
import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:ezhandy_user/module/auth/controller/auth_controller.dart';
import 'package:ezhandy_user/module/core/controller/home_controller.dart';
import 'package:ezhandy_user/services/firebase_messaging_service.dart';
import 'package:ezhandy_user/utils/routes/app_router.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/utils/app_size.dart';
import 'package:ezhandy_user/utils/app_strings.dart';
import 'package:ezhandy_user/utils/constant.dart';
import 'package:ezhandy_user/utils/keyboard_dismiss_overser.dart';
import 'package:ezhandy_user/utils/routes/app_router.dart';
import 'package:ezhandy_user/utils/scroll_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

@pragma("vm:entry-point")
Future<void> handleBackgroundMessage(RemoteMessage message) async {
  await Firebase.initializeApp();
  log("Background Title: ${message.notification?.title}");
  log("Background Body: ${message.notification?.body}");
  log("Background Data: ${message.data}");
  log("Background: ${message.toString()}");
  log("Background: ${message.notification.toString()}");
}

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  //  Stripe.publishableKey = AppConstant.STRIPE_KEY;
  await Firebase.initializeApp(); // 🔥 Register background handler
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  // 🔥 Initialize notification service
  await FirebaseMessagingService().init();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      // Set the color of the enter key

      // systemNavigationBarColor:
      //     AppColors.gradient_3, // Change this color to whatever you want
      ));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  final AuthController auth_controller = Get.put(AuthController());
  final HomeController core_controller = Get.put(HomeController());

  MyApp({super.key});
  static const MaterialColor customColor = MaterialColor(
    0xFFC52D83,
    <int, Color>{
      50: Color(0xFFFFE3EC),
      100: Color(0xFFFFB3CF),
      200: Color(0xFFFF80AF),
      300: Color(0xFFFF4D8F),
      400: Color(0xFFFF2676),
      500: Color(0xFFC52D83),
      600: Color(0xFFB82878),
      700: Color(0xFFA22468),
      800: Color(0xFF8C1F58),
      900: Color(0xFF6C1740),
    },
  );
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize:
            const Size(AppSize.fullScreenWidth, AppSize.fullScreenHeight),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          final botToastBuilder = BotToastInit();
          return GetMaterialApp(
            title: AppStrings.appTitle,
            debugShowCheckedModeBanner: false,
            // home: MainMenu(
            //   selectedTab: 0,
            // ),
            // initialRoute: "/",
            // getPages: AppPages.routes,
            onGenerateRoute: AppRouter.onGenerateRoute,

            theme: ThemeData(
                useMaterial3: false,
                // primaryColor: Colors.blue, // Set your primary color here
                // scaffoldBackgroundColor: Colors.white,
                scaffoldBackgroundColor: AppColors.black,
                fontFamily: AppStrings.montserrat,
                primarySwatch: customColor,
                unselectedWidgetColor: AppColors.transparent,
                colorScheme: ColorScheme.fromSwatch()
                    .copyWith(primary: AppColors.orange)),
            navigatorObservers: [
              KeyboardDismissObserver(),
              BotToastNavigatorObserver()
            ],
            navigatorKey: Constants.navigatorKey,
            builder: (context, child) {
              child = botToastBuilder(context, child);
              return ScrollConfiguration(
                  behavior: MyScrollBehavior(),
                  child: MediaQuery(
                      data: MediaQuery.of(context)
                          .copyWith(textScaler: TextScaler.linear(1.0)),
                      child: child));
            },
          );
        });
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
