import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Billa/screen/auth/controller/froget_pin_controller.dart';

class ForgotPasswordScreenPIN extends StatelessWidget {
  final ForgetPinController controller = Get.put(ForgetPinController());

  ForgotPasswordScreenPIN({super.key});

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
              controller: controller.phoneController,
              decoration: const InputDecoration(labelText: 'Mobile'),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 20),
            Obx(() {
              if (controller.isLoading.value) {
                return CircularProgressIndicator();
              }
              return ElevatedButton(
                onPressed: () {
                  controller.forgetWithPin(controller.phoneController.text);
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
