import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../../network/api_path.dart';

class PaytmentSreenController extends GetxController {
  final Dio _dio = Dio(BaseOptions(
    baseUrl:
        '${ApiPath.baseUrl}starline_game', // Replace with your API base URL
    headers: {
      'Token': 'JZzG5NPNnOCRS5lO',
    },
  ));
  @override
  void onInit() {
    // TODO: implement onInit

    super.onInit();
  }

  void updatePaytm(String phone) async {
    try {
      final response = await _dio.post(
        '${ApiPath.baseUrl}/update_paytm',
        data: {
          'paytm': phone,
        },
      );
      if (response.data['status'] == 'success') {
        Get.showSnackbar(GetBar(
          message: response.data['message'],
          duration: Duration(seconds: 2),
        ));
      } else {
        Get.showSnackbar(GetBar(
          message: 'Failed to update Paytm details',
          duration: Duration(seconds: 2),
        ));
      }
    } catch (e) {
      Get.showSnackbar(GetBar(
        message: 'An error occurred',
        duration: Duration(seconds: 2),
      ));
    }
  }

  void updategPay(String phone) async {
    try {
      final response = await _dio.post(
        '${ApiPath.baseUrl}/update_gpay',
        data: {
          'paytm': phone,
        },
      );
      if (response.data['status'] == 'success') {
        Get.showSnackbar(GetBar(
          message: response.data['message'],
          duration: Duration(seconds: 2),
        ));
      } else {
        Get.showSnackbar(GetBar(
          message: 'Failed to update Paytm details',
          duration: Duration(seconds: 2),
        ));
      }
    } catch (e) {
      Get.showSnackbar(GetBar(
        message: 'An error occurred',
        duration: Duration(seconds: 2),
      ));
    }
  }
}
