// import 'dart:convert';

// import 'package:winner11/screen/component/custom_toaster.dart';
// import 'package:winner11/screen/component/profileContainer.dart';
// import 'package:winner11/screen/component/trancetionId.dart';
// import 'package:winner11/utilis/fontstyle.dart';
// import 'package:winner11/utilis/globlemargin.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:winner11/screen/component/darkmode.dart';
// import 'package:winner11/screen/header/appbar.dart';
// import 'package:winner11/service/authapi.dart';
// import 'package:winner11/utilis/AllColor.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:url_launcher/url_launcher.dart';

// void launchUPIUrl(paymentLink) async {
//    var demolink =  paymentLink["data"]["App"];
//   if (await canLaunchUrl(Uri.parse(demolink))) {
//     await launchUrl(Uri.parse(demolink));
//   } else {
//     print('Could not launch payment link: $paymentLink');
//   }
// }
// bool loading =  true;
// class ValueController extends GetxController {
//   RxInt maoney = 0.obs;

//   void changeValue(int newValue) {
//     maoney.value = newValue;
//   }
// }

// final String baseUrl = "https://payin.gamegateway.online/v3";
// var txnId = "";
//   final String userKey = "KBSb1ce6bcf18";
//   final String userToken = "f06675fb4332360c28bcb7232abc57bb";
//   String AllAccesGeneratedToken = "";

//  final ValueController valueController = Get.put(ValueController());



// class Addmoney extends StatefulWidget {
//   Addmoney({Key? key}) : super(key: key);

//   static const routeName = 'addmoney';

//   @override
//   _AddmoneyState createState() => _AddmoneyState();
// }
//   generateToken() async {
//     try {
//       final response = await Dio().post(
//         '$baseUrl/generateToken',
//         options: Options(
//           headers: {'Content-Type': 'application/json'},
//         ),
//         data: {'userKey': userKey, 'userToken': userToken},
//       );

//       if (response.statusCode == 200) {
//         var data = response.data;
//         var generatedToken = jsonDecode(data);

//         AllAccesGeneratedToken = generatedToken['data']['token'];

//         try {
//           var PaymentLink = await generatePaymentLink(
//             userKey: userKey,
//             userToken: userToken,
//             generatedToken: generatedToken['data']['token'],
//           );
//        print(PaymentLink);
//           // Check if the response indicates success
//           if (PaymentLink['status'] == "true") {
//             return PaymentLink;
//           } else {
//             // Print or log the error details
//             print("Error: ${PaymentLink['error']}");

//             return PaymentLink['error'];
//             // Handle the error as needed
//           }
//         } catch (e) {
//           // Handle unexpected errors
//           print("Unexpected error: $e");
//         }
//       } else {
//         return "not-good";
//       }
//     } catch (e) {
//       return "error: $e";
//     }
//   }
//   generatePaymentLink({userKey, userToken, generatedToken}) async {
//     try {
//       final response = await Dio().post(
//         '$baseUrl/generatePaymentLink',
//         options: Options(
//           headers: {'Content-Type': 'application/json'},
//         ),
//         data: {
//           'userKey': userKey,
//           'userToken': userToken,
//           'genrateToken': generatedToken.toString(),
//           'amount': valueController.maoney.toString(), // Use the entered amount
//           'option': 'INTENT',
//           'orderId': generateOrderId().toString(),
//         },
//       );
//    var data = jsonDecode(response.data);

//       if (response.statusCode == 200) {
     
//         return data;
//       } else {
//         return data["status"];
//       }
//     } catch (e) {
//       return "error: $e";
//     }
//   }

//  checkPaymentStatus({
//     userKey,
//     userToken,
//     generatedToken,

//     allData,
//   }) async {
//     String txnId = allData["data"]["txnId"];
//     try {
//       final response = await Dio().post(
//         '$baseUrl/checkPayinstatus',
//         options: Options(
//           headers: {'Content-Type': 'application/json'},
//         ),
//         data: {
//           'userKey': userKey,
//           'userToken': userToken,
//           'orderId': allData["data"]["orderId"],
//           'txnId': allData["data"]["txnId"],
//           'genrateToken': generatedToken,
//         },
//       );

//       if (response.statusCode == 200) {
//         var data = jsonDecode(response.data);
//         // Set checkStatusResult as Map<String, dynamic>
//        var checkStatusResult = data['data'];
//         if (checkStatusResult["status"] == "SUCCESS") {
//           return checkStatusResult;
//         }
//       } else {
//         return {"status": "not-good"};
//       }
//     } catch (e) {
//       print('Error: $e');
//       return {"status": "not-good"};
//     }
//   }

