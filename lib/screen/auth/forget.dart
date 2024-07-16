import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:Billa/screen/auth/controller/authController.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final SignupController controller = Get.put(SignupController());
  final TextEditingController mobileController = TextEditingController();

  ForgotPasswordScreen({super.key});

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
            TextFormField(
              controller: mobileController,
              decoration: InputDecoration(labelText: 'Mobile'),
              keyboardType: TextInputType.number,
              inputFormatters: [
                LengthLimitingTextInputFormatter(
                    10), // Limits the length to 10 digits
                FilteringTextInputFormatter.digitsOnly, // Allows only digits
              ],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your mobile number';
                }
                // Regex pattern for 10-digit mobile number
                String pattern = r'^[0-9]{10}$';
                RegExp regex = RegExp(pattern);
                if (!regex.hasMatch(value)) {
                  return 'Please enter a valid 10-digit mobile number';
                }
                return null;
              },
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
