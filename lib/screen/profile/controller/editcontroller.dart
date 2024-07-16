import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Billa/network/api_path.dart';
import 'package:dio/src/form_data.dart' as fr;
import '../../../network/storage_repository.dart';

class ProfileController extends GetxController {
  final Dio _dio = Dio();
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();

  void updateProfile() async {
    if (formKey.currentState!.validate()) {
      final name = nameController.text;
      final email = emailController.text;
      final token = await StorageRepository.getToken();

      final data = fr.FormData.fromMap({
        "name": name,
        "email": email,
      });

      try {
        final response = await _dio.post(
          '${ApiPath.baseUrl}update_profile',
          options: Options(
            headers: {
              'Token': '$token',
            },
          ),
          data: data,
        );

        if (response.statusCode == 200) {
          Get.snackbar("Success", "Profile updated successfully");
          Get.toNamed('/home');
        } else {
          Get.snackbar("Error", "Failed to update profile");
        }
      } catch (e) {
        Get.snackbar("Error", "Failed to update profile: $e");
      }
    }
  }
}
