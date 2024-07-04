import 'package:get/get.dart';

import '../../../network/api_path.dart';

class NotificationController extends GetxController {
  var notifications = <Notification>[].obs; // List to store notifications
  void onInit() {
    readNotification();
    super.onInit();
  }

  Future<void> readNotification() async {
    final response = await GetConnect().post(
      '${ApiPath.baseUrl}read_notification',
      {"readnoti": true},
      headers: {"Token": "JZzG5NPNnOCRS5lO"},
    );
    print("-------------${response.body}");

    // if (response.statusCode == 200) {
    //   var notification = Notification(
    //     message: response.body['message'],
    //     code: response.body['code'],
    //     status: response.body['status'],
    //   );
    //   notifications.add(notification); // Add new notification to the list
    // } else {
    //   // Handle error
    // }
  }
}

// Model class for Notification
class Notification {
  String message;
  String code;
  String status;

  Notification(
      {required this.message, required this.code, required this.status});
}
