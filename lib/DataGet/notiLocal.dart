import 'package:winner11/service/authapi.dart';
import 'package:get/get.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class ValueController extends GetxController {
  RxInt maoney = 0.obs;

  void changeValue(int newValue) {
    maoney.value = newValue;
  }
}

// noti_controller.dart

class NotiController extends GetxController {
  RxInt noti_number = 0.obs;
  RxInt current_noti_number = 0.obs; // Add this line

  RxBool hasNewNotification = false.obs;
  RxBool hasViewedAllNotifications = true.obs;
  final ApiService apiService = ApiService();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void onInit() {
    super.onInit();
    initializeNotifications();

  }

  void initializeNotifications() {
    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings('@mipmap/ic_launcher'));

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void showNotification(String title, String body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      channelDescription: 'your_channel_description',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );

    final NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: 'item x',
    );

    hasNewNotification.value = true;
    hasViewedAllNotifications.value = false;
    update();
  }


  void updateNotificationCount(List<dynamic> result) {
    noti_number.value = (result.isNotEmpty) ? result.length : 0;

    hasNewNotification.value = false;
    hasViewedAllNotifications.value = true;
    update();


  }

  void markAllNotificationsAsRead() {
    hasViewedAllNotifications.value = true;
    update();
  }
}