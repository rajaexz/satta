import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dart:convert';

import 'package:winner11/model/mainGame.dart';

import '../../../network/api_path.dart';
import '../../../network/storage_repository.dart';

class GameBidController extends GetxController {
  var isLoading = false.obs;
  final Dio _dio = Dio();

  final List<GameList> bids = [];

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
        '${ApiPath.baseUrl}main_game_list', // Replace with your actual API URL

        options: Options(headers: {'Token': "JZzG5NPNnOCRS5lO"}),
      );

      print("${response.data} ===========================");
      var jsonResponse = jsonDecode(response.data); // Decode the JSON response
      if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
        for (var item in jsonResponse['data']) {
          bids.add(GameList.fromJson(item));
        }
        update();
      } else {
        Get.snackbar(
          "Something went wrong", // Title
          "Incomplete", // Message
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
          snackPosition: SnackPosition.BOTTOM, // Position of the Snackbar
          borderRadius: 10, // BorderRadius.circular(10)
          margin: EdgeInsets.all(10), // Margin around the Snackbar
          animationDuration:
              Duration(milliseconds: 200), // Duration of animation
          // You can customize further properties as needed
        );
      }
    } catch (e) {
      // Handle error
      print(e);
    } finally {
      isLoading(false);
    }
  }
}
