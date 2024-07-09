import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:winner11/model/usedetail.dart';

import '../../../network/api_path.dart';
import '../../../network/storage_repository.dart';

class PaytmentSreenController extends GetxController {
  var isLoading = false.obs;
  Dio? _dio;
  var token;
  @override
  Future<void> onInit() async {
    token = await StorageRepository.getTokenpin();

    _dio = Dio(BaseOptions(
      baseUrl:
          '${ApiPath.baseUrl}starline_game', // Replace with your API base URL
      headers: {
        'Token': token,
      },
    ));
    // TODO: implement onInit
    fetchUserDetails();
    super.onInit();
  }

  //////////////////////////////////
  ///
  ///
  ///

  var userDetails = UserDetails(
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

  void fetchUserDetails() async {
    isLoading(true);
    try {
      final token = await StorageRepository.getToken();

      print(token);
      final response = await _dio!.get(
        '${ApiPath.baseUrl}get_user_details', // Replace with your actual API URL
        options: Options(headers: {'Token': token}),
      );
      print(response.data);
      if (response.statusCode == 200) {
        var jsonResponse =
            jsonDecode(response.data!); // Decode the JSON response
        userDetails(UserDetails.fromJson(jsonResponse));
      } else {
        // Handle error
      }
    } catch (e) {
      // Handle error
      print(e);
    } finally {
      isLoading(false);
    }
  }

  ///
  ///
  ///////////////////////////////////////

  void updatePaytm(String phone) async {
    try {
      final response = await _dio!.post(
        '${ApiPath.baseUrl}/update_paytm',
        data: {
          'phonepe': phone,
        },
      );

      var jsonResponse = jsonDecode(response.data!);
      if (jsonResponse['status'] == 'success') {
        Get.showSnackbar(GetBar(
          message: jsonResponse['message'],
          duration: const Duration(seconds: 2),
        ));
      } else {
        Get.showSnackbar(GetBar(
          message: 'Failed to update Paytm details',
          duration: Duration(seconds: 2),
        ));
      }
    } catch (e) {
      Get.showSnackbar(GetBar(
        message: 'An error occurred',
        duration: Duration(seconds: 2),
      ));
    }
  }

  void updatePhown(String phone) async {
    try {
      final response = await _dio!.post(
        '${ApiPath.baseUrl}/update_phonepe',
        data: {
          'paytm': phone,
        },
      );
      var jsonResponse = jsonDecode(response.data!);
      if (jsonResponse['status'] == 'success') {
        Get.showSnackbar(GetBar(
          message: jsonResponse['message'],
          duration: Duration(seconds: 2),
        ));
      } else {
        Get.showSnackbar(GetBar(
          message: 'Failed to update Paytm details',
          duration: Duration(seconds: 2),
        ));
      }
    } catch (e) {
      Get.showSnackbar(GetBar(
        message: 'An error occurred',
        duration: Duration(seconds: 2),
      ));
    }
  }

  void updategPay(String phone) async {
    try {
      final response = await _dio!.post(
        '${ApiPath.baseUrl}/update_gpay',
        data: {
          'gpay': phone,
        },
      );
print(response.data);
      var jsonResponse = jsonDecode(response.data!);
      if (jsonResponse['status'] == 'success') {
        Get.showSnackbar(GetBar(
          message: jsonResponse['message'],
          duration: Duration(seconds: 2),
        ));
      } else {
        Get.showSnackbar(GetBar(
          message: 'Failed to update Paytm details',
          duration: Duration(seconds: 2),
        ));
      }
    } catch (e) {
      Get.showSnackbar(GetBar(
        message: 'An error occurred',
        duration: Duration(seconds: 2),
      ));
    }
  }
}
