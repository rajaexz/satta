import 'dart:convert';

import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:dio/src/form_data.dart' as alfrom;
import 'package:html/parser.dart';
import '../../../network/api_path.dart';
import '../../../network/storage_repository.dart';
import '../../../utilis/app_constant.dart';
import '../pinset.dart';

class CreatePinController extends GetxController {
  var isLoading = false.obs;
  final Dio dio = Dio();

  Future<void> CreateWithPin(
    otp,
    pin,
  ) async {
    final phone = await StorageRepository.getOfflineKey(AppConstant.phone);
    final tokenpin = await StorageRepository.getTokenpin();
    final getTokenpinCreate = await StorageRepository.getTokenpinCreate();
    isLoading.value = true;
    print("${getTokenpinCreate} =============${otp} ==========${phone}");
    final formData = alfrom.FormData.fromMap({
      'mobile': phone,
      'pin': "$pin",
    });

    try {
      final response = await dio.post(
        'https://development.smapidev.co.in/api/Api/create_pin',
        data: formData,
        options: Options(
          headers: {'Token': getTokenpinCreate},
        ),
      );

      isLoading.value = false;

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.data);

        if (responseData['status'] == 'success') {
          final newToken = responseData['data']['token'];
          await StorageRepository.saveOffline(AppConstant.tokenKey, newToken);
          Get.snackbar('Success', responseData['message']);
          isLoading.value = false;
          // Get.offAllNamed("/home");
        } else {
          Get.offAllNamed("/login");
          Get.snackbar('Error', ' failed: ${responseData['message']}',
              snackPosition: SnackPosition.BOTTOM);
        }
      } else {
        Get.snackbar(
            'Error', 'Token is not here, failed: ${response.statusMessage}',
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', 'Request failed: $e',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
  // Future<void> CreateWithPin(int pin, String number) async {
  //   isLoading.value = true;
  //   final dio = Dio();
  //   final getcreatepin = await StorageRepository.getcreatepin();
  //   final token = await StorageRepository.getToken();
  //   print("==============${getcreatepin}");

  //   final phone = await StorageRepository.getOfflineKey(AppConstant.phone);

  //   final formData = alfrom.FormData.fromMap({
  //     'mobile': number,
  //     'pin': pin,
  //   });

  //   try {
  //     final response = await dio.post(
  //       'https://development.smapidev.co.in/api/Api/create_pin',
  //       data: formData,
  //       options: Options(
  //         headers: {
  //           'Token': token,
  //         },
  //       ),
  //     );

  //     var badydecode = jsonDecode(response.data);

  //     if (badydecode["code"] != "400") {
  //       // final newToken = badydecode['data']['token'];
  //       // await StorageRepository.saveOffline(AppConstant.tokenKey, newToken);
  //       Get.snackbar('Success', badydecode['message']);
  //       isLoading.value = false;
  //       // Get.offAllNamed("/home");
  //     } else {
  //       // Get.offAllNamed("/login");
  //       Get.snackbar('Error', ' failed: ${badydecode['message']}',
  //           snackPosition: SnackPosition.BOTTOM);
  //     }
  //     isLoading.value = false;
  //   } catch (e) {
  //     isLoading.value = false;
  //     print('Login failedsere: $e');
  //     Get.snackbar('Error', 'Login failed: $e',
  //         snackPosition: SnackPosition.BOTTOM);
  //   }
  // }
}
