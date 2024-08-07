import 'dart:convert';
import 'dart:math';

import 'package:Billa/screen/auth/createpassword.dart';
import 'package:Billa/screen/auth/otpsrceenForget.dart';
import 'package:Billa/screen/auth/pinset.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:dio/src/form_data.dart' as alfrom;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:Billa/screen/auth/login.dart';

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

    final formData = alfrom.FormData.fromMap({
      'full_name': fullNameController.text.toString(),
      'mobile': mobileController.text.toString(),
      'pin': pinController.text.toString(),
      'password': passwordController.text.toString(),
    });

    try {
      final response = await dio.post(
        'https://development.smapidev.co.in/api/Api/signup',
        data: formData,
      );

      isLoading.value = false;
      var jsonResponse = jsonDecode(response.data!);
      print('Signup successful: ${jsonResponse}');

      if (response.statusCode == 200) {
        Get.toNamed("/otp", arguments: mobileController.text);
        Get.snackbar('Success', 'Signup successful',
            snackPosition: SnackPosition.BOTTOM);
      } else {
        print('Signup failed: ${jsonResponse["message"]}');
        Get.snackbar('Error', 'Signup failed: $jsonResponse["message"]}',
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      isLoading.value = false;
      print('Signup failed: $e');
      Get.snackbar('Error', 'Signup failed: $e',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> forgotPasswordVerify(String mobile, pass) async {
    final token = await StorageRepository.getToken();

    isLoading(true);
    final dio = Dio();

    try {
      final formData =
          alfrom.FormData.fromMap({'mobile': mobile, "password": pass});

      final response = await dio.post(
        'https://development.smapidev.co.in/api/Api/forgot_password_verify',
        data: formData,
        options: Options(
          headers: {
            'Token': '$token',
          },
        ),
      );
      var jsonResponse = jsonDecode(response.data!);
      print(jsonResponse);
      if (jsonResponse['status'] == 'success') {
        Get.snackbar('Success', jsonResponse['message']);
        Get.toNamed('/login');
      } else {
        Get.snackbar('Error', jsonResponse['message']);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> forgotPassword(String mobile) async {
    isLoading(true);
    final dio = Dio();

    try {
      final formData = alfrom.FormData.fromMap({
        'mobile': mobile,
      });

      final response = await dio.post(
        'https://development.smapidev.co.in/api/Api/forgot_password',
        data: formData,
      );
      var jsonResponse = jsonDecode(response.data!);
      // Handle response
      if (jsonResponse['status'] == 'success') {
        Get.snackbar('Success', jsonResponse['message']);
        // Navigate to verify OTP screen
        Get.to(OtpPageForget(), arguments: mobile);
      } else {
        Get.snackbar('Error', jsonResponse['message']);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> verifyOtp(String mobile, String otp) async {
    final dio = Dio();

    isLoading(true);
    final formData = alfrom.FormData.fromMap({
      'mobile': mobile,
      'otp': otp,
    });
    try {
      final response = await dio.post(
        'https://development.smapidev.co.in/api/Api/verify_otp',
        data: formData,
      );

      var jsonResponse = jsonDecode(response.data!);
      if (jsonResponse['status'] == 'success') {
        Get.snackbar('Success', jsonResponse['message']);
        await StorageRepository.destroyOfflineStorageOne(AppConstant.tokenKey);
        final newToken = jsonResponse['data']['token'];

        print("${newToken}-----------------");
        await Future.delayed(const Duration(seconds: 2));
        await StorageRepository.saveOffline(AppConstant.tokenKey, newToken);
        Get.to(() => CreateNewPasswordScreen(), arguments: mobile);
      } else {
        Get.snackbar('Error', jsonResponse['message']);
      }
      // // Handle response
      // if (jsonResponse['status'] == 'success') {
      //   Get.snackbar('Success', jsonResponse['message']);
      //   // Navigate to login screen
      //   Get.to(() => CreateNewPasswordScreen(), arguments: mobile);
      // } else {
      //   Get.snackbar('Error', jsonResponse['message']);
      // }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> verifyOtpPin(String mobile, String otp) async {
    final dio = Dio();

    isLoading(true);
    final formData = alfrom.FormData.fromMap({
      'mobile': mobile,
      'otp': otp,
    });
    try {
      final response = await dio.post(
        'https://development.smapidev.co.in/api/Api/verify_otp',
        data: formData,
      );

      var jsonResponse = jsonDecode(response.data!);
      // Handle response
      if (jsonResponse['status'] == 'success') {
        Get.snackbar('Success', jsonResponse['message']);
        await StorageRepository.destroyOfflineStorageOne(AppConstant.createpin);
        final newToken = jsonResponse['data']['token'];

        print("${newToken}-----------------");
        await Future.delayed(const Duration(seconds: 2));
        await StorageRepository.saveOffline(AppConstant.createpin, newToken);
        Get.toNamed("/Createsetpin", arguments: mobile);
      } else {
        Get.snackbar('Error', jsonResponse['message']);
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

      var jsonResponse = jsonDecode(response.data!);
      if (response.statusCode == 200) {
        print('Signup successful: ${jsonResponse['message']}');

        Get.snackbar('Success', 'Successful send opt',
            snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar('Error', 'Signup failed: ${jsonResponse['message']}',
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      isLoading.value = false;
      print('Signup failed: $e');
      Get.snackbar('Error', 'Signup failed: $e',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> resendotpPIn(num) async {
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

      var jsonResponse = jsonDecode(response.data!);
      if (response.statusCode == 200) {
        print('Signup successful: ${jsonResponse['message']}');

        Get.snackbar('Success', 'Successful send opt',
            snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar('Error', 'Signup failed: ${jsonResponse['message']}',
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

    final formData = alfrom.FormData.fromMap({
      'mobile': mobile,
      'password': password,
    });

    try {
      final response = await Dio().post(
        'https://development.smapidev.co.in/api/Api/login',
        data: formData,
      );

      isLoading.value = false;

      final responseData = jsonDecode(response.data);

      if (responseData["code"] != "400") {
        await _handleSuccessfulLogin(responseData, mobile);
      } else {
        Get.snackbar('Error', 'Login failed: ${responseData["message"]}',
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      isLoading.value = false;
      print('Login failed: $e');
      Get.snackbar('Error', 'Login failed: $e',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> _handleSuccessfulLogin(
      Map<String, dynamic> responseData, String mobile) async {
    await StorageRepository.destroyOfflineStorageOne(AppConstant.tokenKeypin);

    final token = responseData["data"]["token"];
    print('Token: $token');

    await Future.delayed(Duration(seconds: 2));

    await StorageRepository.saveOffline(AppConstant.phone, mobile);
    await StorageRepository.saveOffline(AppConstant.createpin, token);
    await StorageRepository.saveOffline(AppConstant.tokenKeypin, token);

    Get.snackbar('Success', 'Login successful',
        snackPosition: SnackPosition.BOTTOM);
    Get.to(() => PinPage());
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
        final responseData = jsonDecode(response.data);

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
}

String _generatePin() {
  var rng = Random();
  return (rng.nextInt(9000) + 1000).toString(); // Generates a 4-digit PIN
}
