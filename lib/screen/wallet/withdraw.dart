import 'package:winner11/screen/component/custom_toaster.dart';
import 'package:winner11/screen/component/profileContainer.dart';
import 'package:winner11/screen/wallet/wallet_controller.dart/withdrow_controller.dart';

import 'package:winner11/service/authapi.dart';

import 'package:flutter/material.dart';
import 'package:winner11/screen/header/appbar.dart';
import 'package:get/get.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
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

class Withdrow extends StatelessWidget {
  WithdrowController? controller;
  Withdrow({super.key, this.controller});

  getStoreKYC() async {
    final store = await SharedPreferences.getInstance();
    var KYCstatus = store.getString('KYCstatus');
    return KYCstatus;
  }

// withdrawFunds(context) async {
//  Get.offAllNamed('/kyc');
// }

  @override
  Widget build(BuildContext context) {
    return  Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              MyFunctionInput(
                controller: controller!.amountController,
                fieldName: "Enter Your Money",
                hintText: "Enter Your Money",
                inputType: TextInputType.number,
                errorMessage: "Please enter you",
                usernameRegex:
                    r'^[\S\s]{1,}$', // Adjust the regex for name validation
              ),
              const SizedBox(height: 20),
              TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(myColorRed),
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10))),
                  isSemanticButton: true,
                  onPressed: () {
                    var withdrawData = {
                      "points": controller!.amountController.text,
                      "method": "7011448878"
                    };

                    controller!.withdrawFund(withdrawData);
                  },
                  child: Text(
                    "Withdraw",
                    style: CustomStyleswhite.header2TextStyle,
                  )),
            ],
          ),
        ),
      );
   
  }

}
