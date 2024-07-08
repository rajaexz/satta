import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';

import '../../../network/api_path.dart';
import '../../../network/storage_repository.dart';
import 'package:get/get.dart' as con;

class TransferController extends con.GetxController {
  var isLoading = false.obs;
  var userName = ''.obs;
  var pointsController = TextEditingController();
  var userNumberController = TextEditingController();

  final Dio _dio = Dio();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  var verifyName;

  Future<void> transferVerify(Map<String, dynamic> data) async {
    isLoading(true);
    try {
      final token = await StorageRepository.getToken();
      print(token);

      final response = await _dio.post(
        '${ApiPath.baseUrl}transfer_verify', // Replace with your actual API URL
        data: FormData.fromMap(data),
        options: Options(headers: {'Token': "JZzG5NPNnOCRS5lO"}),
      );

      print("${response.data} ===========================");
      var jsonResponse = jsonDecode(response.data); // Decode the JSON response

      if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
        Get.snackbar('Your Transfer is Verify', jsonResponse['message']);

        userName.value = jsonResponse["data"]["name"];
        update();
      } else {
        Get.snackbar('Something went wrong', jsonResponse['message']);
      }
    } catch (e) {
      // Handle error
      print(e);
    } finally {
      isLoading(false);
    }
  }

  Future<void> transferPoints(Map<String, dynamic> data) async {
    isLoading(true);
    try {
      final token = await StorageRepository.getToken();
      print(token);

      final response = await _dio.post(
        '${ApiPath.baseUrl}transfer_points', // Replace with your actual API URL
        data: FormData.fromMap(data),
        options: Options(headers: {'Token': "JZzG5NPNnOCRS5lO"}),
      );

      var jsonResponse = jsonDecode(response.data); // Decode the JSON response

      if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
        Get.snackbar('Successful', jsonResponse['message']);

        update();
      } else {
        // Handle error

        Get.snackbar('Something went wrong', jsonResponse['message']);
      }
    } catch (e) {
      // Handle error
      print(e);
    } finally {
      isLoading(false);
    }
  }
}
