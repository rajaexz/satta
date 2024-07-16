import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';

import '../../../model/usedetail.dart';
import '../../../model/userStatus.dart';
import '../../../network/api_path.dart';
import '../../../network/storage_repository.dart';
import 'package:get/get.dart' as con;

class WithdrowController extends con.GetxController {
  TextEditingController amountController = TextEditingController();
  @override
  void onInit() {
    super.onInit();
    fetchUserDetails();
  }

  var isLoading = false.obs;
  final Dio _dio = Dio();

  var userDetails = UserStatusResponse(
    message: '',
    code: '',
    status: '',
    data: Data(
      maximumBidAmount: '',
      availablePoints: '',
      maximumDeposit: '',
      maximumTransfer: '',
      maximumWithdraw: '',
      transfer: '',
      minimumTransfer: '',
      upiName: '',
      upiPaymentId: '',
      minimumBidAmount: '',
      minimumDeposit: '',
      minimumWithdraw: '',
    ),
  ).obs;

  void fetchUserDetails() async {
    isLoading(true);
    try {
      final token = await StorageRepository.getToken();

      print(token);
      final response = await _dio.get(
        '${ApiPath.baseUrl}user_status', // Replace with your actual API URL
        options: Options(headers: {'Token': token}),
      );
      print(response.data);
      if (response.statusCode == 200) {
        var jsonResponse =
            jsonDecode(response.data); // Decode the JSON response
        userDetails(UserStatusResponse.fromJson(jsonResponse));
      } else {
        // Handle error
        Get.snackbar('Error', 'Failed to fetch user details');
      }
    } catch (e) {
      // Handle error
      print(e);
      Get.snackbar('Error', 'Failed to fetch user details');
    } finally {
      isLoading(false);
    }
  }

  Future<void> withdrawFund(Map<String, dynamic> data) async {
    isLoading(true);
    try {
      final token = await StorageRepository.getToken();

      final response = await _dio.post(
        '${ApiPath.baseUrl}withdraw', // Replace with your actual API URL
        data: FormData.fromMap(data),
        options: Options(headers: {'Token': '$token'}),
      );

      print("${response.data} ===========================");
      var jsonResponse = jsonDecode(response.data); // Decode the JSON response

      if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
        Get.snackbar('Successful', "Your transaction is complete");
        update();
        Get.toNamed("/home", arguments: "id");
      } else {
        Get.snackbar(
            'Error', jsonResponse['message'] ?? "Some Thing Went Wrong");
      }
    } catch (e) {
      // Handle error
      print(e);
      Get.snackbar('Error', 'Failed to process withdrawal');
    } finally {
      isLoading(false);
    }
  }
}
