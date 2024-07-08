import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:winner11/screen/header/appbar.dart';

import 'controller/PaytmentSreencontroller.dart';

class PhonepayPage extends GetView<PaytmentSreenController> {
  const PhonepayPage({Key? key});

  Widget build(BuildContext context) {
    Get.put(PaytmentSreenController());

    return  Scaffold(
      appBar:  CustomAppBar(title: "Google Pay"), 
      body: GetBuilder<PaytmentSreenController>(
          init: controller,
          builder: (controller) => PhonepayPageForm(
            controller: controller,
          ),
        ),
    );
  }
}

class PhonepayPageForm extends StatelessWidget {

 PaytmentSreenController?  controller;

 PhonepayPageForm({super.key, this.controller});
  final phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

     final phoneController = TextEditingController(text: controller!.userDetails.value.data!.phonepeMobileNo.toString());   
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: phoneController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              labelText: 'Phone Number',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a phone number';
              }
              if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                return 'Please enter a valid 10-digit phone number';
              }
              return null;
            },
          ),
          SizedBox(height: 20),
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
