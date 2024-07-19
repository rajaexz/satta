import 'dart:convert';

import 'package:get/get.dart';

import 'package:dio/src/form_data.dart' as alfrom;
import '../../../network/api_path.dart';
import '../../../network/network_config.dart';
import '../../../network/storage_repository.dart';
import '../../../utilis/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

class PinController extends GetxController {
  final TextEditingController setpinController = TextEditingController();
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  final Dio dio = Dio();
  Future<void> loginWithPin() async {
    final tokenpin = await StorageRepository.getTokenpin();
print("--------------------${tokenpin}");

    isLoading.value = true;
    final dio = Dio();

    final formData = alfrom.FormData.fromMap({
      'pin': setpinController.text,
    });
 


    final response =
        await dio.post('https://development.smapidev.co.in/api/Api/login_pin',
            data: formData,
            options: Options(
              headers: {
                'Token': tokenpin,
              },
            ));

    isLoading.value = false;
    if (response.statusCode == 200 ) {
      final responseData = jsonDecode(response.data);
      if (responseData['status'] == 'success') {
        final newToken = responseData['data']['token'];

    
        await StorageRepository.saveOffline(AppConstant.tokenKey, newToken);

        Get.offAllNamed("/home");
        Get.snackbar('Success', 'Verify successful',
            snackPosition: SnackPosition.BOTTOM);
        // You can handle storing token or navigating to the next screen after verification
      } else {
      
  
        Get.snackbar('Error', 'Verify failed: ${responseData['message']}',
            snackPosition: SnackPosition.BOTTOM);
      }
    } else {
    
      Get.snackbar(
          'Error', 'token is not here  failed: ${response.statusMessage}',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void validatePin(String pin) {
    if (pin.length != 4) {
      errorMessage.value = 'PIN must be 4 digits';
    } else {
      errorMessage.value = '';
    }
  }
}
