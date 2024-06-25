import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winner11/screen/wallet/walletHestory.dart';
import 'package:winner11/service/authapi.dart';
import 'package:winner11/utilis/AllColor.dart';
import 'package:winner11/utilis/boxSpace.dart';
import 'package:winner11/utilis/fontstyle.dart';
import 'package:winner11/utilis/globlemargin.dart';

class MyWallet extends StatefulWidget {
  const MyWallet({super.key});

  @override
  State<MyWallet> createState() => _MyWalletState();
}

class _MyWalletState extends State<MyWallet> {
  @override
  Widget build(BuildContext context) {
    final ApiService apiService = ApiService();
    return SingleChildScrollView(
      child: Container(
        margin: GlobleglobleMargin.globleMargin,
        alignment: Alignment.center,
        child: Column(
          children: [
          FutureBuilder(
  future: apiService.userAllDoc(uri: "/fetch_balance"),
  builder: (context, snapshot) {
    try {
      if (snapshot.connectionState == ConnectionState.waiting) {
        // While the future is still running, display a loading indicator
        return const CircularProgressIndicator();
      } else if (snapshot.hasError) {
        // If an error occurred, display an error message
        return Text('Error: ${snapshot.error}');
      } else {
        final dynamic data = snapshot.data;
        if (data != null && data is Map<String, dynamic>) {
          final dynamic balance = data['data']?['balance'];

          if (balance != null) {
            return Text("₹$balance", style: CustomStyles.headerTextStyle);
          } else {
            return Text('${data['data']["error"]}');
          }
        } else {
          return Text('0', style: CustomStyles.headerTextStyle);
        }
      }
    } catch (e) {
      // Handle exceptions here (e.g., log the error)
      print('Exception: $e');
      return Text('An unexpected error occurred', style: CustomStyles.headerTextStyle);
    }
  },
),
    ElevatedButton(
              onPressed: () {
                Get.toNamed("/addMoney");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    myColorgreen, // Set the button background color to green
              ),
              child: Text(
                'Add Cash',
                style: CustomStyleswhite.headerTextStyle,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(),
                Column(
                  children: [
                    Row(
                      children: [
                    
                        size10w,
                        const Icon(
                          Icons.info_outline,
                          size: 15,
                        )
                      ],
                    )
                  ],
                ),
            
                size20h,
                const Myhestory(
                  data: [],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
