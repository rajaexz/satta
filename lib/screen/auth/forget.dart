import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winner11/screen/auth/controller/authController.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final SignupController controller = Get.put(SignupController());
  final TextEditingController mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: mobileController,
              decoration: InputDecoration(labelText: 'Mobile'),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 20),
            Obx(() {
              if (controller.isLoading.value) {
                return CircularProgressIndicator();
              }
              return ElevatedButton(
                onPressed: () {
                  controller.forgotPassword(mobileController.text);
                },
                child: Text('Send OTP'),
              );
            }),
          ],
        ),
      ),
    );
  }
}
