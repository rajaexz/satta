import 'dart:convert';
import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:winner11/screen/component/custom_toaster.dart';
import 'package:winner11/screen/component/trancetionId.dart';
import 'package:winner11/screen/wallet/addmoney.dart';
import 'package:winner11/service/authapi.dart';
import 'package:get/get.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:http/http.dart' as http;

class ValueController extends GetxController {
  RxInt maoney = 0.obs;

  Future<void> changeValue(int newValue, context) async {
    maoney.value = newValue;
    try {
      final store = await SharedPreferences.getInstance();
      final id = store.getString("userId");

      // Simulate adding money to the user's account
      final ApiService apiService = ApiService();
      var data = await apiService.userallType(data: {
        "id": id,
        "trans_id": generateOrderId(),
        "money": valueController.maoney.toString(),
        "payment_status": "success"
      }, uri: "/add_money");

      print(data["data"]);
      if (data["data"]["error"] == "true") {
        // ignore: use_build_context_synchronously
        CustomToaster.showWarning(context, " ${data["data"]["message"]}");
      } else {
        CustomToaster.showSuccess(
            context, "Successfully ${data["data"]["message"]} ");
      }
    } catch (e) {
      // Handle exceptions and show an error toast message
      CustomToaster.showWarning(context, "Something Wrong ");
    }
  }

  String generateOrderId() {
    const String chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final Random random = Random();
    String orderId = '';
    for (int i = 0; i < 10; i++) {
      orderId += chars[random.nextInt(chars.length)];
    }
    return orderId;
  }

  Future<dynamic> checkStatus({orderId}) async {

   
    final String baseUrl =
        "http://sky11live.com/nodeserver/checkStatusTapPay.php"; // Set the base URL for the API

// Your request data
    var data = {
      'order_id': orderId,
    };
var  response = await http.post(
      Uri.parse(baseUrl),
      body: data,
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response, then parse the JSON.
      return jsonDecode(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load status');
    }
  }



}

// noti_controller.dart

class NotiController extends GetxController {
  // ignore: non_constant_identifier_names
  RxInt noti_number = 0.obs;
  // ignore: non_constant_identifier_names
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
