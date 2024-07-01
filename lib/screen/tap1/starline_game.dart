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

  Widget build(BuildContext context) {
    Get.put(StarlineGameController());

    return Scaffold(
      appBar: CustomAppBar(title:" Starline Game"),
      body: GetBuilder<StarlineGameController>(
        init: controller,
        builder: (controller) => StarlineGameView(
          controller: controller,
        ),
      ),
    );
  }
}

class StarlineGameView extends StatelessWidget {
  StarlineGameController? controller;
  StarlineGameView({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    if (controller!.isLoading.value) {
      return Center(child: CircularProgressIndicator());
    } else if (controller!.starlineResponse.value.starlineGames.isEmpty ) {
      return Center(child: Text('Error fetching data'));
    } else {
      return  controller!.isLoading.value ? 
       Column(
        children: [

   Container(
              height: Get.height * 0.2,
   child: ListView.builder(
                  itemCount: controller!.starlineResponse.value!.starlineRates.length,
                  itemBuilder: (context, index) {
                    final item = controller!.starlineResponse.value!.starlineRates[index];

                    return   Column(
                      children: [
                        Text(item.costAmount),
                         Text(item.name),
                         Text(item.earningAmount),
                      ],
                    );
                  }),
 ),
        
          Container(
              height: Get.height * 0.8,
              margin: GlobleglobleMargin.Margin10H,
              child: ListView.builder(
                itemCount: controller!.starlineResponse.value!.starlineGames.length,
                itemBuilder: (context, index) {
                  final item = controller!.starlineResponse.value!.starlineGames[index];

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
                        themeController.isLightMode.value ? boxdark : boxshadow2
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          item.name,
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
                                        item.play.toString(),
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
                                  " ₹${item.name.toString()}",
                                  style: CustomStyles.textExternel,
                                ),
                              ],
                            )
                          ],
                        ),
                        
                      ],
                    ),
                  );
                },
              )),
        ],
      ):  CircularProgressIndicator();
    }
  }
}
