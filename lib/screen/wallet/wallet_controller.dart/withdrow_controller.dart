import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';


import '../../../network/api_path.dart';
import '../../../network/storage_repository.dart';
import 'package:get/get.dart' as con;
class  WithdrowController extends  con.GetxController{
  
  TextEditingController amountController = TextEditingController();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
  var isLoading = false.obs;
    final Dio _dio = Dio();
  Future<void> withdrawFund(Map<String, dynamic> data) async {
    isLoading(true);
    try {
      final token = await StorageRepository.getToken();
      print(token);

      final response = await _dio.post(
        '${ApiPath.baseUrl}withdraw', // Replace with your actual API URL
        data: FormData.fromMap(data),
        options: Options(headers: {'Token': token}),
      );

      print("${response.data} ===========================");
      var jsonResponse = jsonDecode(response.data); // Decode the JSON response

      if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
        Get.showSnackbar(const GetSnackBar(
          title: "Successful",
          message: "Your transaction is complete",
          backgroundColor: Colors.green,
          animationDuration:Duration(seconds: 2),
        ));

          update();
        Get.toNamed("/home", arguments: "id");
      } else {
        // Handle error
        Get.showSnackbar(const GetSnackBar(
          title: "Something went wrong",
          message: "Your transaction is incomplete",
          backgroundColor: Colors.red,
            animationDuration:Duration(seconds: 2),
        ));
      }
    } catch (e) {
      // Handle error
      print(e);
    } finally {
      isLoading(false);
    }
  }

}