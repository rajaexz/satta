import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:dio/src/form_data.dart' as alfrom;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:winner11/screen/auth/login.dart';

import '../../../network/storage_repository.dart';
import '../../../service/authapi.dart';
import '../../../utilis/app_constant.dart';
import '../otpsrceen.dart';

class SignupController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController pinController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ApiService apiService = Get.put(ApiService());
  var isLoading = false.obs;

  Future<void> signup() async {
    isLoading.value = true;
    final dio = Dio();
    var pin = _generatePin();
    final formData = alfrom.FormData.fromMap({
      'full_name': fullNameController.text.toString(),
      'mobile': mobileController.text.toString(),
      'pin': pin.toString(),
      'password': passwordController.text.toString(),
    });

    try {
      final response = await dio.post(
        'https://development.smapidev.co.in/api/Api/signup',
        data: formData,
      );

      isLoading.value = false;
      print('Signup successful: ${response.data}');

      if (response.statusCode == 200) {
        Get.toNamed("/otp",
            arguments: {"phone": mobileController.text, "otp": pin});
        Get.snackbar('Success', 'Signup successful',
            snackPosition: SnackPosition.BOTTOM);
      } else {
        print('Signup failed: ${response.data["message"]}');
        Get.snackbar('Error', 'Signup failed: ${response.data["message"]}',
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      isLoading.value = false;
      print('Signup failed: $e');
      Get.snackbar('Error', 'Signup failed: $e',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> forgotPassword(String mobile) async {
    isLoading(true);
    try {
      final response = await apiService.post('/forgot_password', data: {
        'mobile': mobile,
      });
      // Handle response
      if (response.data['status'] == 'success') {
        Get.snackbar('Success', response.data['message']);
        // Navigate to verify OTP screen
        Get.to(() => OtpPage(mobile: int.parse(mobile)));
      } else {
        Get.snackbar('Error', response.data['message']);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> verifyOtp(String mobile, String otp, String newPassword) async {
    isLoading(true);
    try {
      final response = await apiService.post('/verify_otp', data: {
        'mobile': mobile,
        'otp': otp,
        'password': newPassword,
      });
      // Handle response
      if (response.data['status'] == 'success') {
        Get.snackbar('Success', response.data['message']);
        // Navigate to login screen
        Get.to(() => Loginpage());
      } else {
        Get.snackbar('Error', response.data['message']);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> resendotp() async {
    isLoading.value = true;
    final dio = Dio();
    var pin = _generatePin();
    final formData = alfrom.FormData.fromMap({
      'mobile': mobileController.text.toString(),
    });

    try {
      final response = await dio.post(
        'https://development.smapidev.co.in/api/Api/resend_otp',
        data: formData,
      );

      isLoading.value = false;
      if (response.statusCode == 200) {
        print('Signup successful: ${response.data}');

        Get.snackbar('Success', 'Successful send opt',
            snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar('Error', 'Signup failed: ${response.statusMessage}',
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      isLoading.value = false;
      print('Signup failed: $e');
      Get.snackbar('Error', 'Signup failed: $e',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> login({required String mobile, required String password}) async {
    isLoading.value = true;
    final dio = Dio();
    final formData = alfrom.FormData.fromMap({
      'mobile': mobile.toString(),
      'password': password.toString(),
    });

    try {
      final response = await dio.post(
        'https://development.smapidev.co.in/api/Api/login',
        data: formData,
      );
      isLoading.value = false;

      var badydecode = jsonDecode(response.data);

      if (badydecode["code"] != "400") {
        // Ensure the comparison is made with the correct string
        var token = badydecode["data"]["token"];

        StorageRepository.saveOffline(AppConstant.tokenKey, token);
        Get.snackbar('Success', 'Login successful',
            snackPosition: SnackPosition.BOTTOM);
        Get.toNamed("/home");
      } else {
        Get.snackbar('Error', 'Login failed: ${badydecode["message"]}',
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      isLoading.value = false;
      print('Login failedsere: $e');
      Get.snackbar('Error', 'Login failed: $e',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> verifyUser(String mobile, String otp) async {
    final store = await SharedPreferences.getInstance();
    isLoading.value = true;
    final dio = Dio();

    final formData = alfrom.FormData.fromMap({
      'mobile': "$mobile",
      'otp': "$otp",
    });

    try {
      final response = await dio.post(
        'https://development.smapidev.co.in/api/Api/verify_user',
        data: formData,
      );

      isLoading.value = false;
      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData['status'] == 'success') {
          final token = responseData['data']['token'];
          print("-------------${token}");
          store.setString('token', token);
          Get.offAllNamed("/home");
          Get.snackbar('Success', 'Verify successful',
              snackPosition: SnackPosition.BOTTOM);
          // You can handle storing token or navigating to the next screen after verification
        } else {
          Get.offAllNamed("/login");
          Get.snackbar('Error', 'Verify failed: ${responseData['message']}',
              snackPosition: SnackPosition.BOTTOM);
        }
      } else {
        print('Verify failed: ${response.statusMessage}');
        Get.snackbar('Error', 'Verify failed: ${response.statusMessage}',
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      isLoading.value = false;
      print('Verify failed: $e');
      Get.snackbar('Error', 'Verify failed: $e',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  void onClose() {
    fullNameController.dispose();
    mobileController.dispose();
    pinController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}

String _generatePin() {
  var rng = Random();
  return (rng.nextInt(9000) + 1000).toString(); // Generates a 4-digit PIN
}
