import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../model/AppDataModel.dart';
import '../../../network/api_path.dart';
import '../../../network/storage_repository.dart';

class NotificationController extends GetxController {

    DataModel? dataModel;
  void onInit() {
    readNotification();
    fetchData();
    super.onInit();
  }

  Future<void> readNotification() async {
       final token = await StorageRepository.getTokenpin();
    final response = await GetConnect().post(
      '${ApiPath.baseUrl}read_notification',
      {"readnoti": true},
      headers: {"Token": token},
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


    var isLoading = true.obs;
  void fetchData() async {
    
    final tokenpin = await StorageRepository.getTokenpin();
    try {
      isLoading(true);
      var response = await Dio().get('${ApiPath.baseUrl}app_details',
          options: Options(headers: {'Token':tokenpin}));
  

      if (response.statusCode == 200) {
        var badydecode = jsonDecode(response.data);
        if (badydecode["code"] == "100" && tokenpin != null) {
          dataModel = DataModel.fromJson(badydecode["data"]);
          isLoading(false);
          update();
        } else {
          Get.snackbar('Api has erorr ', badydecode['message']);
          isLoading(false);
              Get.offAllNamed("/login");
          update();
        }
      } else {
        Get.snackbar('Api has erorr ', response.data['message']);
        isLoading(false);
        update();
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
      isLoading(false);
      update();
    }
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
