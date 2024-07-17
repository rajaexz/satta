import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/src/form_data.dart' as alfrom;
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../../../network/api_path.dart';
import '../../../network/storage_repository.dart';

class MakeBiteController extends GetxController {
  var allData;
  var whicGameName;
  var gameType;
  final TextEditingController pointController = TextEditingController();
  RxInt selectedValue = 0.obs;
  var bids = <Map<String, String>>[].obs; // Add this to manage bids
  var isLoading = false.obs;
  final Dio _dio = Dio();

  RxString? selectedDigit = ''.obs; // Initialize selectedDigit
  
  MakeBiteController({this.allData, this.whicGameName, this.gameType});

  @override
  void onInit() {
    super.onInit();
  }

  void deleteBid(int index) {
    bids.removeAt(index);
    update();
  }
  void addBid() {
    // Check if the required fields are not empty
       update();
    if ( pointController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter the points.');
      return;
    }

    if (selectedDigit!.value.isEmpty) {
      Get.snackbar('Error', 'Please select a digit.');
      return;
    }
 bids.add({
          "game_id": allData.id.toString(),
          "game_type": gameType.toString(),
          "session": selectedValue.value == 0 ? "Open" : "Close",
          "bid_points": pointController.text,
          "open_digit": selectedDigit!.value.toString(),
          "close_digit": "",
          "open_panna": "",
          "close_panna": ""
        });
    // If validation passes, add the bid

    // Clear the input fields after adding the bid
   selectedDigit!.value = "";
    pointController.clear();

    update();
  }

  fetchWinStatement({required String gameName}) async {
    print('=========sfdgsfdgdsfgdfsgsfg=========${bids}');
    isLoading(true);
    try {
      final token = await StorageRepository.getToken();

      final formData = alfrom.FormData.fromMap({
        "game_bids": json.encode({
          "bids": bids,
        }),
      });

      // Determine the URL based on the gameName
      String url;
      switch (gameName) {
        case 'gali_disawar':
          url = '${ApiPath.baseUrl}gali_disawar_place_bid';
          break;
        case 'star_line':
          url = '${ApiPath.baseUrl}starline_place_bid';
          break;
        case 'main_game':
          url = '${ApiPath.baseUrl}place_bid';
          break;
        default:
          url = '${ApiPath.baseUrl}place_bid';
          break;
      }

      final response = await _dio.post(
        url,
        data: formData,
        options: Options(headers: {'Token': token}),
      );

      var jsonResponse = jsonDecode(response.data); // Decode the JSON response
      if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
        Get.snackbar(jsonResponse['message'], jsonResponse['message']);
        Get.toNamed('/home');
        update();
      } else {
        Get.snackbar(jsonResponse['message'], jsonResponse['message']);
      }
    } catch (e) {
      // Handle error
      print(e);
      Get.snackbar('Error', "An error occurred: $e");
    } finally {
      isLoading(false);
    }
  }
}
