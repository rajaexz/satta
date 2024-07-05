import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:vibration/vibration.dart';
import 'package:winner11/screen/component/darkmode.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winner11/screen/component/custom_toaster.dart';
import 'package:winner11/screen/header/headerTop.dart';
import 'package:winner11/screen/tap1/controller/upcomming_controller.dart';
import 'package:winner11/screen/tap2/myGame.dart';
import 'package:winner11/service/authapi.dart';
import 'package:winner11/utilis/AllColor.dart';
import 'package:winner11/utilis/boxSpace.dart';
import 'package:winner11/utilis/fontstyle.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:winner11/screen/wallet/wallet.dart';
import 'package:url_launcher/url_launcher.dart';

class UpComming extends GetView<GameBidController> {
  const UpComming({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    Get.put(GameBidController());

    return GetBuilder<GameBidController>(
      init: controller,
      builder: (controller) => UpCommingView(
        controller: controller,
      ),
    );
  }
}

class UpCommingView extends StatelessWidget {
  GameBidController? controller;
  UpCommingView({super.key, this.controller});

  final ThemeController themeController = Get.put(ThemeController());

  final String? id = Get.arguments as String?;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: Get.width,
          height: 150,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.light
                  ? myColorWhite
                  : myColorRed,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey),
              boxShadow: [
                Theme.of(context).brightness == Brightness.light
                    ? BoxShadow(color: Colors.black26, blurRadius: 5)
                    : BoxShadow(color: Colors.black54, blurRadius: 5)
              ]),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  customImageContainer(
                      context: context,
                      imageUrl: 'assets/wh.jpg',
                      onTap: openWhatsApp,
                      name: "Whatsapp",
                      imageSize: 50),
                  customImageContainer(
                    imageSize: 50,
                    name: "waallet",
                    context: context,
                    imageUrl: Theme.of(context).brightness == Brightness.light
                        ? "assets/icon/wallet.png"
                        : "assets/icon/wallet2.png",
                    onTap: () {
                      showModalBottomSheet<void>(
                        showDragHandle: true,
                        useSafeArea: true,
                        isScrollControlled: true,
                        elevation: 8,
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16.0),
                            topRight: Radius.circular(16.0),
                          ),
                        ),
                        builder: (BuildContext context) {
                          return const FractionallySizedBox(
                            heightFactor:
                                0.5, // Adjust this value to control the height (0.0 to 1.0).
                            child: MyWallet(),
                          );
                        },
                      );
                    },
                  ),
                  customImageContainer(
                    imageSize: 50,
                    name: "Addmoney",
                    context: context,
                    imageUrl: 'assets/person.png',
                    onTap: () {
                      Get.toNamed("/addMoney");
                    },
                  ),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                GestureDetector(
                  onTap: () {
                    showbottombar(context);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 5),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    decoration: BoxDecoration(color: myColorRed),
                    child: const Text(
                      "Gali Disawar Game",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ])
            ],
          ),
        ),

// Mycontest ----------------------------------------------------------

        size10h,
        Simpletitlebtn(HeadName: "Curent Sata Game"),

//Upcoming Match List

        LayoutBuilder(
          builder: (context, constraints) {
            double width = constraints.maxWidth;

            return Column(
              children: [
                for (var bid in controller!.bids)
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
                                  bid.name,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                launch(bid.chartUrl);
                              },
                              child: Image.asset(
                                "assets/network-removebg-preview.png",
                                width: 30,
                                height: 30,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Divider(),
                        Text(
                          bid.sortCol.toString(),
                          style: CustomStyles.headerTextStyle,
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Open : ${bid.openTime}",
                              style: CustomStyles.textExternel,
                            ),
                            TextButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    bid.open
                                        ? const Color.fromARGB(255, 26, 113, 29)
                                        : Color.fromARGB(255, 199, 44, 44)),
                                padding: MaterialStateProperty.all(
                                  const EdgeInsets.symmetric(
                                      horizontal: 35, vertical: 10),
                                ),
                              ),
                              isSemanticButton: true,
                              onPressed: () {
                                !bid.open ? Get.to(GridViewWidget(playOrNot:bid.play)) : null;

                                  if ( !bid.open ) {
              Vibration.vibrate();
            }
                              },
                              child: Text(
                                bid.open ? "Open" : "Close",
                                style: CustomStyleswhite.header2TextStyle,
                              ),
                            ),
                            Text(
                              "Close : ${bid.closeTime}",
                              style: CustomStyles.textExternel,
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Result: ${bid.result}',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
              ],
            );
          },
        )
      ],
    );
  }
}

Widget customImageContainer(
    {required BuildContext context,
    required String imageUrl,
    required double imageSize,
    required VoidCallback onTap,
    required String name}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.all(5),
      width: MediaQuery.of(context).size.width / 4,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.red),
        boxShadow: [
          Theme.of(context).brightness == Brightness.light
              ? BoxShadow(color: Colors.black26, blurRadius: 5)
              : BoxShadow(color: Colors.black54, blurRadius: 5)
        ],
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor:
                Colors.transparent, // Set a background color if needed
            child: ClipOval(
              child: Image.asset(
                imageUrl,
                width: imageSize,
                height: imageSize,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(name)
        ],
      ),
    ),
  );
}

Future<void> openWhatsApp() async {
  const phoneNumber = '1234567890'; // Replace with the actual phone number
  final whatsappUrl = 'whatsapp://send?phone=$phoneNumber';

  if (await canLaunch(whatsappUrl)) {
    await launch(whatsappUrl);
  } else {
    throw 'Could not launch $whatsappUrl';
  }
}

showbottombar(context) {
  showModalBottomSheet<void>(
    showDragHandle: true,
    useSafeArea: true,
    isScrollControlled: true,
    elevation: 8,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16.0),
        topRight: Radius.circular(16.0),
      ),
    ),
    builder: (BuildContext context) {
      return FractionallySizedBox(
        heightFactor:
            0.5, // Adjust this value to control the height (0.0 to 1.0).
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Get.toNamed("/GaliGame");
                },
                child: CircleAvatar(
                    radius: 80,
                    backgroundColor: myColorRed,
                    child: const Text("Gali disawar")),
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed("/StarlineGame");
                },
                child: CircleAvatar(
                    radius: 80,
                    backgroundColor: myColorRed,
                    child: const Text("Starline")),
              ),
            ],
          ),
        ),
      );
    },
  );
}
