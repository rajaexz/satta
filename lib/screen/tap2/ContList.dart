import 'package:winner11/screen/component/coundown.dart';
import 'package:winner11/screen/component/imageComponet.dart';
import 'package:winner11/screen/component/profileContainer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winner11/screen/component/custom_toaster.dart';
import 'package:winner11/screen/component/pop.dart';
import 'package:winner11/screen/header/appbar.dart';
import 'package:winner11/screen/header/headerTop.dart';
import 'package:winner11/screen/tap/topIndigetor.dart';
import 'package:winner11/screen/tap1/upcomming.dart';
import 'package:winner11/service/authapi.dart';
import 'package:winner11/utilis/AllColor.dart';
import 'package:winner11/utilis/borderbox.dart';
import 'package:winner11/utilis/boxSpace.dart';
import 'package:winner11/utilis/fontstyle.dart';
import 'package:winner11/utilis/globlemargin.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContList extends StatefulWidget {
  const ContList({super.key});

  @override
  State<ContList> createState() => _ContListState();
}

class _ContListState extends State<ContList>
    with SingleTickerProviderStateMixin {
  //api argument
  final dynamic data_of_id = Get.arguments as dynamic;

  late AnimationController _controller;

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
    final ApiService apiService = ApiService();
    return Scaffold(
        appBar: CustomAppBar(
          title: 'WINNER11',
        ),
        body: SingleChildScrollView(
          child: SafeArea(
              child: Column(
            children: [
              Container(
                  height: 50,
                  color: myColorRed,
                  child: Indigator(currentPage: 1)),
              size20h,
              Container(
                margin: GlobleglobleMargin.globleMargin,
                child: Simpletitlebtn(
                  HeadName: " Entry Matches",
                ),
              ),
              Container(
                margin: GlobleglobleMargin.globleMargin,
                height: 800,
                child: FutureBuilder(
                    future: apiService.userMatchList(data: {
                      "id": data_of_id["id"],
                      "match_id": data_of_id["poolId"]
                    }, uri: '/show_pools'),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }

                        final data =
                            (snapshot.data as Map<String, dynamic>)['data'];

                        if (data != null) {
                          final result = data["result"];

                          if (result != null) {
                            return ListView.builder(
                                itemCount: result.length,
                                itemBuilder: (context, index) {
                                  final match = result[index];

                                  return Container(
                                    child: Column(
                                      children: [
                                        size20h,
                                        GestureDetector(
                                          onTap: () {
                                            Get.toNamed('/myCont', arguments: {
                                              "id": data_of_id["id"],
                                              "data": result[index],
                                            });
                                          },
                                          child: Obx(() {
                                            return Container(
                                                height: 177,
                                                decoration: BoxDecoration(
                                                    color: themeController
                                                            .isLightMode.value
                                                        ? myColorWhite
                                                        : myColor,
                                                    boxShadow: [
                                                      themeController
                                                              .isLightMode.value
                                                          ? boxshadow2
                                                          : boxdark
                                                    ],
                                                    border: border,
                                                    borderRadius: boRadiusAll),
                                                child: Container(
                                                  child: Column(children: [
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 10,
                                                              bottom: 5,
                                                              right: 10,
                                                              left: 10),
                                                      child: Column(children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Column(
                                                              children: [
                                                                Text(
                                                                  " ${match["match_status"].toString()} ",
                                                                  style: CustomStyles
                                                                      .smallTextStyle,
                                                                ),
                                                                size20h,
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
                                                                    Row(
                                                                      children: [
                                                                        Text(
                                                                          "₹${match["winning_prize"]}  ",
                                                                          style:
                                                                              const TextStyle(
                                                                            fontSize:
                                                                                30,
                                                                            fontWeight:
                                                                                FontWeight.w700,
                                                                            fontFamily:
                                                                                'Roboto1', // Use the same font family name here
                                                                          ),
                                                                        ),
                                                                        const Text(
                                                                          "₹  Winning Prize",
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                10,
                                                                            color:
                                                                                Colors.green,
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                            fontFamily:
                                                                                'Roboto1', // Use the same font family name here
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    )
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                            Column(
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Text(
                                                                      "Entry:",
                                                                      style: CustomStyles
                                                                          .smallTextStyle,
                                                                    ),
                                                                    Text(
                                                                      "₹${(int.parse(match["entry_fee"].toString()) * 2).toString()}",
                                                                      style: CustomStyles
                                                                          .textExternelgreen
                                                                          ?.copyWith(
                                                                        decoration:
                                                                            TextDecoration.lineThrough,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                ElevatedButton(
                                                                  onPressed:
                                                                      () async {
                                                                    final store =
                                                                        await SharedPreferences
                                                                            .getInstance();

                                                                    final id = store
                                                                        .getString(
                                                                            "userid");

                                                                    ApiService
                                                                        apiservice =
                                                                        ApiService();

                                                                    var data = await apiservice
                                                                        .userAllDoc(
                                                                            uri:
                                                                                "/fetch_balance");

                                                                    if (data["data"]
                                                                            [
                                                                            "error"] ==
                                                                        "Your wallet is not created") {
                                                                      // ignore: use_build_context_synchronously
                                                                      CustomToaster.showWarning(
                                                                          context,
                                                                          data["data"]
                                                                              [
                                                                              "error"]);

                                                                      await delayedAnySecond(
                                                                          2);
                                                                      Get.toNamed(
                                                                          '/addMoney');
                                                                    } else {
                                                                      final dynamic
                                                                          balance =
                                                                          data['data']
                                                                              ?[
                                                                              'balance'];

                                                                      if (int.parse(
                                                                              balance.toString()) >
                                                                          10) {
                                                                        Get.offAllNamed(
                                                                            '/createCont',
                                                                            arguments: {
                                                                              "id": id,
                                                                              "data": match,
                                                                            });
                                                                      } else {
                                                                        // ignore: use_build_context_synchronously
                                                                        CustomToaster.showWarning(
                                                                            context,
                                                                            "Somethisng want wrrog because your balance is not enough");
                                                                        Get.toNamed(
                                                                            "/addMoney");
                                                                      }
                                                                    }
                                                                  },
                                                                  style: ElevatedButton
                                                                      .styleFrom(
                                                                    backgroundColor:
                                                                        myColorgreen, // Set the button background color to green
                                                                  ),
                                                                  child: Text(
                                                                    '₹${match["entry_fee"].toString()}',
                                                                    style: CustomStyleswhite
                                                                        .headerTextStyle,
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        Center(
                                                          child:
                                                              LinearProgressIndicator(
                                                            value: (double.parse(
                                                                    match["count"].toString()) /
                                                                100.0),
                                                            backgroundColor: Colors
                                                                    .grey[
                                                                300], // Background color
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                        Color>(
                                                                    myColorRed), // Progress color
                                                          ),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Column(
                                                              children: [
                                                                Text(
                                                                  "${match["count"].toString()} Traders",
                                                                  style: CustomStyles
                                                                      .textExternelgray,
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ]),
                                                    ),
                                                    // bottom
                                                  ]),
                                                ));
                                          }),
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          } else {
                            return Text('No match data available');
                          }
                        } else {
                          return Text('No data available');
                        }
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(
                            child:
                                const CircularProgressIndicator()); // Display a loading indicator
                      } else {
                        return Text('Data retrieval is not in progress');
                      }
                    }),
              ),
            ],
          )),
        ));
  }
}
