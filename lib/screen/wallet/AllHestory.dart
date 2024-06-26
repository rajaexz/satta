import 'package:get/get.dart';
import 'package:winner11/screen/header/appbar.dart';
import 'package:winner11/service/authapi.dart';
import 'package:winner11/utilis/AllColor.dart';
import 'package:winner11/utilis/borderbox.dart';
import 'package:winner11/utilis/boxSpace.dart';
import 'package:winner11/utilis/fontstyle.dart';
import 'package:winner11/utilis/globlemargin.dart';
import 'package:flutter/material.dart';
import 'package:winner11/screen/wallet/walletHestory.dart';

class AllHestory extends StatefulWidget {
  const AllHestory({super.key});

  @override
  State<AllHestory> createState() => _AllHestoryState();
}

class _AllHestoryState extends State<AllHestory> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Wallet History"),
      body: Container(
        margin: GlobleglobleMargin.Margin10H,
        child:
        
           ListView.builder(
                    itemCount:
                        1, // Use 'data' instead of 'widget.data'
                    itemBuilder: (context, index) {
                  
                  
                      DateTime dateTime = DateTime.parse("timestamps");
                      String day =
                          "${3}-${6}-${2000}";
                      String time =
                          "${3}-${6}-${2000}";
                  
                      return Obx(
                        () => Container(
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
                              "transaction_id".toString(),
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
                                "payment_status" != "FAILURE"
                                            ? const Icon(
                                                Icons.check_circle_outline,
                                                size: 20,
                                              )
                                            : const Icon(
                                                Icons.close,
                                                size: 20,
                                              ),
                                        size10w,
                                        Column(
                                          children: [
                                            //time
                                            Text(
                                              time.toString(),
                                              style:
                                                  CustomStyles.smallTextStyle,
                                            ),
                                            Text(
                                              day.toString(),
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
                                        "trans_type".toString(),
                                        style: CustomStyles.textExternel,
                                      ),
                                      Text(
                                        " ₹${"money".toString()}",
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
                        ),
                      );
                    },
                  )
               ),
    );
  }
}
