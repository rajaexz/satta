import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as con;
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import '../../../model/BitStatement.dart';
import '../../../model/winStatement.dart';
import '../../../network/api_path.dart';
import '../../../network/storage_repository.dart';

class WinHestoryController extends con.GetxController {
  var isLoading = false.obs;
  final Dio _dio = Dio();

  List<GameWin> wingames = [];

  @override
  void onInit() {
    fetchWinStatement();
    super.onInit();
  }

  Future<void> fetchWinStatement() async {
    isLoading(true);
    try {
      final token = await StorageRepository.getToken();
      print(token);

      final response = await _dio.get(
        '${ApiPath.baseUrl}bid_history', // Replace with your actual API URL

        options: Options(headers: {'Token': "JZzG5NPNnOCRS5lO"}),
      );

      print("${response.data} ===========================");
      var jsonResponse = jsonDecode(response.data); // Decode the JSON response
      if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
        for (var item in jsonResponse['data']) {
          wingames.add(GameWin.fromJson(item));
        }
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
}
