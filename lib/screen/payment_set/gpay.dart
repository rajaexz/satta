import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

import 'controller/PaytmentSreencontroller.dart';

class UpdateGpayPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Google Pay'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: UpdateGpayForm(),
      ),
    );
  }
}

class UpdateGpayForm extends StatelessWidget {
  final phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
