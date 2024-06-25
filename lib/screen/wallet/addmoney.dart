// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:winner11/DataGet/notiLocal.dart';
import 'package:winner11/screen/component/custom_toaster.dart';

import 'package:winner11/screen/component/profileContainer.dart';

import 'package:winner11/utilis/borderbox.dart';
// ignore: depend_on_referenced_packages
import 'package:html/parser.dart' as htmlParser;
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:winner11/utilis/globlemargin.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winner11/screen/header/appbar.dart';

import 'package:winner11/utilis/AllColor.dart';
import 'package:shared_preferences/shared_preferences.dart';

final ValueController valueController = Get.put(ValueController());

class Addmoney extends StatefulWidget {
  Addmoney({Key? key}) : super(key: key);

  static const routeName = 'addmoney';

  @override
  _AddmoneyState createState() => _AddmoneyState();
}

class _AddmoneyState extends State<Addmoney> {
  var inputdata = "";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Wallet"),
      body: SafeArea(
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
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: "Please Enter Amount",
                        ),
                        controller: TextEditingController(text: inputdata),
                        onChanged: (newValue) {
                          inputdata = newValue;
                          try {
                            valueController.maoney.value = int.parse(newValue);
                          } catch (e) {
                            // Handle the case where the input is not a valid integer
                          }
                        },
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
                      )),
                ),
              ),
              const Row(children: []),
              Obx(
                () => GestureDetector(
                  onTap: () async {
                    if (_formKey.currentState!.validate())
                      _showBottomSheet(context: context);
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
        return FractionallySizedBox(
          heightFactor: 0.8,
          child: MyUpi(),
        );
      },
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
  hitApi(id, response) async {
    await apiService.userallType(data: {
      "id": id,
      "trans_id": response.orderId.toString(),
      "money": valueController.maoney.value,
      "payment_status": "success"
    }, uri: "/add_money");
  }

  Future<void> tapPayhitApi() async {
    
       final store = await SharedPreferences.getInstance();
    setState(() {
      isSLoading = true; // Start loading
      orderId = valueController.generateOrderId();
    });

   
      store.setString("stOrderId", orderId) ;
    var url = 'http://sky11live.com/nodeserver/checkTapPay.php';
    var data = {
      'amount': '${valueController.maoney.value}',
      'currency': 'IND',
      'email': 'Winner@gmail.com',
      'phone': '7011448878',
      'order_id': orderId,
    };

    try {
      var response = await http.post(Uri.parse(url), body: data);

      if (response.statusCode == 200) {
        fisrtCkickTapPay = true;
        isSLoading = false;
        var document = htmlParser.parse(response.body);
        var imgElement = document.getElementsByTagName('img')[0];

        setState(() {
        
          var srcAttribute = imgElement.attributes['src']!;
          var base64StartIndex = srcAttribute.indexOf("base64,") + 7;
          var base64Data = srcAttribute.substring(base64StartIndex);
          qrCodeImageUrl = base64Data;
        });

        performStatusCheckWithDelay();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Failed to process payment. Please try again.")));
      }
    } catch (e) {
      // Handle exceptions from the HTTP request
      print('An error occurred: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("An error occurred while processing your request.")));
    }
  }

  @override
  void initState() {
    super.initState();
        _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
 
     }

  void performStatusCheck() async {
    if (isApiRequestInProgress) {
    return; // Exit if success has already been processed
  }
    try {
      var response = await valueController.checkStatus(orderId: orderId);


        final store = await SharedPreferences.getInstance();
        final id = store.getString("userId") ?? '';
       stOrderId = store.getString("stOrderId")!;
     if(stOrderId == orderId){
        
      if (response['txn_status'] == "PENDING") {
   
        return;
      }else if (response['txn_status'] == "SUCCESS") {
    
        var data  = await apiService.userallType(data: {
          "id": id,
          "trans_id": orderId,
          "money": valueController.maoney.value,
          "payment_status": "success"
        }, uri: "/add_money");

        
    isApiRequestInProgress = true; // Mark the API request as started

        if (data != null) {
          CustomToaster.showSuccess(context, "Payment successful");
        } else {
          CustomToaster.showWarning(context, "Error processing payment.");
        }
      }
     }else{
          CustomToaster.showWarning(context, "Error processing payment.");
     }

    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }



///rozopay


  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    final store = await SharedPreferences.getInstance();
    final id = store.getString("userId");

    try {
      // Show loading indicator (optional).
      // You can use Get.dialog or any other preferred method.

      var data = await hitApi(id, response);
      // Check if the API call was successful.
      if (data != null) {
        // ignore: use_build_context_synchronously
        CustomToaster.showSuccess(context, "Payment successful");
        setState(() {
          Get.toNamed("/home", arguments: id);
        });
      } else {
        // ignore: use_build_context_synchronously
        CustomToaster.showWarning(context, "Error processing payment");
      }
    } catch (error) {
      // ignore: use_build_context_synchronously
      CustomToaster.showSuccess(context, "Error processing payment");
    } finally {
      // ignore: use_build_context_synchronously
      CustomToaster.showSuccess(context, "Error processing payment");
    }
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
      'amount': (valueController.maoney * 100)
          .toString(), // amount in the smallest currency unit (e.g., paise)
      'name': 'WINNER11',
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
timer = Timer.periodic(Duration(seconds: 10), (timer) {
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
      tapPayhitApi();
    }
  },
          child: Center(
            child:isSLoading 
      ? CircularProgressIndicator()
      : Container(
                width: 100,
                height: 100,
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
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
        Divider(),
        if (fisrtCkickTapPay && !isSLoading)
          Padding(
            padding: EdgeInsets.all(10),
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
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      boxShadow: [
                        themeController.isLightMode.value
                            ? BoxShadow(color: Colors.black, blurRadius: 10)
                            : BoxShadow(color: Colors.grey, blurRadius: 10)
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
