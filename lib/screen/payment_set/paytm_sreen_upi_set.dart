import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winner11/screen/header/appbar.dart';
import 'package:winner11/screen/header/sidebar.dart';
import 'package:winner11/screen/my_home.dart';
import 'package:winner11/screen/payment_set/controller/PaytmentSreencontroller.dart';

import '../controller/MyHomePage_controller.dart';

class PaytmentSreen extends GetView<PaytmentSreenController> {
  const PaytmentSreen({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    Get.put(PaytmentSreenController());

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Payment Add',
      ),
      body: PaytmSreenView(
        controller: controller,
      ),
      drawer: myDrawer(context),
    );
  }
}

class PaytmSreenView extends StatefulWidget {
  final PaytmentSreenController? controller;
  PaytmSreenView({Key? key, this.controller}) : super(key: key);

  @override
  State<PaytmSreenView> createState() => _PaytmSreenViewState();
}

class _PaytmSreenViewState extends State<PaytmSreenView> {
  @override
  Widget build(BuildContext context) {
    List PaymentMethord = ["Paytm", "GooglePay", "PhonePay","Bank"];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        itemCount: PaymentMethord.length, // Number of items in the grid
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns in the grid
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Handle item click
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${PaymentMethord[index]}')));
              Get.toNamed('/${PaymentMethord[index].toString()}Screen');
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Center(
                child: Text(
                  PaymentMethord[index].toString(),
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
