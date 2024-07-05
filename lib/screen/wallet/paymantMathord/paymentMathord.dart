import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winner11/screen/wallet/paymantMathord/controller/Allpayment_controller.dart';
import 'package:flutter/material.dart';
import 'package:upi_india/upi_india.dart';


import '../Upi_payment.dart';
import '../wallet_controller.dart/addfund_controller.dart';



class Allpayment extends GetView<AddfundController> {
  const Allpayment({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    Get.put(AddfundController());

    return GetBuilder<AddfundController>(
        init: controller,
        builder: (controller) => AllpaymentScreen(
          controller: controller,
        ),
      );
  }
}

class AllpaymentScreen extends StatefulWidget {
   AddfundController?  controller;
   AllpaymentScreen({super.key,this.controller});

  @override
  State<AllpaymentScreen> createState() => _AllpaymentScreenState();
}

class _AllpaymentScreenState extends State<AllpaymentScreen> {
  Future<UpiResponse>? _transaction;
  UpiIndia _upiIndia = UpiIndia();
  List<UpiApp>? apps;

  TextStyle header = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  TextStyle value = const TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14,
  );

  @override
  void initState() {
    _upiIndia.getAllUpiApps(mandatoryTransactionId: false).then((value) {
      setState(() {
        apps = value;
      });
    }).catchError((e) {
      apps = [];
    });
    super.initState();
  }

  Future<UpiResponse> initiateTransaction(UpiApp app) async {
    return _upiIndia.startTransaction(
      app: app,
      receiverUpiId: "9078600498@ybl",
      receiverName: 'Md Azharuddin',
      transactionRefId: 'TestingUpiIndiaPlugin',
      transactionNote: 'Not actual. Just an example.',
      amount:double.parse(widget.controller!.moneyController.text,),
    );
  }

  Widget displayUpiApps() {
    if (apps == null)
      return Center(child: CircularProgressIndicator());
    else if (apps!.length == 0)
      return   MyUpi();
    else
      return Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Wrap(
            children: apps!.map<Widget>((UpiApp app) {
              return GestureDetector(
                onTap: () {
                  _transaction = initiateTransaction(app);
                  setState(() {});
                },
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.memory(
                        app.icon,
                        height: 60,
                        width: 60,
                      ),
                      Text(app.name),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      );
  }

  String _upiErrorHandler(error) {
    switch (error) {
      case UpiIndiaAppNotInstalledException:
        return 'Requested app not installed on device';
      case UpiIndiaUserCancelledException:
        return 'You cancelled the transaction';
      case UpiIndiaNullResponseException:
        return 'Requested app didn\'t return any response';
      case UpiIndiaInvalidParametersException:
        return 'Requested app cannot handle the transaction';
      default:
        return 'An Unknown error has occurred';
    }
  }

  Future<void> _checkTxnStatus(String status,String txnId) async {
    switch (status) {
      case UpiPaymentStatus.SUCCESS:
        var withdrawData = {
      "points": widget.controller!.moneyController.text,
      "trans_status": status,
      "trans_id": txnId
    };

    // Call the addFund method
  await widget.controller!.addFund(withdrawData);

        break;
      case UpiPaymentStatus.SUBMITTED:
        print('Transaction Submitted');
        break;
      case UpiPaymentStatus.FAILURE:
        print('Transaction Failed');
        break;
      default:
        print('Received an Unknown transaction status');
    }
  }

  Widget displayTransactionData(title, body) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("$title: ", style: header),
          Flexible(
              child: Text(
            body,
            style: value,
          )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return   SingleChildScrollView(
      child: SizedBox(
        height: 500,
       
        child: Column(
            children: <Widget>[
              Expanded(
                child: displayUpiApps(),
              ),
              Expanded(
                child: FutureBuilder(
                  future: _transaction,
                  builder: (BuildContext context, AsyncSnapshot<UpiResponse> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            _upiErrorHandler(snapshot.error.runtimeType),
                            style: header,
                          ), // Print's text message on screen
                        );
                      }
        
                      // If we have data then definitely we will have UpiResponse.
                      // It cannot be null
                      UpiResponse _upiResponse = snapshot.data!;
        
                      // Data in UpiResponse can be null. Check before printing
                      String txnId = _upiResponse.transactionId ?? 'N/A';
                      String resCode = _upiResponse.responseCode ?? 'N/A';
                      String txnRef = _upiResponse.transactionRefId ?? 'N/A';
                      String status = _upiResponse.status ?? 'N/A';
                      String approvalRef = _upiResponse.approvalRefNo ?? 'N/A';
                      _checkTxnStatus(status,txnId);
        
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                              displayTransactionData('Status', status.toUpperCase()),
                            displayTransactionData('Transaction Id', txnId),
                            displayTransactionData('Response Code', resCode),
                            displayTransactionData('Reference Id', txnRef),
                          
                            displayTransactionData('Approval No', approvalRef),
                          ],
                        ),
                      );
                    } else
                      return Center(
                        child: Text(''),
                      );
                  },
                ),
              )
            ],
          ),
      ),
    );
  
  }



}

