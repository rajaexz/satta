import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:winner11/screen/component/profileContainer.dart';

import 'controller/PaytmentSreencontroller.dart';

class UpdatePaytmPage extends GetView<PaytmentSreenController> {
  @override
  Widget build(BuildContext context) {
    Get.put(PaytmentSreenController());
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Paytm'),
      ),
      body: GetBuilder<PaytmentSreenController>(
        init: controller,
        builder: (controller) => UpdatePaytmForm(
          controller: controller,
        ),
      ),
    );
  }
}

class UpdatePaytmForm extends StatelessWidget {
  PaytmentSreenController? controller;
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
                    .updatePaytm(phoneController.text);
              }
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}
