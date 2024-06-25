import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:dio/src/form_data.dart'as alfrom;
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController pinController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  var isLoading = false.obs;

  Future<void> signup() async {
    isLoading.value = true;
    final dio = Dio();
var pin  =_generatePin();
    final formData = alfrom.FormData.fromMap({
      'full_name': fullNameController.text,
      'mobile': mobileController.text,
      'pin':pin,
      'password': passwordController.text,
    });

    try {
      final response = await dio.post(
        'https://development.smapidev.co.in/api/Api/signup',
        data: formData,
      );

      isLoading.value = false;
      if (response.statusCode == 200 && response.data["code"] != "400") {
        print('Signup successful: ${response.data}');
      
            Get.toNamed("/otp", arguments: {"phone":mobileController.text,"otp":pin});
     
        Get.snackbar('Success', 'Signup successful', snackPosition: SnackPosition.BOTTOM);
      } else {
        print('Signup failed: ${response.data["message"]}');
    
          
        Get.snackbar('Error', 'Signup failed: ${response.data["message"]}', snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      isLoading.value = false;
      print('Signup failed: $e');
      Get.snackbar('Error', 'Signup failed: $e', snackPosition: SnackPosition.BOTTOM);
    }
  }
  Future<void> resendotp() async {
    isLoading.value = true;
    final dio = Dio();
     var pin  =_generatePin();
    final formData = alfrom.FormData.fromMap({
     
      'mobile': mobileController.text,
    
     
    });

    try {
      final response = await dio.post(
        'https://development.smapidev.co.in/api/Api/resend_otp',
        data: formData,
      );

      isLoading.value = false;
      if (response.statusCode == 200) {
        print('Signup successful: ${response.data}');
      
                 Get.snackbar('Success', 'Successful send opt', snackPosition: SnackPosition.BOTTOM);
      } else {
   
        Get.snackbar('Error', 'Signup failed: ${response.statusMessage}', snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      isLoading.value = false;
      print('Signup failed: $e');
      Get.snackbar('Error', 'Signup failed: $e', snackPosition: SnackPosition.BOTTOM);
    }
  }
Future<void> login({ mobile,password}) async {
 print("--------${mobile} $password-----dadf");
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
      if (response.data["code"] == "200") {
       var token = response.data["token"];
      
        Get.snackbar('Success', 'Login successful', snackPosition: SnackPosition.BOTTOM);
          Get.toNamed("/home", arguments: {"token":token});
      } else {
        Get.snackbar('Error', 'Signup failed: ${response.data["message"]}', snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      isLoading.value = false;
      print('Signup failed: $e');
      Get.snackbar('Error', 'Signup failed: $e', snackPosition: SnackPosition.BOTTOM);
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
                              store.setString(
                                  'token', token);
     Get.offAllNamed("/home");
          Get.snackbar('Success', 'Verify successful', snackPosition: SnackPosition.BOTTOM);
          // You can handle storing token or navigating to the next screen after verification

          
        } else {
     
                         
                              Get.offAllNamed("/login");
          Get.snackbar('Error', 'Verify failed: ${responseData['message']}', snackPosition: SnackPosition.BOTTOM);
        }
      } else {
        print('Verify failed: ${response.statusMessage}');
        Get.snackbar('Error', 'Verify failed: ${response.statusMessage}', snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      isLoading.value = false;
      print('Verify failed: $e');
      Get.snackbar('Error', 'Verify failed: $e', snackPosition: SnackPosition.BOTTOM);
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
    return (rng.nextInt(9000) + 1000).toString();  // Generates a 4-digit PIN
  }