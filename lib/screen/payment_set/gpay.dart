import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:Billa/screen/component/profileContainer.dart';
import 'package:Billa/screen/header/appbar.dart';

import 'controller/PaytmentSreencontroller.dart';

class UpdateGpayPage extends GetView<PaymentScreenController> {
  const UpdateGpayPage({Key? key});

  Widget build(BuildContext context) {
    Get.put(PaymentScreenController());

    return Scaffold(
      appBar: CustomAppBar(title: "Google Pay"),
      body: GetBuilder<PaymentScreenController>(
        init: controller,
        builder: (controller) => UpdateGpayForm(
          controller: controller,
        ),
      ),
    );
  }
}

class UpdateGpayForm extends StatelessWidget {
  PaymentScreenController? controller;

  UpdateGpayForm({super.key, this.controller});
  final phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final phoneController = TextEditingController(
        text: controller!.userDetails.value.data!.gpayMobileNo.toString());
    return Form(
      key: _formKey,
      child: Column(
        children: [
          MyFunctionInput(
            controller: phoneController,
            fieldName: "Enter Phone ",
            hintText: "Enter Your Phone ",
            inputType: TextInputType.text,
            errorMessage: "Please enter a valid 10-digit phone number",
            usernameRegex: r'^\d{10}$',
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                controller!.updategPay(phoneController.text);
              }
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}
