import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:Billa/screen/component/profileContainer.dart';
import 'package:Billa/screen/header/appbar.dart';
import 'package:Billa/screen/wallet/wallet_controller.dart/trancefer_controller.dart';

class TransferPage extends GetView<TransferController> {
  const TransferPage({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    Get.put(TransferController());

    return Scaffold(
      appBar: CustomAppBar(title: "Transfer Point "),
      body: GetBuilder<TransferController>(
        init: controller,
        builder: (controller) => TransferView(
          controller: controller,
        ),
      ),
    );
  }
}

bool containsAlphabet(String value) {
  // Regular expression to check if the string contains any alphabetic character
  final alphabetRegex = RegExp(r'[a-zA-Z]');
  return alphabetRegex.hasMatch(value);
}

class TransferView extends StatelessWidget {
  TransferController? controller;
  TransferView({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    return controller!.isLoading.value
        ? Center(child: CircularProgressIndicator())
        : Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyFunctionInput(
                  controller: controller!.userNumberController,
                  fieldName: "Enter  Amount",
                  hintText: " Enter vaild Amount",
                  inputType: TextInputType.number,
                  errorMessage: "Please enter  User Number",
                  usernameRegex:
                      r'^\d+(\.\d{1,2})?$', // Adjust the regex for name validation
                ),
                SizedBox(height: 16),
                Center(
                    child: Text(
                  "User Name :${controller!.userName.value}",
                  style: TextStyle(color: Colors.green),
                )),
                ElevatedButton(
                  onPressed: () {
                    var transferVerifyData = {
                      'user_number': controller!.userNumberController.text
                    };
                    controller!.transferVerify(transferVerifyData);
                  },
                  child: Text('Verify User'),
                ),
                SizedBox(height: 16),
                if (controller!.userName.value.isNotEmpty)
                  Text('User Name: ${controller!.userName.value}'),
                SizedBox(height: 16),
                if (containsAlphabet(controller!.userName.value))
                  Column(
                    children: [
                      TextField(
                        controller: controller!.pointsController,
                        decoration: const InputDecoration(
                          labelText: 'Points',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          var transferPointsData = {
                            'user_number':
                                controller!.userNumberController.text,
                            "points": controller!.pointsController.text
                          };

                          controller!.transferPoints(transferPointsData);
                        },
                        child: Text('Transfer Points'),
                      ),
                    ],
                  ),
              ],
            ),
          );
  }
}
