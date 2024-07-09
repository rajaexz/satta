import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart' as con;
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../../../model/winStatement.dart';
import '../../../network/api_path.dart';
import '../../../network/storage_repository.dart';

class WinHestoryController extends GetxController {
  final RxBool isLoading = false.obs;
  final Dio _dio = Dio();
  final RxList<GameWin> wingames = <GameWin>[].obs;

  @override
  void onInit() {
    fetchWinStatement();
    super.onInit();
  }

  Future<void> fetchWinStatement() async {
    try {
      isLoading.value = true;
      final token = await StorageRepository.getToken();

      final response = await _dio.get(
        '${ApiPath.baseUrl}/win_history',
        options: Options(headers: {'Token': "${token}"}),
      );
      print("=================${response.data}");
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.data);

        if (jsonResponse['status'] == 'success') {
          final List<dynamic> dataList = jsonResponse['data'];
          wingames.assignAll(
              dataList.map((data) => GameWin.fromJson(data)).toList());

          update();
        } else {
          Get.snackbar('Error', jsonResponse['message']);
        }
      } else {
        Get.snackbar('Error', 'Failed to fetch data');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
