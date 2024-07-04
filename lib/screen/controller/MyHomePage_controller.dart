import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../model/AppDataModel.dart';
import '../../network/api_path.dart';

class MyHomePageController extends GetxController {
  DataModel? dataModel;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  void fetchData() async {
    try {
      isLoading(true);
      var response = await Dio().get('${ApiPath.baseUrl}app_details',
          options: Options(headers: {'Token': "JZzG5NPNnOCRS5lO"}));
      print("${response.data} ===================");
      if (response.statusCode == 200) {
        if (response.data["code"] == "100") {
          dataModel = DataModel.fromJson(response.data["data"]);

          update();
        } else {
          Get.snackbar('Api has erorr ', response.data['message']);
          isLoading(false);
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
