// ignore: file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:winner11/screen/tap1/hisrotry/controller/GaliDisawarController.dart';

class Galibithestoryview extends StatelessWidget {
  final Galidisawarcontroller controller = Get.put(Galidisawarcontroller());

  Galibithestoryview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gali Disawar Bid History'),
      ),
      body: Column(
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
                ElevatedButton(
                  onPressed: () {
                    controller.fetchBitStatement();
                  },
                  child: const Text('Fetch Data'),
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else if (controller.games == null ||
                  controller.games!.data.isEmpty) {
                return const Center(child: Text('No Data Available'));
              } else {
                return ListView.builder(
                  itemCount: controller.games!.data.length,
                  itemBuilder: (context, index) {
                    final item = controller.games!.data[index];

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
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.biddedAt.toString(),
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    item.leftDigit.toString(),
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                  Text(
                                    item.rightDigit.toString(),
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                  Text(
                                    " ₹${item.bidPoints.toString()}",
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            item.gameName.toString(),
                            style: const TextStyle(color: Colors.green),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
