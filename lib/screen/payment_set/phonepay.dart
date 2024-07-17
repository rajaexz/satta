import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:Billa/screen/component/profileContainer.dart';
import 'package:Billa/screen/header/appbar.dart';

import 'controller/PaytmentSreencontroller.dart';

class PhonepayPage extends GetView<PaymentScreenController> {
  const PhonepayPage({Key? key});

  Widget build(BuildContext context) {
    Get.put(PaymentScreenController());

    return Scaffold(
      appBar: CustomAppBar(title: "Google Pay"),
      body: GetBuilder<PaymentScreenController>(
        init: controller,
        builder: (controller) => PhonepayPageForm(
          controller: controller,
        ),
      ),
    );
  }
}

class PhonepayPageForm extends StatelessWidget {
  PaymentScreenController? controller;

  PhonepayPageForm({super.key, this.controller});
  final phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final phoneController = TextEditingController(
        text: controller!.userDetails.value.data!.phonepeMobileNo.toString());
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
 
          const SizedBox(height: 20),
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
