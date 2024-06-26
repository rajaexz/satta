import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winner11/screen/component/darkmode.dart';
import 'package:winner11/screen/header/headerTop.dart';

import 'package:winner11/utilis/AllColor.dart';
import 'package:winner11/utilis/borderbox.dart';
import 'package:winner11/utilis/boxSpace.dart';
import 'package:winner11/utilis/fontstyle.dart';

  final ThemeController themeController = Get.put(ThemeController());
class Myhestory extends StatefulWidget {
  final List<Map<String, dynamic>> data;

  const Myhestory({super.key, required this.data});

  @override
  State<Myhestory> createState() => _MyhestoryState();
}

class _MyhestoryState extends State<Myhestory> {
  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
         return Column(
              children: [
                titlebtn(HeadName: "MY History", context1: context, Headno: "See All", routes: "/historyWallet",),
                size10h,
                Container(
                  height: 650,
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 1, // Use 'data' instead of 'widget.data'
                    itemBuilder: (context, index) {
                 
                   
                     DateTime dateTime = DateTime.parse(DateTime.now().toString());
       String day = "${dateTime.day}-${dateTime.month}-${dateTime.year}";
        String time = "${dateTime.hour}:${dateTime.minute}:${dateTime.second}";
   
                      return Obx(
                        ()=> Container(
                          height: 100,
                                        
                          margin: const EdgeInsets.all(9),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                                                 border:border,
                                                 borderRadius:boRadiusAll ,
                                 color: themeController.isLightMode.value
                                      ? myColorWhite
                                      : myColor,
                                                  boxShadow: [  themeController.isLightMode.value
                                              ? boxdark
                                              : boxshadow2 ],
                                                ),
                          child: Column(
                            
                            children: [
                                  Text("2345678",style: TextStyle(fontSize: 10,color: myColorGray), ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                   
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                      false != "FAILURE" ?  const Icon(
                                          Icons.check_circle_outline,
                                          size: 20,
                                        ): const Icon(
                                          Icons.close,
                                          size: 20,
                                        ),
                                        size10w,
                                        Column(
                                          children: [
                                            //time
                                            Text(
                                              day,
                                              style: CustomStyles.smallTextStyle,
                                            ),
                                            Text(
                                             time,
                                              style: CustomStyles.smallTextStyle,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                              
                                Column(
                                  children: [
                                        Text("2345678",style: CustomStyles.textExternel,),
                                    Text("234567",style: CustomStyles.textExternel,),
                                  ],
                                )
                                ],
                              ),
                           Text("23456789".toString(),style: TextStyle(color: myColorgreen), )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
    
  }
}
