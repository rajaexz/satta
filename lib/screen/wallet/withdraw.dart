import 'package:winner11/screen/component/profileContainer.dart';
import 'package:winner11/screen/wallet/wallet_controller.dart/withdrow_controller.dart';

import 'package:flutter/material.dart';
import 'package:winner11/screen/header/appbar.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:winner11/utilis/AllColor.dart';
import 'package:winner11/utilis/fontstyle.dart';

class WithdrawPage extends GetView<WithdrowController> {
  const WithdrawPage({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    Get.put(WithdrowController());

    return Scaffold(
      appBar: CustomAppBar(title: "Wallet"),
      body: GetBuilder<WithdrowController>(
        init: controller,
        builder: (controller) => Withdrow(
          controller: controller,
        ),
      ),
    );
  }
}

class Withdrow extends StatefulWidget {
  final WithdrowController? controller;

  Withdrow({Key? key, this.controller}) : super(key: key);

  @override
  _WithdrowState createState() => _WithdrowState();
}

class _WithdrowState extends State<Withdrow> {
  String selectedMethod = '';

  void selectMethod(String method) {
    setState(() {
      switch (method) {
        case "paytm":
          selectedMethod = widget
              .controller!.userDetails.value.data!.paytmMobileNo
              .toString();
        case "gpay":
          selectedMethod = widget
              .controller!.userDetails.value.data!.gpayMobileNo
              .toString();

        case "phonepe":
          selectedMethod = widget
              .controller!.userDetails.value.data!.phonepeMobileNo
              .toString();

          break;
        default:
          selectedMethod = widget
              .controller!.userDetails.value.data!.paytmMobileNo
              .toString();
          ;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> paymentMethods = [
      {"name": "Paytm", "method": "paytm"},
      {"name": "GPay", "method": "gpay"},
      {"name": "PhonePe", "method": "phonepe"},
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MyFunctionInput(
              controller: widget.controller!.amountController,
              fieldName: "Enter Your Money",
              hintText: "Enter Your Money",
              inputType: TextInputType.number,
              errorMessage: "Please enter you",
              usernameRegex: r'^[\S\s]{1,}$',
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
                backgroundColor: MaterialStateProperty.all(myColorRed),
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                ),
              ),
              isSemanticButton: true,
              onPressed: selectedMethod.isNotEmpty
                  ? () {
                      var withdrawData = {
                        "points": widget.controller!.amountController.text,
                        "method": selectedMethod,
                      };

                      widget.controller!.withdrawFund(withdrawData);
                    }
                  : null,
              child: Text(
                "Withdraw",
                style: CustomStyleswhite.header2TextStyle,
              ),
            ),
          ],
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
