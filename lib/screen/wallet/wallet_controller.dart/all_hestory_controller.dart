import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as con;
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import '../../../model/WithdrawStatement.dart';
import '../../../network/api_path.dart';
import '../../../network/storage_repository.dart';

class AllHestoryController extends con.GetxController{

    var isLoading = false.obs;
    final Dio _dio = Dio();
      var withdrawData = Rxn<WithdrawData>();
  @override
  void onInit() {
   fetchWithdrawStatement();
    super.onInit();
  
  }


  
  Future<void> fetchWithdrawStatement() async {
    isLoading(true);
    try {
      final token = await StorageRepository.getToken();
      print(token);

      final response = await _dio.get(
        '${ApiPath.baseUrl}withdraw_statement', // Replace with your actual API URL
       
        options: Options(headers: {'Token': token}),
      );

      print("${response.data} ===========================");
      var jsonResponse = jsonDecode(response.data); // Decode the JSON response
 if (response.statusCode == 200 && jsonResponse ['status'] == 'success') {


      withdrawData.value = WithdrawData.fromJson(jsonResponse['data']);
  update();
    } else {
        Get.showSnackbar(const GetSnackBar(
          title: "Something went wrong",
          message: "incomplete",
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