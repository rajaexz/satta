import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/src/form_data.dart' as alfrom;
import 'package:Billa/screen/auth/forget.dart';
import '../../../network/api_path.dart';
import '../../../network/storage_repository.dart';
import '../../../utilis/app_constant.dart';
import 'package:dio/dio.dart';

import '../otpsrceenPin.dart';

class ForgetPinController extends GetxController {
  TextEditingController phoneController = TextEditingController();
  var isLoading = false.obs;
  final Dio dio = Dio();

  Future<void> forgetWithPin(number) async {
    isLoading.value = true;
    final dio = Dio();
    final formData = alfrom.FormData.fromMap({
      'mobile': number,
    });
    try {
      final response = await dio.post(
        'https://development.smapidev.co.in/api/Api/forgot_pin',
        data: formData,
      );

      var jsonResponse = jsonDecode(response.data); // Decode the JSON response

      if (jsonResponse['status'] == 'success') {
        Get.snackbar('Success', jsonResponse['message']);

        Get.to(OtpPagePin());
      } else if (jsonResponse['code'] == "505") {
        Get.toNamed('/login');
        Get.snackbar('Error', jsonResponse['message']);
      } else {
        Get.snackbar('Error', jsonResponse['message']);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to authenticate');
    } finally {
      isLoading.value = false;
    }
  }
}
