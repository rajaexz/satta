import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:winner11/screen/component/profileContainer.dart';
import 'package:winner11/screen/header/appbar.dart';

import 'controller/PaytmentSreencontroller.dart';

class UpdateGpayPage extends GetView<PaytmentSreenController> {
  const UpdateGpayPage({Key? key});

  Widget build(BuildContext context) {
    Get.put(PaytmentSreenController());

    return Scaffold(
      appBar: CustomAppBar(title: "Google Pay"),
      body: GetBuilder<PaytmentSreenController>(
        init: controller,
        builder: (controller) => UpdateGpayForm(
          controller: controller,
        ),
      ),
    );
  }
}

class UpdateGpayForm extends StatelessWidget {
  PaytmentSreenController? controller;

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
                Get.find<PaytmentSreenController>()
                    .updategPay(phoneController.text);
              }
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}
