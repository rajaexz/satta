import 'dart:convert';

import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:dio/src/form_data.dart' as alfrom;
import '../../../network/api_path.dart';
import '../../../network/storage_repository.dart';
import '../../../utilis/app_constant.dart';

class CreatePinController extends GetxController {
  var isLoading = false.obs;
  final Dio dio = Dio();
  Future<void> CreateWithPin(int pin, String number) async {
    isLoading.value = true;
    final dio = Dio();
    final tokenpin = await StorageRepository.getTokenpin();
    final phone = await StorageRepository.getOfflineKey(AppConstant.phone);

    final formData = alfrom.FormData.fromMap({
      'mobile': phone,
      'pin': pin,
    });

    try {
      final response = await dio.post(
        'https://development.smapidev.co.in/api/Api/create_pin',
        data: formData,
        options: Options(
          headers: {
            'Token': tokenpin,
          },
        ),
      );

      var badydecode = jsonDecode(response.data);

      if (badydecode["code"] != "400") {
        final newToken = badydecode['data']['token'];
        await StorageRepository.saveOffline(AppConstant.tokenKey, newToken);
        Get.snackbar('Success', badydecode['message']);
        Get.offAllNamed("/home");
      } else {
        Get.offAllNamed("/login");
        Get.snackbar('Error', ' failed: ${badydecode['message']}',
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      isLoading.value = false;
      print('Login failedsere: $e');
      Get.snackbar('Error', 'Login failed: $e',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
