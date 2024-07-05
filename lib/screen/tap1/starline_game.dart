import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vibration/vibration.dart';

import '../../main.dart';
import '../../utilis/AllColor.dart';
import '../../utilis/borderbox.dart';
import '../../utilis/boxSpace.dart';
import '../../utilis/fontstyle.dart';
import '../../utilis/globlemargin.dart';
import '../header/appbar.dart';
import '../tap2/myGame.dart';
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

                return
                
                    Container(
                    height: 200,
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
                              "Open : ${item.play}",
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
                                !item.play? Get.to(GridViewWidget(playOrNot:item.play)) : null;

                                  if ( !item.play ) {
              Vibration.vibrate();
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
