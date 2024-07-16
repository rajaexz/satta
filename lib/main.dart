import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:Billa/firebase_options.dart';
import 'package:Billa/routes/allRoutes.dart';
import 'package:Billa/service/authapi.dart';
import 'package:Billa/utilis/AllColor.dart';

import 'screen/component/darkmode.dart';

final ThemeController themeController = Get.put(ThemeController());
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  String? _firebaseToken = await FirebaseMessaging.instance.getToken();
  print("FCM______:${_firebaseToken}");

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  _fcmConfigure();
  runApp(MyApp());
}

_fcmConfigure() {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    Get.snackbar(message.notification?.title ?? "No Title",
        message.notification?.body ?? "No body",
        snackPosition: SnackPosition.TOP,
        backgroundColor:
            themeController.isLightMode.value ? myColorWhite : myColor);
  });

  // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //   print("onLaunch: $message");
  //   Get.snackbar(message.notification?.title ?? "No Title",
  //       message.notification?.body ?? "No body",
  //       snackPosition: SnackPosition.TOP,
  //       backgroundColor:
  //           themeController.isLightMode.value ? myColorWhite : myColor);
  // });
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling background message: $message");
  // Perform tasks based on the incoming FCM message when the app is in the background.
}

class MyApp extends StatefulWidget {
  @override
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ThemeController themeController = Get.put(ThemeController());

  void initState() {
    super.initState();
  }

  var current_noti_number;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GetMaterialApp(
        themeMode: themeController.currentThemeMode.value,
        theme: themeController.currentThemeData,
        initialRoute: '/splash',
        debugShowCheckedModeBanner: false,
        getPages: allRutes,
        title: 'Billa',
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: const TextScaler.linear(1)),
            child: child!,
          );
        },
      ),
    );
  }
}
