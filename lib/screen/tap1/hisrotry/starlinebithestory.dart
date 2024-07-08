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
        actions: [
          IconButton(
            icon: const Icon(Icons.date_range),
            onPressed: () async {
              DateTimeRange? picked = await showDateRangePicker(
                context: context,
                firstDate: DateTime(2011),
                lastDate: DateTime(2024),
                initialDateRange: DateTimeRange(
                  start: controller.fromDate.value,
                  end: controller.toDate.value,
                ),
              );
              if (picked != null && picked.start != picked.end) {
                controller.updateDateRange(picked.start, picked.end);
              }
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Showing results from ${DateFormat('yyyy-MM-dd').format(controller.fromDate.value)} to ${DateFormat('yyyy-MM-dd').format(controller.toDate.value)}',
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.bidHistoryList.length,
                  itemBuilder: (context, index) {
                    final bid = controller.bidHistoryList[index];
                    return BidHistoryCard(bid: bid);
                  },
                ),
              ),
            ],
          );
        }
      }),
    );
  }
}
