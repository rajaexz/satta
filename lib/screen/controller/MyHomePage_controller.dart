import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../model/AppDataModel.dart';
import '../../network/api_path.dart';
import '../../network/storage_repository.dart';

class MyHomePageController extends GetxController {
  DataModel? dataModel;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

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
