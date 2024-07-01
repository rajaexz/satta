
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as con;
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';

import '../../../model/BitStatement.dart';
import '../../../model/StarlineGame.dart';
import '../../../network/api_path.dart';
import '../../../network/storage_repository.dart';


class StarlineGameController extends con.GetxController{
var isLoading = false.obs;
  var starlineResponse = StarlineResponse(
    message: '',
    code: '',
    status: '',
    starlineChart: '',
    starlineRates: [],
    starlineGames: [],
  ).obs;

  final Dio _dio = Dio();

  Future<void> fetchBitStatement() async {
    isLoading(true);
    try {
      final token = await StorageRepository.getToken();
      print(token);

      final response = await _dio.get(
        '${ApiPath.baseUrl}starline_game', // Replace with your actual API URL
        options: Options(headers: {'Token': "JZzG5NPNnOCRS5lO"}),
      );

      print("${response.data} ===========================");
      var jsonResponse = jsonDecode(response.data); // Decode the JSON response

      if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
        starlineResponse.value = StarlineResponse.fromJson(jsonResponse['data']);
      } else {
        Get.showSnackbar(const GetSnackBar(
          title: "Something went wrong",
          message: "incomplete",
          backgroundColor: Colors.red,
          animationDuration: Duration(seconds: 2),
        ));
      }
    } catch (e) {
      // Handle error
      print(e);
      Get.showSnackbar(const GetSnackBar(
        title: "Error",
        message: "Failed to fetch data",
        backgroundColor: Colors.red,
        animationDuration: Duration(seconds: 2),
      ));
    } finally {
      isLoading(false);
    }
  }
}