import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:winner11/main.dart';
import 'package:winner11/screen/component/custom_toaster.dart';
import 'package:winner11/screen/wallet/wallet_controller.dart/addfund_controller.dart';

import '../../utilis/AllColor.dart';
import '../../utilis/borderbox.dart';
import '../header/appbar.dart';

class MyUpi extends GetView<AddfundController> {
  const MyUpi({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    Get.put(AddfundController());

    return GetBuilder<AddfundController>(
      init: controller,
      builder: (controller) => MyUpiView(
        controller: controller,
      ),
    );
  }
}

class MyUpiView extends StatefulWidget {
  AddfundController? controller;
  MyUpiView({Key? key, this.controller}) : super(key: key);

  @override
  State<MyUpiView> createState() => _MyUpiViewState();
}

class _MyUpiViewState extends State<MyUpiView> {
  late Timer timer;

  List<String> listofUpi = [
    'assets/phonepay.png', // Local asset example
    'assets/Paytm.png',
    'assets/gpay.png'
        'assets/download.png',
  ];

  bool isSLoading = false;
  String htmlContent = '';
  String orderId = "";
  String stOrderId = "";
  List<String> links = [];
  String qrCodeImageUrl = '';
  bool fisrtCkickTapPay = false;
  bool isApiRequestInProgress = false;
  late Razorpay _razorpay;


  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void performStatusCheck() async {}

  ///rozopay

Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
 
    var withdrawData = {
      "points": widget.controller!.moneyController.text,
      "trans_status": "successful",
      "trans_id": response.paymentId
    };

    // Call the addFund method
  await widget.controller!.addFund(withdrawData);


}

  Future<void> _handlePaymentError(PaymentFailureResponse response) async {
    final store = await SharedPreferences.getInstance();
    final id = store.getString("userId");

    CustomToaster.showWarning(context, "Error processing payment");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    CustomToaster.showWarning(
        context, 'External wallet: ${response.walletName}');

    // Add your logic for handling external wallet
  }

  void _startPayment() async {
    var options = {
      'key': 'rzp_test_UsSB8qTArOcYxL',
      'amount': (int.parse(widget.controller!.moneyController.text)* 100)
          .toString(), // amount in the smallest currency unit (e.g., paise)
      'name': 'Billo',
      'description': 'Payment for your product or service',
      'prefill': {'contact': '1234567890', 'email': 'Winner11@email.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  @override
  void dispose() {
    timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  void performStatusCheckWithDelay() async {
    timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (fisrtCkickTapPay) {
        performStatusCheck();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        if (fisrtCkickTapPay)
          Row(
            mainAxisAlignment: MainAxisAlignment
                .start, // Align children to the start of the row
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  performStatusCheckWithDelay();
                },
              ),
              // Add more widgets here as needed
              const Text('CheckStatus'),
            ],
          ),
        const SizedBox(height: 20),
        const SizedBox(height: 20),
        const SizedBox(height: 20),
        Center(
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
                  // Use the specified color for the normal state
                  if (states.contains(MaterialState.pressed)) {
                    // Use a different color when the button is pressed
                    return myColor;
                  } else {
                    // Use the default color for other states
                    return myColorWhite;
                  }
                },
              ),
            ),
            onPressed: _startPayment,
            child: Image.asset(
              'assets/razo.png', // Replace 'your_image.png' with the actual path to your image asset
              width: 100.0, // Adjust the width as needed
              height: 100.0, // Adjust the height as needed
            ),
          ),
        ),
        const SizedBox(height: 20),
        GestureDetector(
          onTap: () {
            if (!isSLoading) {
              // tapPayhitApi();
            }
          },
          child: Center(
            child: isSLoading
                ? const CircularProgressIndicator()
                : Container(
                    width: 100,
                    height: 100,
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      boxShadow: [
                        themeController.isLightMode.value ? boxdark : boxshadow2
                      ],
                      color: Colors.green,
                    ),
                    child: Image.asset(
                      'assets/Paytm.png',
                      width: 100.0,
                      height: 100.0,
                    )),
          ),
        ),
        Center(
          child: qrCodeImageUrl.isNotEmpty
              ? Image.memory(base64Decode(qrCodeImageUrl))
              : const Text(" "),
        ),
        const Divider(),
        if (fisrtCkickTapPay && !isSLoading)
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: listofUpi.asMap().entries.map((entry) {
                int index = entry.key;
                String imagePath = entry.value;
                return InkWell(
                  onTap: () async {
                    performStatusCheckWithDelay();
                  }, // Example action on tap
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      boxShadow: [
                        themeController.isLightMode.value
                            ? const BoxShadow(
                                color: Colors.black, blurRadius: 10)
                            : const BoxShadow(
                                color: Colors.grey, blurRadius: 10)
                      ],
                      color: Colors.green,
                      image: DecorationImage(
                        image: AssetImage(imagePath), // For local assets
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          )
      ],
    );
  }
}
