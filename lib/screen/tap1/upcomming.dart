
import 'package:winner11/screen/component/darkmode.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winner11/screen/component/custom_toaster.dart';
import 'package:winner11/screen/header/headerTop.dart';
import 'package:winner11/screen/tap2/myGame.dart';
import 'package:winner11/service/authapi.dart';
import 'package:winner11/utilis/AllColor.dart';
import 'package:winner11/utilis/boxSpace.dart';
import 'package:winner11/utilis/fontstyle.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:winner11/screen/wallet/wallet.dart';

import '../component/coundown.dart';
import 'package:url_launcher/url_launcher.dart';

class GameBid {
  final String gameId;
  final String gameType;
  final String session;
  final String bidPoints;
  final String openDigit;
  final String closeDigit;
  final String openPanna;
  final String closePanna;

  GameBid({
    required this.gameId,
    required this.gameType,
    required this.session,
    required this.bidPoints,
    required this.openDigit,
    required this.closeDigit,
    required this.openPanna,
    required this.closePanna,
  });

  factory GameBid.fromJson(Map<String, dynamic> json) {
    return GameBid(
      gameId: json['game_id'],
      gameType: json['game_type'],
      session: json['session'],
      bidPoints: json['bid_points'],
      openDigit: json['open_digit'],
      closeDigit: json['close_digit'],
      openPanna: json['open_panna'],
      closePanna: json['close_panna'],
    );
  }
}

class UpComming extends StatefulWidget {
  const UpComming({super.key});

  @override
  State<UpComming> createState() => _UpCommingState();
}

class _UpCommingState extends State<UpComming> {
 final List<GameBid> bids = [
    GameBid(
      gameId: "3",
      gameType: "single_digit",
      session: "Open",
      bidPoints: "10",
      openDigit: "9",
      closeDigit: "",
      openPanna: "",
      closePanna: "",
    ),
    GameBid(
      gameId: "3",
      gameType: "single_digit",
      session: "Open",
      bidPoints: "10",
      openDigit: "8",
      closeDigit: "",
      openPanna: "",
      closePanna: "",
    ),
    GameBid(
      gameId: "3",
      gameType: "single_digit",
      session: "Open",
      bidPoints: "40",
      openDigit: "5",
      closeDigit: "",
      openPanna: "",
      closePanna: "",
    ),
  ];


  late SharedPreferences _prefs;
  late String _lastPopupDate;
  @override
  void initState() {
    super.initState();
    _initPreferences();
  }

  Future<void> _initPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    _lastPopupDate = _prefs.getString('lastPopupDate') ?? '';

    if (_lastPopupDate != getCurrentDate()) {
      showPopup(context);
    }
  }

  final ThemeController themeController = Get.put(ThemeController());
  final ApiService apiService = ApiService();
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              customImageContainer(
                  context: context,
                  imageUrl: 'assets/wh.jpg',
                  onTap: openWhatsApp,
                  name: "Whatsapp",
                  imageSize:50
                  ),
           
           
           
              customImageContainer(
                 imageSize:50,
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
                 imageSize:50,
                name: "Addmoney",
                context: context,
                imageUrl: 'assets/person.png',
                onTap: () {
                  Get.toNamed("/addMoney");
                },
              ),
           
           
           
           
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
        double padding = width * 0.03;
        double imageSize = width * 0.1;
        double containerHeight = width * 0.4;
        
        return Column(
          children: [
            
      
            for (var bid in bids)
              GestureDetector(
                onTap: () {
                  Get.to(GridViewWidget());
                },
                child: Container(
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
                                  Theme.of(context).brightness == Brightness.light
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
                                "Star Morning",
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Image.asset(
                            "assets/network-removebg-preview.png",
                            width: 30,
                            height: 30,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Divider(),
                      Text(
                        "232-233-3223",
                        style: CustomStyles.headerTextStyle,
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Open : 9:00 PM",
                            style: CustomStyles.textExternel,
                          ),
                          TextButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(const Color.fromARGB(255, 26, 113, 29)),
                              padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(
                                    horizontal: 35, vertical: 10),
                              ),
                            ),
                            isSemanticButton: true,
                            onPressed: () {},
                            child: Text(
                              "Open",
                              style: CustomStyleswhite.header2TextStyle,
                            ),
                          ),
                          Text(
                            "Close : 9:00 PM",
                            style: CustomStyles.textExternel,
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Bid Points: ${bid.bidPoints}, Open Digit: ${bid.openDigit}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
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
