import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:dio/src/form_data.dart' as alfrom;
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../../../network/api_path.dart';
import '../../../network/storage_repository.dart';

class MakeBiteController extends GetxController {
  var allData;
  RxInt selectedValue = 0.obs;
  var bids = <Map<String, String>>[].obs; // Add this to manage bids
  var isLoading = false.obs;
  final Dio _dio = Dio();

 RxString? selectedDigit = ''.obs; // Initialize selectedDigit
  MakeBiteController(this.allData);

  @override
  void onInit() {
    print('==================${allData.id}');
    super.onInit();
  }

  void addBid(Map<String, String> bid) {
    bids.add(bid);
    update();
  }


  void deleteBid(int index) {
    bids.removeAt(index);
    update();
  }

  Future<void> fetchWinStatement() async {
    isLoading(true);
    try {
      final token = await StorageRepository.getToken();

      final formData = alfrom.FormData.fromMap({
        "game_bids": json.encode({
          "bids": bids,
        }),
      });
      final response = await _dio.post(
        '${ApiPath.baseUrl}place_bid',
        data: formData,
        options: Options(headers: {'Token': token}),
      );

      print(response.data);
      var jsonResponse = jsonDecode(response.data); // Decode the JSON response

      if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
    Get.snackbar( jsonResponse['message'], "");
      
        Get.offAll('/home');
        update();
      } else {
        if (jsonResponse["code"] == "400") {
          Get.snackbar( jsonResponse['message'], "Some Thing Went Wrong");
        }
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
