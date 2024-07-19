import 'dart:convert';

import 'package:get/get.dart';

import 'package:dio/src/form_data.dart' as alfrom;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../network/api_path.dart';
import '../../../network/network_config.dart';
import '../../../network/storage_repository.dart';
import '../../../utilis/app_constant.dart';
import 'package:flutter/material.dart';

import 'package:dio/dio.dart';

class PinController extends GetxController {
  final TextEditingController setpinController = TextEditingController();
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  final Dio dio = Dio();

  Future<void> loginWithPin() async {
    final tokenpin = await StorageRepository.getTokenpin();
    final token = await StorageRepository.getToken();
    print("Token pin: $tokenpin");
    print("Token pin: $token");
    if (tokenpin == null) {
      Get.snackbar('Error', 'Token not found',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    isLoading.value = true;

    final formData = alfrom.FormData.fromMap({
      'pin': setpinController.text,
    });

    try {
      final response = await dio.post(
        'https://development.smapidev.co.in/api/Api/login_pin',
        data: formData,
        options: Options(
          headers: {'Token': tokenpin},
        ),
      );

      isLoading.value = false;

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.data);

        if (responseData['status'] == 'success') {
          await _handleSuccessResponse(responseData);
        } else {
          _handleErrorResponse(responseData);
        }
      } else {
        Get.snackbar(
            'Error', 'Token is not here, failed: ${response.statusMessage}',
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', 'Request failed: $e',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> _handleSuccessResponse(Map<String, dynamic> responseData) async {
    await StorageRepository.destroyOfflineStorageOne(AppConstant.tokenKey);

    final newToken = responseData['data']['token'];
    await Future.delayed(const Duration(seconds: 2));
    await StorageRepository.saveOffline(AppConstant.tokenKey, newToken);
    await StorageRepository.saveOffline(AppConstant.tokenKeypin, newToken);
    print("New Token: $newToken");

    Get.offAllNamed("/home");
    Get.snackbar('Success', 'Verify successful',
        snackPosition: SnackPosition.BOTTOM);
  }

  void _handleErrorResponse(Map<String, dynamic> responseData) {
    if (responseData['code'] == "505") {
      Get.offAllNamed("/login");
    }

    Get.snackbar('Error', 'Verify failed: ${responseData['message']}',
        snackPosition: SnackPosition.BOTTOM);
  }

  void validatePin(String pin) {
    if (pin.length != 4) {
      errorMessage.value = 'PIN must be 4 digits';
    } else {
      errorMessage.value = '';
    }
  }
}
