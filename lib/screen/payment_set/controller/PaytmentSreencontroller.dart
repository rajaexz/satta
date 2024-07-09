import 'dart:convert';

import 'package:dio/src/form_data.dart' as alfrom;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:winner11/model/usedetail.dart';

import '../../../network/api_path.dart';
import '../../../network/storage_repository.dart';

// class PaytmentSreenController extends GetxController {
//   var isLoading = false.obs;

//   Dio? _dio;

//   @override
//   Future<void> onInit() async {
//     // TODO: implement onInit
//     fetchUserDetails();
//     super.onInit();
//   }

//   //////////////////////////////////
//   ///
//   ///
//   ///

//   var userDetails = UserDetails(
//     message: '',
//     code: '',
//     status: '',
//     data: UserData(
//       username: '',
//       mobile: '',
//       email: '',
//       bankName: '',
//       accountHolderName: '',
//       ifscCode: '',
//       branchAddress: '',
//       bankAccountNo: '',
//       paytmMobileNo: '',
//       phonepeMobileNo: '',
//       gpayMobileNo: '',
//       pendingNoti: '',
//     ),
//   ).obs;

//   void fetchUserDetails() async {
//     isLoading(true);
//     try {
//       final token = await StorageRepository.getToken();

//       final response = await _dio!.get(
//         '${ApiPath.baseUrl}get_user_details', // Replace with your actual API URL
//         options: Options(headers: {'Token': token}),
//       );
//       print(response.data);
//       if (response.statusCode == 200) {
//         var jsonResponse =
//             jsonDecode(response.data!); // Decode the JSON response
//         userDetails(UserDetails.fromJson(jsonResponse));
//       } else {
//         // Handle error
//       }
//     } catch (e) {
//       // Handle error
//       print(e);
//     } finally {
//       isLoading(false);
//     }
//   }

//   ///
//   ///
//   ///////////////////////////////////////

//   void updatePaytm(String phone) async {
//     print("----------------");

//     final formData = alfrom.FormData.fromMap({
//       'paytm': phone,
//     });
//     var token = await StorageRepository.getToken();

//     final response = await _dio.post(
//       '${ApiPath.baseUrl}/update_paytm',
//       options: Options(headers: {"Token": "${token}"}),
//       data: formData,
//     );

//     var jsonResponse = jsonDecode(response.data!);
//     if (jsonResponse['code'] == '100') {
//       Get.showSnackbar(GetBar(
//         message: jsonResponse['message'],
//         duration: const Duration(seconds: 2),
//       ));
//     } else {
//       Get.showSnackbar(GetBar(
//         message: jsonResponse['message'],
//         duration: Duration(seconds: 2),
//       ));
//     }
//   }

//   void updatePhown(String phone) async {
//     var token = await StorageRepository.getToken();

//     try {
//       final response = await _dio!.post(
//         '${ApiPath.baseUrl}/update_phonepe',
//         options: Options(headers: {"Token": "${token}"}),
//         data: {
//           'phonepe': phone,
//         },
//       );
//       var jsonResponse = jsonDecode(response.data!);
//       if (jsonResponse['status'] == 'success') {
//         Get.showSnackbar(GetBar(
//           message: jsonResponse['message'],
//           duration: Duration(seconds: 2),
//         ));
//       } else {
//         Get.showSnackbar(GetBar(
//           message: jsonResponse['message'],
//           duration: Duration(seconds: 2),
//         ));
//       }
//     } catch (e) {
//       Get.showSnackbar(GetBar(
//         message: 'An error occurred',
//         duration: Duration(seconds: 2),
//       ));
//     }
//   }

//   void updategPay(String phone) async {
//     var token = await StorageRepository.getToken();

//     try {
//       final response = await _dio!.post(
//         '${ApiPath.baseUrl}/update_gpay',
//         options: Options(headers: {"Token": "${token}"}),
//         data: {
//           'gpay': phone,
//         },
//       );
//       print(response.data);
//       var jsonResponse = jsonDecode(response.data!);
//       if (jsonResponse['status'] == 'success') {
//         Get.showSnackbar(GetBar(
//           message: jsonResponse['message'],
//           duration: Duration(seconds: 2),
//         ));
//       } else {
//         Get.showSnackbar(GetBar(
//           message: jsonResponse['message'],
//           duration: Duration(seconds: 2),
//         ));
//       }
//     } catch (e) {
//       Get.showSnackbar(GetBar(
//         message: 'An error occurred',
//         duration: Duration(seconds: 2),
//       ));
//     }
//   }
// }

class PaymentScreenController extends GetxController {
  final Dio _dio = Dio();
  final RxBool isLoading = false.obs;
  final Rx<UserDetails> userDetails = UserDetails(
    message: '',
    code: '',
    status: '',
    data: UserData(
      username: '',
      mobile: '',
      email: '',
      bankName: '',
      accountHolderName: '',
      ifscCode: '',
      branchAddress: '',
      bankAccountNo: '',
      paytmMobileNo: '',
      phonepeMobileNo: '',
      gpayMobileNo: '',
      pendingNoti: '',
    ),
  ).obs;

  @override
  void onInit() {
    fetchUserDetails();
    super.onInit();
  }

  Future<void> fetchUserDetails() async {
    isLoading.value = true;

    try {
      final token = await StorageRepository.getToken();
      final response = await _dio.get(
        '${ApiPath.baseUrl}/get_user_details',
        options: Options(headers: {'Token': token}),
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.data!);
        userDetails.value = UserDetails.fromJson(jsonResponse);
      } else {
        handleException(response.data['message']);
        showSnackBar(
            response.data['message'], response.data['status'] == 'success');
      }
    } catch (e) {
      handleException(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updatePaytm(String phone) async {
    await _updatePaymentInfo('/update_paytm', 'paytm', phone);
  }

  Future<void> updatePhonepe(String phone) async {
    await _updatePaymentInfo('/update_phonepe', 'phonepe', phone);
  }

  Future<void> updategPay(String phone) async {
    await _updatePaymentInfo('/update_gpay', 'gpay', phone);
  }

  Future<void> _updatePaymentInfo(
      String path, String paramName, String phone) async {
    final formData = alfrom.FormData.fromMap({paramName: phone});
    try {
      final token = await StorageRepository.getToken();
      final response = await _dio.post(
        '${ApiPath.baseUrl}$path',
        options: Options(headers: {'Token': token}),
        data: formData,
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.data!);
        showSnackBar(
            jsonResponse['message'], jsonResponse['status'] == 'success');
      } else {
        handleException(response.data["message"]);
      }
    } catch (e) {
      handleException(e);
    }
  }

  void handleException(dynamic e) {
    showSnackBar('Error: $e', false);
  }

  void showSnackBar(String message, bool isSuccess) {
    Get.showSnackbar(
      GetBar(
        message: message,
        backgroundColor: isSuccess ? Colors.green : Colors.red,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
