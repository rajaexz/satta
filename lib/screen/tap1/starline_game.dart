import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vibration/vibration.dart';
import 'package:winner11/screen/tap1/hisrotry/starlinebithestory.dart';

import '../../utilis/AllColor.dart';
import '../../utilis/fontstyle.dart';
import '../header/appbar.dart';
import '../tap2/myGame.dart';
import 'controller/StarlineGame_controller.dart';
import 'hisrotry/winStarlinehistory.dart';

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
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Get.to(BidHistoryPage());
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 5),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  decoration: BoxDecoration(color: myColorRed),
                  child: const Text(
                    "Star Line History",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(WinHistoryPage());
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 5),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  decoration: BoxDecoration(color: myColorRed),
                  child: const Text(
                    "Star Line Win History",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: Get.height * 0.2,
            child: ListView.builder(
              itemCount: controller.starlineResponse.value.starlineRates.length,
              itemBuilder: (context, index) {
                final item =
                    controller.starlineResponse.value.starlineRates[index];

                return Card(
                  elevation: 4.0, // Adjust the elevation as needed
                  margin: EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 16.0), // Adjust the margin as needed
                  child: Padding(
                    padding:
                        EdgeInsets.all(16.0), // Adjust the padding as needed
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start, // Align items to the start
                      children: [
                        Row(
                          children: [
                            Icon(Icons.attach_money,
                                color: Colors.black), // Icon for cost amount
                            SizedBox(
                                width:
                                    8.0), // Add spacing between the icon and text
                            Text(
                              item.costAmount,
                              style: TextStyle(
                                fontSize: 18.0, // Adjust the font size
                                fontWeight:
                                    FontWeight.bold, // Make the text bold
                                color: Colors.black, // Set the text color
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.0), // Add spacing between the rows
                        Row(
                          children: [
                            Icon(Icons.person,
                                color: Colors.grey[700]), // Icon for name
                            SizedBox(
                                width:
                                    8.0), // Add spacing between the icon and text
                            Text(
                              item.name,
                              style: TextStyle(
                                fontSize: 16.0, // Adjust the font size
                                fontWeight:
                                    FontWeight.normal, // Set the text weight
                                color: Colors.grey[700], // Set the text color
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                            height: 8.0), // Add spacing between the rows
                        Row(
                          children: [
                            Icon(Icons.money_off,
                                color: Colors.green), // Icon for earning amount
                            const SizedBox(
                                width:
                                    8.0), // Add spacing between the icon and text
                            Text(
                              item.earningAmount,
                              style: const TextStyle(
                                fontSize: 16.0, // Adjust the font size
                                fontWeight:
                                    FontWeight.normal, // Set the text weight
                                color: Colors.green, // Set the text color
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
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
                  margin: const EdgeInsets.only(top: 20),
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 5, right: 10, left: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.white
                        : Colors.grey[800],
                    boxShadow: [
                      Theme.of(context).brightness == Brightness.light
                          ? BoxShadow(color: Colors.black26, blurRadius: 5)
                          : BoxShadow(color: Colors.black54, blurRadius: 5),
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 30,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  Theme.of(context).brightness ==
                                          Brightness.light
                                      ? "assets/banner.png"
                                      : "assets/banner-dark.png",
                                ),
                                fit: BoxFit.fill,
                                alignment: Alignment.centerRight,
                              ),
                            ),
                            child: Container(
                              width: 260,
                              child: Text(
                                item.name,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item.play ? "Market Open " : "Market Colse ",
                            style: CustomStyles.textExternel,
                          ),
                          TextButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  item.play
                                      ? const Color.fromARGB(255, 26, 113, 29)
                                      : Color.fromARGB(255, 199, 44, 44)),
                              padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(
                                    horizontal: 35, vertical: 10),
                              ),
                            ),
                            isSemanticButton: true,
                            onPressed: () {
                              item.play
                                  ? Get.to(GridViewWidget(
                                      gameData: item,
                                      whicGameName: "star_line"))
                                  : null;

                              if (!item.play) {
                                Vibration.vibrate();

                                Get.snackbar('Market is Close ', "");
                              }
                            },
                            child: Text(
                              item.play ? "Open" : "Close",
                              style: CustomStyleswhite.header2TextStyle,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Result: ${item.result}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                );

                //  Container(
                //   height: 150,
                //   margin: const EdgeInsets.all(9),
                //   padding: const EdgeInsets.all(10),
                //   decoration: BoxDecoration(
                //     border: Border.all(color: Colors.grey), // Example border
                //     borderRadius: BorderRadius.circular(8), // Example radius
                //     color: Get.isDarkMode
                //         ? Colors.grey[800]
                //         : Colors.white, // Example colors
                //     boxShadow: [
                //       BoxShadow(
                //         color:
                //             Get.isDarkMode ? Colors.black54 : Colors.grey[300]!,
                //         blurRadius: 4,
                //         offset: Offset(2, 2),
                //       ),
                //     ],
                //   ),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Text(
                //         item.name,
                //         style:
                //             const TextStyle(fontSize: 10, color: Colors.grey),
                //       ),
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                //               Text(
                //                 item.play.toString(),
                //                 style: CustomStyles.smallTextStyle,
                //               ),
                //             ],
                //           ),
                //           Column(
                //             children: [
                //               Text(
                //                 "₹${item.name}",
                //                 style: CustomStyles.textExternel,
                //               ),
                //             ],
                //           ),
                //         ],
                //       ),
                //     ],
                //   ),
                // );
              },
            ),
          ),
        ],
      );
    }
  }
}