// class _AddmoneyState extends State<Addmoney> {
 
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(title: "Wallet"),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Obx(() {
//    return   Container(
//     margin: GlobleglobleMargin.globleMargin,
//      child: Container(
//           margin: EdgeInsets.only(top: 100),
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//           decoration: BoxDecoration(
//             shape: BoxShape.rectangle,
//        color: themeController.isLightMode.value ? myColorWhite : myColor,
//             border: Border.all(color:myColorRed), // Replace with your border style
//             borderRadius: BorderRadius.circular(10), // Replace with your border radius
          
//           ),
//           child: TextFormField(
//             decoration: InputDecoration(
//                 hintText: "Please Enter Amount",
//             ),
//             controller: TextEditingController(
//                         text: valueController.maoney.toString()),
//               onSaved: (newValue) {
//                       valueController.maoney.value =  int.tryParse(newValue!)!;
//                     },
//             textAlign: TextAlign.start,
//             keyboardType:TextInputType.number ,
//             style: TextStyle(fontSize: 16), // Replace with your text style
//             autofocus: true,
//             cursorColor: Colors.black, // Replace with your cursor color
//           ),
//         ),
//    );
               
//               }),
//               Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       CustomRupess(
//                           () => valueController.changeValue(500), "500"),
//                       CustomRupess(
//                           () => valueController.changeValue(1000), "1000"),
//                       CustomRupess(
//                           () => valueController.changeValue(1500), "1500")
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       CustomRupess(
//                           () => valueController.changeValue(2000), "2000"),
//                       CustomRupess(
//                           () => valueController.changeValue(2500), "2500"),
//                       CustomRupess(
//                           () => valueController.changeValue(3000), "3000")
//                     ],
//                   )
//                 ],
//               ),
//               GestureDetector(
//                 onTap: () async {
//              try{
//                   var LinkData = await generateToken();

//             final store = await SharedPreferences.getInstance();
//               final id = store.getString("userId");
//               final ApiService apiService = ApiService();

//                var data = await checkPaymentStatus(
//                 generatedToken:AllAccesGeneratedToken,
//                 userToken: userToken,
//                 userKey: userKey,
//                 allData:LinkData,
//               );

 
//               // Check if payment was successful
//               if (data["status"] == "SUCCESS") {
//                 CustomToaster.showSuccess(context, "SUCCESS");
//                 var data = await apiService.userallType(data: {
//                   "id": id,
//                   "trans_id": txnId,
//                   "money": valueController.maoney,
//                   "payment_status": "SUCCESS"
//                 }, uri: "/add_money");
//               } else {
//                 CustomToaster.showWarning(context, "${data["status"]}");
//               }

//               ////////////////////////////////////////////
//                if(LinkData["status"] == "true" ){
             
//                           _showBottomSheet(
//                       context: context,
//                       LinkData: LinkData,
//                     );
//                }else{
            
//                   CustomToaster.showWarning(context, "Something want wrrog in pamentgetway ${LinkData["status"]} ");
//                }
//              }catch(e){
//               loading = false ;
//         print("wrrog");
//              }
//                 },
//                 child: Obx(()=>Container(
//                   width: 450,
//                   height: 50,
//                   margin:
//                       EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.5),
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                      color: themeController.isLightMode.value ? myColor :myColorWhite  ,
  
//                     borderRadius: BorderRadius.circular(5),
//                   ),
//                   padding:
//                       EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.5),
//                   child: Text('Pay',style:TextStyle(   color: themeController.isLightMode.value ?  myColorWhite: myColor  ,
//   )),
//                 )),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _showBottomSheet(
//       {required BuildContext context,
//       LinkData,
//   }) {
//     showModalBottomSheet(
//       context: context,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(16.0),
//           topRight: Radius.circular(16.0),
//         ),
//       ),
//       builder: (BuildContext context) {
//         return FractionallySizedBox(
//           heightFactor: 0.8,
//           child: MyUpi(
           
//               allData: LinkData,
              
//               ),
//         );
//       },
//     );
//   }
// }

// class CustomRupess extends StatelessWidget {
//   final Function setStateCallback;
//   var paisa;
//   CustomRupess(this.setStateCallback, this.paisa);
//   final ThemeController themeController = Get.put(ThemeController());
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: InkWell(
//           onTap: () {
//             setStateCallback();
//           },
//           child: Obx(
//             () => Container(
//               width: 50,
//               height: 50,
//               margin: const EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                 shape: BoxShape.rectangle,
//                 color:
//                     themeController.isLightMode.value ? myColorWhite : myColor,
//                 border: Border.all(
//                   color: Colors.grey,
//                   width: 1,
//                   style: BorderStyle.solid,
//                 ),
//                 borderRadius: const BorderRadius.all(
//                   Radius.circular(5),
//                 ),
//               ),
//               child: Center(child: Text(this.paisa)),
//             ),
//           )),
//     );
//   }
// }

// class MyUpi extends StatefulWidget {

//   var allData;
 
//   MyUpi(
//       {Key? key,
   
//       required this.allData,
// })
//       : super(key: key);

//   @override
//   State<MyUpi> createState() => _MyUpiState();
// }

// class _MyUpiState extends State<MyUpi> {
  
//   final ValueController valueController = Get.put(ValueController());
//   @override
//   void initState() {
//     super.initState();
  
//   }

 

//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       children: [
//         SizedBox(height: 20),
//         SizedBox(height: 20),
//         Center(
//           child: ElevatedButton(
//             style: ButtonStyle(
//               backgroundColor: MaterialStateProperty.resolveWith<Color>(
//                 (Set<MaterialState> states) {
//                   // Use the specified color for the normal state
//                   if (states.contains(MaterialState.pressed)) {
//                     // Use a different color when the button is pressed
//                     return myColor;
//                   } else {
//                     // Use the default color for other states
//                     return myColorWhite;
//                   }
//                 },
//               ),
//             ),
//             onPressed: () async {
         
//                 launchUPIUrl(widget.allData);
             
//             },
//             child: Image.asset(
//               'assets/Paytm.png', // Replace 'your_image.png' with the actual path to your image asset
//               width: 100.0, // Adjust the width as needed
//               height: 100.0, // Adjust the height as needed
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }





