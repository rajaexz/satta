// views/win_history_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:winner11/screen/tap1/hisrotry/controller/WinSartlineBidHistoryController.dart';
import 'package:winner11/screen/tap1/hisrotry/widget/WinHistoryCard.dart';
import '../../../network/network_config.dart';

class WinHistoryPage extends StatelessWidget {
  final WinHistoryController controller =
      Get.put(WinHistoryController(NetworkProvider()));

  @override
  Widget build(BuildContext context) {
    // Initialize data fetch
    controller.fetchWinHistory();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Win History'),
        actions: [
          IconButton(
            icon: const Icon(Icons.date_range),
            onPressed: () async {
              DateTimeRange? picked = await showDateRangePicker(
                context: context,
                firstDate: DateTime.now(),
                lastDate: DateTime.now(),
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
          return const Center(child: CircularProgressIndicator());
        } else if (controller.winHistoryList == null ||
            controller.winHistoryList.isEmpty) {
          return const Center(child: Text('No Data Available'));
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
                  itemCount: controller.winHistoryList.length,
                  itemBuilder: (context, index) {
                    final win = controller.winHistoryList[index];
                    return WinHistoryCard(win: win);
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
