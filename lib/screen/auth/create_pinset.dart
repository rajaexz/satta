import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:Billa/screen/auth/controller/PinController.dart';
import 'package:Billa/screen/auth/controller/creat_pin_controller.dart';
import '../../network/network_config.dart';
import 'controller/froget_pin_controller.dart';

class CreatePinPage extends StatelessWidget {
  var data = Get.arguments;

  final CreatePinController pinController = Get.put(CreatePinController());
  var makepin;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Enter  Pin ')),
      body: Center(
        child: Obx(() {
          if (pinController.isLoading.value) {
            return CircularProgressIndicator();
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Pinput(
                  length: 4,
                  obscureText: true,
                  onCompleted: (pin) {
                    makepin = int.parse(pin);
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Manually trigger login for testing or alternative UI flow
                    // if (makepin == "") {
                    //   Get.snackbar('Error', "Please Enter Pin ");
                    // } else if (phone == "") {
                    //   Get.snackbar('Error', "Please Enter Numder ");
                    // } else {

                    // }

                    pinController.CreateWithPin("$makepin", data);
                  },
                  child: Text('Set pin'),
                ),
              ],
            );
          }
        }),
      ),
    );
  }
}
