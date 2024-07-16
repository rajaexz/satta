import 'package:Billa/screen/component/profileContainer.dart';
import 'package:Billa/screen/wallet/wallet_controller.dart/withdrow_controller.dart';

import 'package:flutter/material.dart';
import 'package:Billa/screen/header/appbar.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Billa/utilis/AllColor.dart';
import 'package:Billa/utilis/fontstyle.dart';

class WithdrawPage extends GetView<WithdrowController> {
  const WithdrawPage({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    Get.put(WithdrowController());

    return Scaffold(
      appBar: CustomAppBar(title: "Wallet"),
      body: GetBuilder<WithdrowController>(
        init: controller,
        builder: (controller) => Withdraw(
          controller: controller,
        ),
      ),
    );
  }
}

class Withdraw extends StatefulWidget {
  final WithdrowController? controller;

  Withdraw({Key? key, this.controller}) : super(key: key);

  @override
  _WithdrawState createState() => _WithdrawState();
}

class _WithdrawState extends State<Withdraw> {
  String selectedMethod = '';
  final _amountFocusNode = FocusNode();

  void selectMethod(String method) {
    setState(() {
      selectedMethod = method;
    });
  }

  bool _validateInput(String value) {
    if (value.isEmpty) {
      return false;
    }
    final int? amount = int.tryParse(value);
    return amount != null && amount > 0;
  }

  String mapMethod(String method) {
    switch (method) {
      case 'phonepe':
        return 'phonepe_mobile_no';
      case 'gpay':
        return 'gpay_mobile_no';
      case 'paytm':
        return 'paytm_mobile_no';
      case 'bank':
        return 'bank_name';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> paymentMethods = [
      {"name": "Paytm", "method": "paytm"},
      {"name": "GPay", "method": "gpay"},
      {"name": "PhonePe", "method": "phonepe"},
      {"name": "Bank", "method": "bank"},
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  color: Colors.black.withOpacity(0.5),
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  height: 50.0,
                  child: Text(
                    widget.controller!.userDetails.value.data.availablePoints,
                    style: CustomStyleswhite.header2TextStyle,
                  )),
              TextField(
                controller: widget.controller!.amountController,
                focusNode: _amountFocusNode,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Enter Your Money",
                  errorText:
                      _validateInput(widget.controller!.amountController.text)
                          ? null
                          : "Please enter a positive amount.",
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: paymentMethods.map((method) {
                  return paymentMethodCard(method["name"]!, method["method"]!);
                }).toList(),
              ),
              const SizedBox(height: 20),
              TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  ),
                ),
                isSemanticButton: true,
                onPressed: selectedMethod.isNotEmpty &&
                        _validateInput(widget.controller!.amountController.text)
                    ? () {
                        var withdrawData = {
                          "points": widget.controller!.amountController.text,
                          "method": mapMethod(selectedMethod),
                        };

                        widget.controller!.withdrawFund(withdrawData);
                      }
                    : null,
                child: Text(
                  "Withdraw",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget paymentMethodCard(String methodName, String methodValue) {
    return GestureDetector(
      onTap: () => selectMethod(methodValue),
      child: Card(
        color: selectedMethod == methodValue ? Colors.blue : Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            methodName,
            style: TextStyle(
              color:
                  selectedMethod == methodValue ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
