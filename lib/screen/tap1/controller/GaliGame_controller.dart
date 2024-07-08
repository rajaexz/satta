import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as con;
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:winner11/model/GaliGame.dart';

import '../../../model/BitStatement.dart';
import '../../../model/StarlineGame.dart';
import '../../../network/api_path.dart';
import '../../../network/storage_repository.dart';

class GaliGameController extends con.GetxController {
  var isLoading = false.obs;
  var starlineResponse = GaliDisawarResponse(
    message: '',
    code: '',
    status: '',
    galiDisawarChart: '',
    galiDisawarRates: [],
    galiDisawarGames: [],
  ).obs;

  final Dio _dio = Dio();

  @override
  void onInit() {
    fetchBitStatement();
    super.onInit();
  }

  Future<void> fetchBitStatement() async {
    isLoading(true);
    try {
      final token = await StorageRepository.getToken();
      print("Token: $token");


      final response = await _dio.get(
        '${ApiPath.baseUrl}gali_disawar_game', // Replace with your actual API URL
        options: Options(headers: {'Token': token}),
      );
      print("Response Data: ${response.data}");

      var jsonResponse = jsonDecode(response.data); // Decode the JSON response
      print("JSON Response: $jsonResponse");

      if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
        starlineResponse.value =
            GaliDisawarResponse.fromJson(jsonResponse['data']);
        print("Parsed Response: ${starlineResponse.value}");
        update();
      } else {
        Get.snackbar('Failed to fetch data', jsonResponse['message']);
      }
    } catch (e) {
      // Handle error
      print("Error: $e");
      Get.snackbar('Failed to fetch data', e.toString());
    } finally {
      isLoading(false);
    }
  }
}
