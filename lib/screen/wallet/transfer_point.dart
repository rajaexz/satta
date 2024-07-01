import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winner11/screen/component/profileContainer.dart';
import 'package:winner11/screen/header/appbar.dart';
import 'package:winner11/screen/wallet/wallet_controller.dart/trancefer_controller.dart';

class TransferPage extends GetView<TransferController> {
  const TransferPage({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    Get.put(TransferController());

    return Scaffold(
      appBar : CustomAppBar(title: "Wallet History"),
      body: GetBuilder<TransferController>(
        init: controller,
        builder: (controller) => TransferView(
          controller: controller,
        ),
      ),
    );
  }
}


class TransferView extends StatelessWidget {
TransferController? controller;  
TransferView({super.key,this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transfer Points'),
      ),
      body:     controller!.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                       MyFunctionInput(
                controller: controller!.userNumberController,
                fieldName: "Enter Your User Number",
                hintText: " User Number",
                inputType: TextInputType.number,
                errorMessage: "Please enter  User Number",
                usernameRegex:
                    r'^\d{10}$', // Adjust the regex for name validation
              ),
                  
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed:(){
                        
var transferVerifyData =  {'user_number': controller!.userNumberController.text};
                         controller!.transferVerify(transferVerifyData);
                      },
                      child: Text('Verify User'),
                    ),
                    SizedBox(height: 16),
                    if (controller!.userName.value.isNotEmpty)
                      Text('User Name: ${controller!.userName.value}'),
                    SizedBox(height: 16),
                    TextField(
                      controller: controller!.pointsController,
                      decoration: const InputDecoration(
                        labelText: 'Points',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: (){
                                              
var transferPointsData =  {'user_number': controller!.userNumberController.text, "points" : controller!.pointsController.text};
   
                        controller!.transferPoints(transferPointsData);
                      },
                      child: Text('Transfer Points'),
                    ),
                  ],
                ),
              )
   
    );
  }
}
