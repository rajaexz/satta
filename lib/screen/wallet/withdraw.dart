import 'package:winner11/screen/component/custom_toaster.dart';
import 'package:winner11/screen/component/profileContainer.dart';

import 'package:winner11/service/authapi.dart';

import 'package:flutter/material.dart';
import 'package:winner11/screen/header/appbar.dart';
import 'package:get/get.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:winner11/utilis/AllColor.dart';
import 'package:winner11/utilis/fontstyle.dart';

class WithdrawPage extends StatefulWidget {
  @override
  _WithdrawPageState createState() => _WithdrawPageState();
}

class _WithdrawPageState extends State<WithdrawPage> {
  TextEditingController amountController = TextEditingController();

  final ApiService apiService = ApiService();
 getStoreKYC() async {
    final store = await SharedPreferences.getInstance();
   var  KYCstatus = store.getString('KYCstatus');
   return KYCstatus;
  }

withdrawFunds(context) async {
  try {
    // Get the user's KYC status
    final demo = await getStoreKYC();

    // Check if KYC is not completed
    if (demo == 'waiting' || demo == 'pending') {
      Get.snackbar("Error", "Your KYC is pending. Please wait for approval.", snackPosition: SnackPosition.TOP);
      await Future.delayed(Duration(seconds: 2)); // Adjust the delay duration as needed
      Get.offAllNamed('/kyc'); // Redirect to the KYC page
      return; // Exit the function if KYC is pending or waiting
    } else if (demo == 'null') {
      Get.snackbar("Error", "First complete your KYC to join the contest.", snackPosition: SnackPosition.TOP);
      await Future.delayed(Duration(seconds: 2)); // Adjust the delay duration as needed
      Get.offAllNamed('/kyc'); // Redirect to the KYC page
      return; // Exit the function if KYC is not completed
    }

    // Proceed with the withdrawal process if KYC is successful
    final store = await SharedPreferences.getInstance();
    final id = store.getString("userId");
    if (id == null) {
      Get.snackbar("Error", "User ID not found. Please log in again.", snackPosition: SnackPosition.TOP);
      return;
    }

    final response = await apiService.userallType(
      data: {"id": id, "money": amountController.text},
      uri: '/withdrawal_money',
    );

    if (response == null || response["data"] == null || response["data"]["message"] == null) {
      Get.snackbar("Error", "Unexpected response from server.", snackPosition: SnackPosition.BOTTOM);
      return;
    }

    final message = response["data"]["message"].toString();

    if (message.contains('"money" must be a number')) {
      Get.snackbar("Warning", message, snackPosition: SnackPosition.BOTTOM);
    } else if (message.contains('minimum withdraw limit 42500')) {
      Get.snackbar("Warning", message, snackPosition: SnackPosition.BOTTOM);
    } else if (message.isNotEmpty) {
      Get.snackbar("Waiting", message, snackPosition: SnackPosition.BOTTOM);
      amountController.text = "";
    } else {
      Get.snackbar("Error", "Unknown error occurred.", snackPosition: SnackPosition.BOTTOM);
    }
  } catch (e) {
    Get.snackbar("Error", "Failed to make the API request: $e", snackPosition: SnackPosition.BOTTOM);
    print("Error during withdrawal request: $e");
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Withdraw"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
           MyFunctionInput(
                          controller: amountController,
                          fieldName:"Enter Your Money",
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
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10))),
              isSemanticButton: true,
              onPressed: (){withdrawFunds(context);},
              child: Text(
                "Withdraw",
                style: CustomStyleswhite.header2TextStyle,
              )),
            ],
          ),
        ),
      ),
    );
  }
}
