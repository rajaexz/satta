import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winner11/screen/component/ImageMatchDetail.dart';
import 'package:winner11/screen/component/custom_toaster.dart';
import 'package:winner11/screen/component/darkmode.dart';
import 'package:winner11/screen/component/imageComponet.dart';
import 'package:winner11/screen/header/appbar.dart';
import 'package:winner11/screen/tap/topIndigetor.dart';
import 'package:winner11/service/authapi.dart';
import 'package:winner11/utilis/AllColor.dart';
import 'package:winner11/utilis/borderbox.dart';
import 'package:winner11/utilis/fontstyle.dart';
import 'package:winner11/utilis/globlemargin.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utilis/boxSpace.dart';

class MyCont extends StatefulWidget {
  const MyCont({super.key});

  @override
  State<MyCont> createState() => _MyContState();
}

class _MyContState extends State<MyCont> with SingleTickerProviderStateMixin {
  final dynamic argumentsdata = Get.arguments as dynamic;
  late AnimationController _controller;
  final ThemeController themeController = Get.put(ThemeController());
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: CustomAppBar(
          title: '',
          actions: [],
        ),
        body: SafeArea(
          child: Container(
          
            child: Column(
              children: [
                
                Container(
                  height: 50,
                    decoration: summerImage, child: Indigator(currentPage: 1)),
                RefreshIndicator(
                  onRefresh: () async {
                    // here we are refresh indigetor
                
                  },
                  child: Container(
                      margin: GlobleglobleMargin.globleMargin,
                      height: 320,
                      child: Column(children: [
                            Text(
                                                                  " ${argumentsdata["data"]["match_status"].toString()} ",
                                                                  style: CustomStyles
                                                                      .header3TextStyle,
                                                                ),
                        Container(
                          padding: const EdgeInsets.only(
                              top: 10, bottom: 5, right: 10, left: 10),
                          child: Column(children: [
                            size20h,
                            teamA_B(
                                data: argumentsdata["data"],
                                Image1:  argumentsdata["data"]["team_a_img"],
                                Image2: argumentsdata["data"]["team_b_img"]),

                            size20h,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                        Text(
                                          "Prize Pool ",
                                          style: CustomStyles.smallTextStyle,
                                        ),
                                    size20h,
                             
                                Column(
                                  children: [
                                   Column(
                                      children: [
                                        Image.asset(
                                          "assets/cruwn.gif",
                                          width:
                                              30, // Adjust the width as needed
                                          height:
                                              30, // Adjust the height as needed
                                          fit: BoxFit
                                              .contain, // Adjust the fit property as needed
                                        ),
                                        Text(
                                          "₹${argumentsdata["data"]["winning_prize"]}",
                                          style: const TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.w700,
                                            fontFamily:
                                                'Roboto1', // Use the same font family name here
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            //line image
                  
                  
                  
                  
                  
                           Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                       Text(
                                                                  "${argumentsdata["data"]["count"].toString()} Traders",
                                                                  style: CustomStyles
                                                                      .textExternelgray,
                                                                ),
                                  ],
                                ),
                           
                              ],
                            ),

                            ElevatedButton(
                              onPressed: () async {
                                ApiService apiservice = ApiService();
                                var data = await apiservice.userAllDoc(
                                    uri: "/fetch_balance");
                                final store =
                                    await SharedPreferences.getInstance();

                                final id = store.getString("token");

                                if (int.parse(
                                        data["data"]["balance"].toString()) >
                                    10) {
                                  Get.toNamed('/createCont', arguments: {
                                    "id": argumentsdata["id"],
                                    "data": argumentsdata["data"],
                                  });
                                } else {
                                  CustomToaster.showWarning(
                                    context,
                                    "Something went wrong because your balance is not enough",
                                  );

                                  // Show custom toaster and then navigate to '/addMoney' after a delay
                                  await Future.delayed(Duration(
                                      seconds:
                                          2)); // Adjust the delay as needed
                                  Get.toNamed("/addMoney");
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    myColorgreen, // Set the button background color to green
                              ),
                              child: Text(
                                'Join Now       ₹${argumentsdata["data"]["entry_fee"].toString()}',
                                style: CustomStyleswhite.headerTextStyle,
                              ),
                            )
                          ]),
                        ),
                        // bottom
                        size10h,
                      ])),
                ),
              ],
            ),
          ),
        ));
  }
}
