import 'dart:convert';

import 'package:winner11/model/usedetail.dart';
import 'package:winner11/network/storage_repository.dart';
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
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../network/api_path.dart';

class BankEdit extends StatefulWidget {
  const BankEdit({super.key});

  @override
  State<BankEdit> createState() => _BankEditState();
}

class _BankEditState extends State<BankEdit> {
  final formKey2 = GlobalKey<FormState>();
  var userDetails = UserDetails(
    message: '',
    code: '',
    status: '',
    data: UserData(
      username: '',
      mobile: '',
      email: '',
      bankName: '',
      accountHolderName: '',
      ifscCode: '',
      branchAddress: '',
      bankAccountNo: '',
      paytmMobileNo: '',
      phonepeMobileNo: '',
      gpayMobileNo: '',
      pendingNoti: '',
    ),
  ).obs;

  late final TextEditingController bankNameController;
  late final TextEditingController bankAccountController;
  late final TextEditingController ifscCodeController;
  late final TextEditingController accountHolderNameController;
  late final TextEditingController branchAddressController;

  @override
  void initState() {
    super.initState();
    fetchUserDetails();
    bankNameController = TextEditingController();
    bankAccountController = TextEditingController();
    ifscCodeController = TextEditingController();
    accountHolderNameController = TextEditingController();
    branchAddressController = TextEditingController();
  }

  @override
  void dispose() {
    bankNameController.dispose();
    bankAccountController.dispose();
    ifscCodeController.dispose();
    accountHolderNameController.dispose();
    branchAddressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Bank Edit"),
      body: SingleChildScrollView(
        child: Container(
          margin: GlobleglobleMargin.globleMargin,
          child: Form(
            key: formKey2,
            child: Obx(
              () {
                bankNameController.text = userDetails.value.data!.bankName ?? '';
                bankAccountController.text = userDetails.value.data!.bankAccountNo ?? '';
                ifscCodeController.text = userDetails.value.data!.ifscCode ?? '';
                accountHolderNameController.text = userDetails.value.data!.accountHolderName ?? '';
                branchAddressController.text = userDetails.value.data!.branchAddress ?? '';

                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      color: myColorRed,
                      child: Text(
                        "Bank Details",
                        style: CustomStyleswhite.header2TextStyle,
                      ),
                    ),
                    MyFunctionInput(
                      controller: bankNameController,
                      fieldName: "Bank Name",
                      hintText: "Bank Name",
                      inputType: TextInputType.text,
                      errorMessage: "Please enter a valid Bank Name",
                      usernameRegex: r"^[A-Za-z\s]+$",
                    ),
                    size20h,
                    MyFunctionInput(
                      controller: bankAccountController,
                      fieldName: "Bank Account",
                      hintText: "XXXXXXXX Account No.",
                      inputType: TextInputType.number,
                      errorMessage: "Please enter a valid Bank Account",
                      usernameRegex: r"^\d{10,}$",
                    ),
                    size20h,
                    MyFunctionInput(
                      controller: ifscCodeController,
                      fieldName: "IFSC Code",
                      hintText: "ABCD0123456 : IFSC code",
                      inputType: TextInputType.text,
                      errorMessage: "Please enter a valid IFSC code",
                      usernameRegex: r"^[A-Z]{4}0[A-Z0-9]{6}$",
                    ),
                    size20h,
                    MyFunctionInput(
                      controller: accountHolderNameController,
                      fieldName: "Account Holder Name",
                      hintText: "Account Holder Name",
                      inputType: TextInputType.text,
                      errorMessage: "Please enter a valid Account Holder Name",
                      usernameRegex: r"^[A-Za-z\s]+$",
                    ),
                    size20h,
                    MyFunctionInput(
                      controller: branchAddressController,
                      fieldName: "Branch Address",
                      hintText: "Branch Address",
                      inputType: TextInputType.text,
                      errorMessage: "Please enter a valid Branch Address",
                      usernameRegex: r"^[A-Za-z0-9\s,.-]+$",
                    ),
                    size20h,
                    ElevatedButton(
                      onPressed: () async {
                        if (formKey2.currentState!.validate()) {
                          await callApi2(
                            context: context,
                            bankNameController: bankNameController,
                            bankAccountController: bankAccountController,
                            ifscCodeController: ifscCodeController,
                            accountHolderNameController: accountHolderNameController,
                            branchAddressController: branchAddressController,
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
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void fetchUserDetails() async {
    try {
      final token = await StorageRepository.getToken();
      final dio = Dio();
      final response = await dio.get(
        '${ApiPath.baseUrl}get_user_details',
        options: Options(headers: {'Token': token}),
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.data);
        userDetails(UserDetails.fromJson(jsonResponse));
      } else {
        // Handle error
      }
    } catch (e) {
      // Handle error
      print(e);
    }
  }

  Future<void> callApi2({
    required BuildContext context,
    required TextEditingController bankNameController,
    required TextEditingController bankAccountController,
    required TextEditingController ifscCodeController,
    required TextEditingController accountHolderNameController,
    required TextEditingController branchAddressController,
  }) async {
    final store = await SharedPreferences.getInstance();
    var id = store.getString("userId");

    if (bankNameController.text.isEmpty ||
        bankAccountController.text.isEmpty ||
        ifscCodeController.text.isEmpty ||
        accountHolderNameController.text.isEmpty ||
        branchAddressController.text.isEmpty) {
      CustomToaster.showWarning(context, "All fields are required");
      return;
    }

    var editDataBank = {
      "id": id.toString(),
      "account_holder_name": accountHolderNameController.text,
      "account_no": bankAccountController.text,
      "ifsc_code": ifscCodeController.text,
      "bank_name": bankNameController.text,
      "branch_address": branchAddressController.text,
    };

     final token = await StorageRepository.getToken();
    try {
      final dio = Dio();
      final response = await dio.post(
        '${ApiPath.baseUrl}update_bank_details',
        data: editDataBank,
        options: Options(
          headers: {
            'Token': token, // Replace with your actual token
          },
        ),
      );

      if (response.statusCode == 200 && response.data['status'] == 'success') {
        CustomToaster.showSuccess(context, "Bank details updated successfully");
      } else {
        CustomToaster.showWarning(context, "Something went wrong");
      }
    } catch (e) {
      CustomToaster.showWarning(context, "Error: $e");
    }
  }
}

