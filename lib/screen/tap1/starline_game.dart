import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../main.dart';
import '../../utilis/AllColor.dart';
import '../../utilis/borderbox.dart';
import '../../utilis/boxSpace.dart';
import '../../utilis/fontstyle.dart';
import '../../utilis/globlemargin.dart';
import '../header/appbar.dart';
import '../wallet/wallet_controller.dart/bit_hestory_controller.dart';
import 'controller/StarlineGame_controller.dart';

class StarlineGamePage extends GetView<StarlineGameController> {
  const StarlineGamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use Get.put here to ensure the controller is available for GetView
    final controller = Get.put(StarlineGameController());

    return Scaffold(
      appBar: CustomAppBar(title: "Starline Game"),
      body: GetBuilder<StarlineGameController>(
        init: controller,
        builder: (controller) => StarlineGameView(controller: controller),
      ),
    );
  }
}

class StarlineGameView extends StatelessWidget {
  final StarlineGameController controller;
  StarlineGameView({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (controller.isLoading.value) {
      return const Center(child: CircularProgressIndicator());
    } else if (controller.starlineResponse.value.starlineGames.isEmpty) {
      return const Center(child: Text('Error fetching data'));
    } else {
      return Column(
        children: [
          Container(
            height: Get.height * 0.2,
            child: ListView.builder(
              itemCount: controller.starlineResponse.value.starlineRates.length,
              itemBuilder: (context, index) {
                final item =
                    controller.starlineResponse.value.starlineRates[index];

                return Column(
                  children: [
                    Text(item.costAmount),
                    Text(item.name),
                    Text(item.earningAmount),
                  ],
                );
              },
            ),
          ),
          Container(
            height: Get.height * 0.6,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: ListView.builder(
              itemCount: controller.starlineResponse.value.starlineGames.length,
              itemBuilder: (context, index) {
                final item =
                    controller.starlineResponse.value.starlineGames[index];

                return Container(
                  height: 150,
                  margin: const EdgeInsets.all(9),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey), // Example border
                    borderRadius: BorderRadius.circular(8), // Example radius
                    color: Get.isDarkMode
                        ? Colors.grey[800]
                        : Colors.white, // Example colors
                    boxShadow: [
                      BoxShadow(
                        color:
                            Get.isDarkMode ? Colors.black54 : Colors.grey[300]!,
                        blurRadius: 4,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style:
                            const TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.play.toString(),
                                style: CustomStyles.smallTextStyle,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "₹${item.name}",
                                style: CustomStyles.textExternel,
                              ),
                            ],
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
