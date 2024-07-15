import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dart:convert';

import 'package:winner11/model/mainGame.dart';


import '../../../network/api_path.dart';
import '../../../network/storage_repository.dart';

import '../../../model/AppDataModel.dart';
class GameBidController extends GetxController {
  var isLoading = false.obs;
  final Dio _dio = Dio();

  final List<GameList> bids = [];

  @override
  void onInit() {
    fetchWinStatement();
    fetchData();
    super.onInit();
  }
    DataModel? dataModel;
 
 void fetchData() async {
    final token = await StorageRepository.getToken();
    try {
      isLoading(true);
      var response = await Dio().get('${ApiPath.baseUrl}app_details',
          options: Options(headers: {'Token': token}));

      if (response.statusCode == 200) {
        var badydecode = jsonDecode(response.data);
        if (badydecode["code"] == "100" && token!= null) {
          dataModel = DataModel.fromJson(badydecode["data"]);
          isLoading(false);
          update();
        } else {
          Get.snackbar('Api has erorr ', badydecode['message']);
          isLoading(false);
          Get.offAllNamed("/login");
          update();
        }
      } else {
        Get.snackbar('Api has erorr ', response.data['message']);
        isLoading(false);
        update();
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
      isLoading(false);
      update();
    }
  }
  Future<void> fetchWinStatement() async {
    isLoading(true);
    try {
      final token = await StorageRepository.getToken();
      print(token);

      final response = await _dio.get(
        '${ApiPath.baseUrl}main_game_list', // Replace with your actual API URL

        options: Options(headers: {'Token': token}),
      );
      var jsonResponse = jsonDecode(response.data); // Decode the JSON response
      if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
        for (var item in jsonResponse['data']) {
          bids.add(GameList.fromJson(item));
        }
        update();
      } else {
           Get.snackbar('Something went wrong ', "Incomplete");
       
    
      }
    } catch (e) {
      // Handle error
      print(e);
    } finally {
      isLoading(false);
    }
  }
}
