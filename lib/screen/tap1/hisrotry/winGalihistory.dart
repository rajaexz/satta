// views/win_history_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:Billa/screen/tap1/hisrotry/controller/WinGaliHistoryController.dart';
import 'package:Billa/screen/tap1/hisrotry/widget/WinHistoryCard.dart';
import '../../../network/network_config.dart';

class GaliWinHistoryPage extends StatelessWidget {
  final WinGaliHistoryController controller =
      Get.put(WinGaliHistoryController(NetworkProvider()));

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
                firstDate: DateTime(2000), // Allow earlier dates
                lastDate: DateTime.now(),
                initialDateRange: DateTimeRange(
                  start: controller.fromDate.value,
                  end: controller.toDate.value,
                ),
              );
              if (picked != null) {
                controller.updateDateRange(picked.start, picked.end);
              }
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.winHistoryList.value.data.isEmpty) {
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
                  itemCount: controller.winHistoryList.value.data.length,
                  itemBuilder: (context, index) {
                    final win = controller.winHistoryList.value.data[index];
                    // return WinHistoryCardR(win: win);
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
