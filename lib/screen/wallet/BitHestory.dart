import 'package:get/get.dart';
import 'package:winner11/screen/header/appbar.dart';
import 'package:winner11/screen/wallet/wallet_controller.dart/bit_hestory_controller.dart';

import 'package:winner11/utilis/AllColor.dart';
import 'package:winner11/utilis/borderbox.dart';
import 'package:winner11/utilis/boxSpace.dart';
import 'package:winner11/utilis/fontstyle.dart';
import 'package:winner11/utilis/globlemargin.dart';
import 'package:flutter/material.dart';
import 'package:winner11/screen/wallet/walletHestory.dart';

import 'wallet_controller.dart/all_hestory_controller.dart';

class BitHestory extends GetView<BitHestoryController> {
  const BitHestory({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    Get.put(BitHestoryController());

    return Scaffold(
      appBar: CustomAppBar(title: " Bit Hestory"),
      body: GetBuilder<BitHestoryController>(
        init: controller,
        builder: (controller) => BitHestoryView(
          controller: controller,
        ),
      ),
    );
  }
}

class BitHestoryView extends StatelessWidget {
  final BitHestoryController? controller;

  BitHestoryView({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller!.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      } else if (controller!.games.isEmpty) {
        return Center(child: Text('No Data Available'));
      } else {
        return Column(
          children: [
            Container(
                height: Get.height * 0.8,
                margin: GlobleglobleMargin.Margin10H,
                child: ListView.builder(
                  itemCount: controller!.games.length,
                  itemBuilder: (context, index) {
                    final item = controller!.games[index];

                    return Container(
                      height: 150,
                      margin: const EdgeInsets.all(9),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: border,
                        borderRadius: boRadiusAll,
                        color: themeController.isLightMode.value
                            ? myColorWhite
                            : myColor,
                        boxShadow: [
                          themeController.isLightMode.value
                              ? boxdark
                              : boxshadow2
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            item.gameType,
                            style: TextStyle(fontSize: 10, color: myColorGray),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    size10w,
                                    Column(
                                      children: [
                                        //time
                                        Text(
                                          item.biddedAt.toString(),
                                          style: CustomStyles.smallTextStyle,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  Text(
                                    item.closePanna.toString(),
                                    style: CustomStyles.textExternel,
                                  ),
                                  Text(
                                    item.closeDigit.toString(),
                                    style: CustomStyles.textExternel,
                                  ),
                                  Text(
                                    " ₹${item.bidPoints.toString()}",
                                    style: CustomStyles.textExternel,
                                  ),
                                ],
                              )
                            ],
                          ),
                          Text(
                            item.gameName.toString(),
                            style: TextStyle(color: myColorgreen),
                          )
                        ],
                      ),
                    );
                  },
                )),
          ],
        );
      }
    });
  }
}
