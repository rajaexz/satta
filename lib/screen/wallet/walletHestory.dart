import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winner11/screen/component/darkmode.dart';
import 'package:winner11/screen/component/iconStatus.dart';
import 'package:winner11/screen/header/headerTop.dart';

import 'package:winner11/utilis/AllColor.dart';
import 'package:winner11/utilis/borderbox.dart';
import 'package:winner11/utilis/boxSpace.dart';
import 'package:winner11/utilis/fontstyle.dart';

import 'wallet_controller.dart/all_hestory_controller.dart';

  final ThemeController themeController = Get.put(ThemeController());


  
class Myhestory extends GetView<AllHestoryController> {
  const Myhestory({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    Get.put(AllHestoryController());

    return GetBuilder<AllHestoryController>(
        init: controller,
        builder: (controller) => MyhestoryView(
          controller: controller,
        ),
      );
  }
}



 class MyhestoryView extends StatelessWidget {
AllHestoryController ?  controller;
   MyhestoryView({super.key,this.controller});


  @override
  Widget build(BuildContext context) {
         
           if (controller!.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (controller!.withdrawData.value == null) {
          return Center(child: Text('Error fetching data'));
        } else {
         return 
         
         
         Column(
              children: [
                titlebtn(HeadName: "MY History", context1: context, Headno: "See All", routes: "/historyWallet",),
                size10h,
              
              
              
                Container(
                  height: 650,
                  child:       ListView.builder(
                      
                         itemCount: 4,
                    itemBuilder: (context, index) {
                      
                      
                          
                           final item = controller!.withdrawData.value!.statement[index];
                   
  
                      return             
               Container(
                              height: 100,
                              margin: const EdgeInsets.all(9),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: border,
                                borderRadius: boRadiusAll,
                                color: themeController.isLightMode.value
                                    ? myColorWhite
                                    : myColor,
                                boxShadow: [
                                  themeController.isLightMode.value
                                      ? boxdark
                                      : boxshadow2
                                ],
                              ),
                              child: Column(
                                children: [
                                  Text(
                                  item.transStatus,
                                    style: TextStyle(
                                        fontSize: 10, color: myColorGray),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                     getStatusIcon(item.transStatus),
                                            size10w,
                                            Column(
                                              children: [
                                                //time
                                                Text(
                                                  item.transDet.toString(),
                                                  style:
                                                      CustomStyles.smallTextStyle,
                                                ),
                                              
                                              ],
                                            )
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
                                            " ₹${ item.points.toString()}",
                                            style: CustomStyles.textExternel,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Text(
                               "payment_status".toString(),
                                    style: TextStyle(color: myColorgreen),
                                  )
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

