import 'dart:convert';

import 'package:winner11/screen/component/custom_toaster.dart';
import 'package:winner11/screen/component/profileContainer.dart';
import 'package:winner11/screen/component/trancetionId.dart';
import 'package:winner11/utilis/globlemargin.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winner11/screen/component/darkmode.dart';
import 'package:winner11/screen/header/appbar.dart';
import 'package:winner11/service/authapi.dart';
import 'package:winner11/utilis/AllColor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

void launchUPIUrl(paymentLink) async {
  var demolink = paymentLink["data"]["App"];
  if (await canLaunchUrl(Uri.parse(demolink))) {
    await launchUrl(Uri.parse(demolink));
  } else {
    print('Could not launch payment link: $paymentLink');
  }
}

class ValueController extends GetxController {
  RxInt maoney = 0.obs;

  void changeValue(int newValue) {
    maoney.value = newValue;
  }
}

final ValueController valueController = Get.put(ValueController());

class Addmoney extends StatefulWidget {
  Addmoney({Key? key}) : super(key: key);

  static const routeName = 'addmoney';

  @override
  _AddmoneyState createState() => _AddmoneyState();
}

class _AddmoneyState extends State<Addmoney> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Wallet"),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Obx(() {
                return Container(
                  margin: GlobleglobleMargin.globleMargin,
                  child: Container(
                    margin: EdgeInsets.only(top: 100),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: themeController.isLightMode.value
                          ? myColorWhite
                          : myColor,
                      border: Border.all(
                          color: myColorRed), // Replace with your border style
                      borderRadius: BorderRadius.circular(
                          10), // Replace with your border radius
                    ),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: "Please Enter Amount",
                      ),
                      controller: TextEditingController(
                          ),
                      onSaved: (newValue) {
                        valueController.maoney.value = int.tryParse(newValue!)!;
                      },
                      textAlign: TextAlign.start,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(
                          fontSize: 16), // Replace with your text style
                      autofocus: true,
                      cursorColor:
                          Colors.black, // Replace with your cursor color
                    ),
                  ),
                );
              }),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomRupess(
                          () => valueController.changeValue(500), "500"),
                      CustomRupess(
                          () => valueController.changeValue(1000), "1000"),
                      CustomRupess(
                          () => valueController.changeValue(1500), "1500")
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomRupess(
                          () => valueController.changeValue(2000), "2000"),
                      CustomRupess(
                          () => valueController.changeValue(2500), "2500"),
                      CustomRupess(
                          () => valueController.changeValue(3000), "3000")
                    ],
                  )
                ],
              ),
              GestureDetector(
                onTap: () async {
                  //  _showBottomSheet(context: context);
                  try {
                    final store = await SharedPreferences.getInstance();
                    final id = store.getString("userId");

                    // Simulate adding money to the user's account
                    final ApiService apiService = ApiService();
                    var data = await apiService.userallType(data: {
                      "id": id,
                      "trans_id": generateOrderId(),
                      "money": valueController.maoney.toString(),
                      "payment_status": "success"
                    }, uri: "/add_money");
                    if (data != null &&
                        valueController.maoney.value.toString() != "0") {
                      // ignore: use_build_context_synchronously
                      CustomToaster.showSuccess(
                          context, "Successfully ${data["data"]["message"]} ");


                    } else {
                       // ignore: use_build_context_synchronously
                      CustomToaster.showWarning(context,
                          "Something Wrong ${data["data"]["message"]}");
                    }
                  } catch (e) {
                    // Handle exceptions and show an error toast message
                    CustomToaster.showWarning(context, "Something Wrong ");
                  }
                },
                child: Obx(() => Container(
                      width: 450,
                      height: 50,
                      margin: EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 10.5),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: themeController.isLightMode.value
                            ? myColor
                            : myColorWhite,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.5),
                      child: Text('Pay',
                          style: TextStyle(
                            color: themeController.isLightMode.value
                                ? myColorWhite
                                : myColor,
                          )),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showBottomSheet({
    required BuildContext context,
  }) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.8,
          child: MyUpi(),
        );
      },
    );
  }
}

class CustomRupess extends StatelessWidget {
  final Function setStateCallback;
  var paisa;
  CustomRupess(this.setStateCallback, this.paisa);
  final ThemeController themeController = Get.put(ThemeController());
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
          onTap: () {
            setStateCallback();
          },
          child: Obx(
            () => Container(
              width: 50,
              height: 50,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color:
                    themeController.isLightMode.value ? myColorWhite : myColor,
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                  style: BorderStyle.solid,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: Center(child: Text(this.paisa)),
            ),
          )),
    );
  }
}

class MyUpi extends StatefulWidget {
  MyUpi({
    Key? key,
  }) : super(key: key);

  @override
  State<MyUpi> createState() => _MyUpiState();
}

class _MyUpiState extends State<MyUpi> {
  final ValueController valueController = Get.put(ValueController());

  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    final store = await SharedPreferences.getInstance();
    final id = store.getString("userId");
    final ApiService apiService = ApiService();

    print('Payment success: ${response.paymentId}');
    var data = await apiService.userallType(data: {
      "id": id,
      "trans_id": response.orderId,
      "money": valueController.maoney,
      "payment_status": "success"
    }, uri: "/add_money");
     }

  Future<void> _handlePaymentError(PaymentFailureResponse response) async {
    print('Payment error: ${response.code} - ${response.message}');

    final store = await SharedPreferences.getInstance();
    final id = store.getString("userId");
    final ApiService apiService = ApiService();

    var data = await apiService.userallType(data: {
      "id": id,
      "trans_id": "123456",
      "money": valueController.maoney,
      "payment_status": ""
    }, uri: "/add_money");

  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print('External wallet: ${response.walletName}');
    // Add your logic for handling external wallet
  }

  void _startPayment() async {
    var options = {
      'key': 'rzp_test_GQAgK5383apKsV',
      'amount': (valueController.maoney * 100)
          .toString(), // amount in the smallest currency unit (e.g., paise)
      'name': 'Your App Name',
      'description': 'Payment for your product or service',
      'prefill': {'contact': '1234567890', 'email': 'example@email.com'},
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
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(height: 20),
        SizedBox(height: 20),
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
              'assets/Paytm.png', // Replace 'your_image.png' with the actual path to your image asset
              width: 100.0, // Adjust the width as needed
              height: 100.0, // Adjust the height as needed
            ),
          ),
        ),
      ],
    );
  }
}
