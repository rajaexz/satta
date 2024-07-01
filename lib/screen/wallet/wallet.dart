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
    return SingleChildScrollView(
      child: Container(
        margin: GlobleglobleMargin.globleMargin,
        alignment: Alignment.center,
        child: Column(
          children: [
            Text("₹1", style: CustomStyles.headerTextStyle),
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
                 
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
