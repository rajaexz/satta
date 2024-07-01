import 'package:winner11/screen/component/profileContainer.dart';
import 'package:winner11/screen/wallet/Upi_payment.dart';

import 'package:winner11/utilis/globlemargin.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winner11/screen/header/appbar.dart';

import 'package:winner11/utilis/AllColor.dart';

import 'wallet_controller.dart/addfund_controller.dart';

class Addmoney extends GetView<AddfundController> {
  const Addmoney({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    Get.put(AddfundController());

    return Scaffold(
      appBar :CustomAppBar(title: "Wallet"),
      body: GetBuilder<AddfundController>(
        init: controller,
        builder: (controller) => AddmoneyView(
          controller: controller,
        ),
      ),
    );
  }
}

class AddmoneyView extends StatefulWidget {
  AddfundController? controller;
  AddmoneyView({Key? key, this.controller}) : super(key: key);

  static const routeName = 'addmoney';

  @override
  _AddmoneyViewState createState() => _AddmoneyViewState();
}

class _AddmoneyViewState extends State<AddmoneyView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return    SafeArea(
        child: SingleChildScrollView(
          physics:
              const AlwaysScrollableScrollPhysics(), // Ensure the scroll view is always scrollable
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Container(
                  margin: GlobleglobleMargin.globleMargin,
                  child: Container(
                      margin: const EdgeInsets.only(top: 100),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: themeController.isLightMode.value
                            ? myColorWhite
                            : myColor,
                        border: Border.all(
                            color: myColorRed), // Customize your border style
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                              hintText: "Please Enter Amount",
                            ),
                            controller: widget.controller!.moneyController,

                            textAlign: TextAlign.start,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(
                                fontSize: 16), // Customize your text style
                            autofocus: true,
                            cursorColor:
                                Colors.black, // Customize your cursor color
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter an amount';
                              }
                              return null; // Return null if the input is valid
                            },
                          ),
                        ],
                      )),
                ),
              ),
              const Row(children: []),
              Obx(
                () => GestureDetector(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      _showBottomSheet(context: context);
                    }
                  },
                  child: Container(
                    width: 450,
                    height: 50,
                    margin: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 10.5),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: themeController.isLightMode.value
                          ? myColor
                          : myColorWhite,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20.5),
                    child: Text('Pay',
                        style: TextStyle(
                          color: themeController.isLightMode.value
                              ? myColorWhite
                              : myColor,
                        )),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    
  }

  void _showBottomSheet({
    required BuildContext context,
  }) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      builder: (BuildContext context) {
        return const FractionallySizedBox(
          heightFactor: 0.8,
          child: MyUpi(),
        );
      },
    );
  }
}
