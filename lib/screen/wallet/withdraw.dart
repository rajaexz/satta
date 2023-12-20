import 'package:winner11/screen/component/custom_toaster.dart';
import 'package:winner11/screen/component/profileContainer.dart';

import 'package:winner11/service/authapi.dart';

import 'package:flutter/material.dart';
import 'package:winner11/screen/header/appbar.dart';
import 'package:get/get.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WithdrawPage extends StatefulWidget {
  @override
  _WithdrawPageState createState() => _WithdrawPageState();
}

class _WithdrawPageState extends State<WithdrawPage> {
  TextEditingController amountController = TextEditingController();

  final ApiService apiService = ApiService();
  withdrawFunds() async {
    try {
      final store = await SharedPreferences.getInstance();
      final id = store.getString("userId");

      final response = await apiService.userallType(
        data: {"id": id, "money": amountController.text},
        uri: '/withdrawal_money',
      );
print(response["data"]["message"]);
      // Handle other response messages

      if (response["data"]["message"] == ("You have not completed your KYC")) {
  // ignore: use_build_context_synchronously
  QuickAlert.show(
    context: context,
    showConfirmBtn: true,
    type: QuickAlertType.warning,
    text: response["data"]["message"],
    onConfirmBtnTap: () {
      Get.offNamed('/kyc');
    },
  );
}else
if ( response["data"]["error"] == "true") {
  CustomToaster.showWarning(context, "${response["data"]["message"].toString()}");
}  else {
  CustomToaster.showSuccess(context, "${response["data"]["message"].toString()}");
}

   

    } catch (e) {
      // Handle exceptions
      CustomToaster.showWarning(context, "Failed to make the API request:");
      print("Failed to make the API request: $e");
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
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: withdrawFunds,
                child: Text('Withdraw'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
