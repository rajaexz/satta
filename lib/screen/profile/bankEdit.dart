import 'package:winner11/screen/component/coundown.dart';
import 'package:winner11/screen/component/custom_toaster.dart';
import 'package:winner11/screen/component/profileContainer.dart';
import 'package:winner11/screen/header/appbar.dart';
import 'package:winner11/service/authapi.dart';
import 'package:winner11/utilis/AllColor.dart';
import 'package:winner11/utilis/boxSpace.dart';
import 'package:winner11/utilis/fontstyle.dart';
import 'package:winner11/utilis/globlemargin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BankEdit extends StatefulWidget {
  const BankEdit({super.key});

  @override
  State<BankEdit> createState() => _BankEditState();
}

class _BankEditState extends State<BankEdit> {
     final formKey2 = GlobalKey<FormState>();
  // bank deatail
  TextEditingController bankNameController = TextEditingController();
  TextEditingController bankAccountController = TextEditingController();

  TextEditingController ifscCodeController = TextEditingController();

  void dispose() {

 
//bank

    bankNameController.dispose();
    bankAccountController.dispose();
    ifscCodeController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return         Scaffold(
    appBar: CustomAppBar(title: "Bank Edit"),
    body: SingleChildScrollView(
      child: Container(
        margin: GlobleglobleMargin.globleMargin,
        child: Form(
                            key: formKey2,
                            child: Column(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      color: myColorRed,
                                      child: Text(
                                        "Bank Details",
                                        style: CustomStyleswhite.header2TextStyle,
                                      ),
                                    )
                                  ],
                                ),
                                MyFunctionInput(
                                  controller: bankNameController,
                                  fieldName: "Bank Name"
              ,
                                  hintText: "Bank Name",
                                  inputType: TextInputType.text,
                                  errorMessage: "Please enter a valid Bank Name",
                                  usernameRegex:
                                      r"^[A-Za-z\s]+$", // Adjust the regex as needed
                                ),
                                size20h,
                                MyFunctionInput(
                                  controller: bankAccountController,
                                  fieldName: 
                                    "Bank Account"
                        ,
                                  hintText: "XXXXXXXX Account No.",
                                  inputType: TextInputType.number,
                                  errorMessage: "Please enter a valid Bank Account",
                                  usernameRegex:
                                      r"^\d{10,}$", // Assuming a simple check for 10 or more digits
                                ),
                                size20h,
                                MyFunctionInput(
                                  controller: ifscCodeController,
                                  fieldName: 
               "IFSC Code"
                                  ,
                                  hintText: "ABCD0123456 : IFSC code",
                                  inputType: TextInputType.text,
                                  errorMessage: "Please enter a valid IFSC code",
                                  usernameRegex: r"^[A-Z]{4}0[A-Z0-9]{6}$",
                                ),
                                size20h,
                                ElevatedButton(
                                  onPressed: () async {
                                    if (formKey2.currentState!.validate()) {
                                      callApi2(
                                        context: context,
                                        bankNameController: bankNameController,
                                        bankAccountController: bankAccountController,
                                        ifscCodeController: ifscCodeController,
                                      );
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: myColorgreen,
                                  ),
                                  child: Text(
                                    'Bank Details Save',
                                    style: CustomStyleswhite.headerTextStyle,
                                  ),
                                ),
                              ],
                            )),
      ),
    ),
    );
             
          
  }

  callApi2({
  context,
  TextEditingController? bankNameController,
TextEditingController?  bankAccountController,
 TextEditingController? ifscCodeController,
}) async {
  ApiService apiService = ApiService();
  final store = await SharedPreferences.getInstance();
  var id = store.getString("userId");


  if(bankNameController!.text.isEmpty || bankAccountController!.text.isEmpty ||  ifscCodeController!.text.isEmpty){
     CustomToaster.showWarning(context, "Something went wrong all feild are require ");

   }else{
      var editDataBank = {
    "id": id.toString(),
    "account_no": bankAccountController.text,
    "ifsc_code": ifscCodeController.text,
    "bank_name": bankNameController.text,
  };

  var bankProfile = await apiService.userallType(
    uri: "/add_bank_account",
    data: editDataBank,
  );

  if (bankProfile != "nodata") {
    CustomToaster.showSuccess(context, "Add Bank Edit Successfully $bankProfile");
  

  } else {
    CustomToaster.showWarning(context, "Something went wrong");
  }

  }

 

}
}