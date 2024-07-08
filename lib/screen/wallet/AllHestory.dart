import 'package:get/get.dart';
import 'package:winner11/screen/component/iconStatus.dart';
import 'package:winner11/screen/header/appbar.dart';
import 'package:winner11/service/authapi.dart';
import 'package:winner11/utilis/AllColor.dart';
import 'package:winner11/utilis/borderbox.dart';
import 'package:winner11/utilis/boxSpace.dart';
import 'package:winner11/utilis/fontstyle.dart';
import 'package:winner11/utilis/globlemargin.dart';
import 'package:flutter/material.dart';
import 'package:winner11/screen/wallet/walletHestory.dart';

import 'wallet_controller.dart/all_hestory_controller.dart';

class AllHestory extends GetView<AllHestoryController> {
  const AllHestory({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    Get.put(AllHestoryController());

    return Scaffold(
      appBar: CustomAppBar(title: "Wallet History"),
      body: GetBuilder<AllHestoryController>(
        init: controller,
        builder: (controller) => AllHestoryView(
          controller: controller,
        ),
      ),
    );
  }
}

class AllHestoryView extends StatelessWidget {
  AllHestoryController? controller;
  AllHestoryView({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    if (controller!.isLoading.value) {
      return Center(child: CircularProgressIndicator());
    } else if (controller!.withdrawData.value == null) {
      return Center(child: Text('Error fetching data'));
    } else {
      return Column(
        children: [
          Text(
              'Available Points: ${controller!.withdrawData.value!.availablePoints ?? ""}'),
          const SizedBox(height: 10),
          Text(
              'Withdraw Open Time: ${controller!.withdrawData.value!.withdrawOpenTime ?? ""}'),
          const SizedBox(height: 10),
          Text(
              'Withdraw Close Time: ${controller!.withdrawData.value!.withdrawCloseTime ?? ""}'),
          const SizedBox(height: 20),
          Container(
              height: Get.height * 0.8,
              margin: GlobleglobleMargin.Margin10H,
              child: ListView.builder(
                itemCount: controller!.withdrawData.value!.statement.length,
                itemBuilder: (context, index) {
                  final item = controller!.withdrawData.value!.statement[index];

                    return Container(
                      margin: const EdgeInsets.all(9),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: border,
                        borderRadius: boRadiusAll,
                        color: themeController.isLightMode.value
                            ? myColorWhite
                            : myColor,
                        boxShadow: [
                          themeController.isLightMode.value ? boxdark : boxshadow2
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            item.createdAt,
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
                                    getStatusIcon(item.transStatus),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  Text(
                                    item.transType.toString(),
                                    style: CustomStyles.textExternel,
                                  ),
                                  Text(
                                    " ₹${item.points.toString()}",
                                    style: CustomStyles.textExternel,
                                  ),
                                ],
                              )
                            ],
                          ),
                          Text(
                            "${item.transStatus}".toString(),
                            style: TextStyle(color: myColorgreen),
                          ),
                        
                        ],
                      ),
                    );
                },
              )),
        ],
      );
    }
  }
}
