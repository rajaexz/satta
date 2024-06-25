import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winner11/screen/component/darkmode.dart';
import 'package:winner11/screen/header/headerTop.dart';
import 'package:winner11/service/authapi.dart';
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

  final ApiService apiService = ApiService();
  @override
  Widget build(BuildContext context) {
  return FutureBuilder(
  future: apiService.userAllDoc(uri: "/transaction_history"),
  builder: (BuildContext context, snapshot) {
    try {
      if (snapshot.connectionState == ConnectionState.done) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        final data = (snapshot.data as Map<String, dynamic>)['data']["result"];
        final reversedData =
            List.from(data.reversed); // Reverse the data list
        final itemCount = reversedData.length >= 5
            ? 5
            : reversedData.length; // Set itemCount to a maximum of 5 items

        if (data != null) {
            return Column(
              children: [
                titlebtn(HeadName: "MY History", context1: context, Headno: "See All", routes: "/historyWallet",),
                size10h,
                Container(
                  height: 650,
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: itemCount, // Use 'data' instead of 'widget.data'
                    itemBuilder: (context, index) {
                      Map<String, dynamic> item = reversedData[index];
                   
                     DateTime dateTime = DateTime.parse(item["timestamps"]);
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
                                  Text(item["transaction_id"].toString(),style: TextStyle(fontSize: 10,color: myColorGray), ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                   
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                       item["payment_status"] != "FAILURE" ?  const Icon(
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
                                        Text(item["trans_type"].toString(),style: CustomStyles.textExternel,),
                                    Text(" ₹${item["money"].toString()}",style: CustomStyles.textExternel,),
                                  ],
                                )
                                ],
                              ),
                           Text(item["payment_status"].toString(),style: TextStyle(color: myColorgreen), )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
       
        } else {
          return Text('No data available');
        }
      } else if (snapshot.connectionState == ConnectionState.waiting) {
        return CircularProgressIndicator(); // Display a loading indicator
      } else {
        return Text('Data retrieval is not in progress');
      }
    } catch (e) {
      return Text('Error: $e'); // Handle errors within the try-catch block
    }
  },
);
  }
}
