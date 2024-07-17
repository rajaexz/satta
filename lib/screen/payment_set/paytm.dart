import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:Billa/screen/component/profileContainer.dart';

import '../../utilis/AllColor.dart';
import 'controller/PaytmentSreencontroller.dart';

class UpdatePaytmPage extends GetView<PaymentScreenController> {
  @override
  Widget build(BuildContext context) {
    Get.put(PaymentScreenController());
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Paytm'),
      ),
      body: GetBuilder<PaymentScreenController>(
        init: controller,
        builder: (controller) => UpdatePaytmForm(
          controller: controller,
        ),
      ),
    );
  }
}

class UpdatePaytmForm extends StatelessWidget {
  PaymentScreenController? controller;
  UpdatePaytmForm({super.key, required this.controller});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final phoneController = TextEditingController(
        text: controller!.userDetails.value.data!.paytmMobileNo.toString());
    return Form(
      key: _formKey,
      child: Column(
        children: [


     TextFormField(
                        controller: phoneController,
                        decoration: InputDecoration(labelText: 'Mobile'),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(
                              10), // Limits the length to 10 digits
                          FilteringTextInputFormatter
                              .digitsOnly, // Allows only digits
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
                
    // MyFunctionInput(
          //   controller: phoneController,
          //   fieldName: "Enter Phone ",
          //   hintText: "Enter Your Phone ",
          //   inputType: TextInputType.number,
          //   errorMessage: "Please enter a valid 10-digit phone number",
          //   usernameRegex: r'^\d{10}$',
          // ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                controller!.updatePaytm(phoneController.text);
              }
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}
