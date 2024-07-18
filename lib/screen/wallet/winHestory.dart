import 'package:get/get.dart';
import 'package:Billa/screen/component/iconStatus.dart';
import 'package:Billa/screen/header/appbar.dart';
import 'package:Billa/screen/wallet/wallet_controller.dart/bit_hestory_controller.dart';
import 'package:Billa/screen/wallet/wallet_controller.dart/win_hestory_controller.dart';

import 'package:Billa/utilis/AllColor.dart';
import 'package:Billa/utilis/borderbox.dart';
import 'package:Billa/utilis/boxSpace.dart';
import 'package:Billa/utilis/fontstyle.dart';
import 'package:Billa/utilis/globlemargin.dart';
import 'package:flutter/material.dart';
import 'package:Billa/screen/wallet/walletHestory.dart';

class WinHestory extends GetView<WinHestoryController> {
  const WinHestory({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    Get.put(WinHestoryController());

    return Scaffold(
      appBar: CustomAppBar(title: "Win History"),
      body: GetBuilder<WinHestoryController>(
        init: controller,
        builder: (controller) => WinHestoryView(
          controller: controller,
        ),
      ),
    );
  }
}

class WinHestoryView extends StatelessWidget {
  final WinHestoryController controller;

  WinHestoryView({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (controller.wingames.isEmpty && controller.isLoading.value) {
      return Center(child: Text('Data is not available  empty'));
    } else {
      return Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: controller.wingames.length,
              itemBuilder: (context, index) {
                final item = controller.wingames[index];

                return Container(
                  height: 150,
                  margin: const EdgeInsets.all(9),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white, // Adjust colors based on your theme
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.gameType,
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.gameType,
                                style: CustomStyles.smallTextStyle,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "Close Panna: ${item.closePanna}",
                                style: CustomStyles.textExternel,
                              ),
                              Text(
                                "Close Digit: ${item.closeDigit}",
                                style: CustomStyles.textExternel,
                              ),
                              Text(
                                "₹${item.bidPoints}",
                                style: CustomStyles.textExternel,
                              ),
                            ],
                          ),
                          Text(
                            "Win Points: ${item.winPoints}",
                            style: TextStyle(color: Colors.green),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      );
    }
  }
}
