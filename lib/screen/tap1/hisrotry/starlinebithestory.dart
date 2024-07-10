import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winner11/network/network_config.dart';
import 'package:winner11/screen/tap1/hisrotry/controller/SartlineBidHistoryController.dart';
import 'package:intl/intl.dart';
import 'package:winner11/screen/tap1/hisrotry/widget/bitcart.dart';

class BidHistoryPage extends StatelessWidget {
  final BidHistoryController controller =
      Get.put(BidHistoryController(NetworkProvider()));

  BidHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bid History'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: controller.fromDate.value,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );
                        if (pickedDate != null) {
                          controller.fromDate.value = pickedDate;
                        }
                      },
                      child: Obx(() => Text(
                            'From: ${controller.fromDate.value.toIso8601String().split('T').first}',
                          )),
                    ),
                    TextButton(
                      onPressed: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: controller.toDate.value,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );
                        if (pickedDate != null) {
                          controller.toDate.value = pickedDate;
                        }
                      },
                      child: Obx(() => Text(
                            'To: ${controller.toDate.value.toIso8601String().split('T').first}',
                          )),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Obx(() {
                  return controller.isLoading.value
                      ? const Center(child: CircularProgressIndicator())
                      : controller.bidHistoryList.value.data.isEmpty
                          ? const Center(child: Text('No Data Available'))
                          : ListView.builder(
                              itemCount:
                                  controller.bidHistoryList.value.data.length,
                              itemBuilder: (context, index) {
                                final item =
                                    controller.bidHistoryList.value.data[index];

                                return Container(
                                  height: 150,
                                  margin: const EdgeInsets.all(9),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.gameType,
                                        style: const TextStyle(
                                          fontSize: 10,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                item.biddedAt,
                                                style: const TextStyle(
                                                    fontSize: 12),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                item.leftDigit,
                                                style: const TextStyle(
                                                    fontSize: 12),
                                              ),
                                              Text(
                                                item.rightDigit,
                                                style: const TextStyle(
                                                    fontSize: 12),
                                              ),
                                              Text(
                                                "${item.bidPoints}",
                                                style: const TextStyle(
                                                    fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        item.gameName,
                                        style: const TextStyle(
                                            color: Colors.green),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                }),
              ),
            ],
          );
        }
      }),
    );
  }
}
