import 'package:flutter/material.dart';
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
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            style: TextStyle(
              color: myColor,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              errorText: "Please enter a valid amount",
              contentPadding: const EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.attach_money,
                color: myColor,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: myColor!),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: myColor!),
              ),
              hintText: 'Enter amount for transaction',
            ),
            controller: phoneController, // Use a separate controller for amount
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter an amount';
              }

              // Validate if the input is a valid number
              if (double.tryParse(value) == null) {
                return 'Please enter a valid amount';
              }

              // If none of the conditions are met, return null (no error)
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
