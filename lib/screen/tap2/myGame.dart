import 'package:Billa/screen/top3/StarMakeBid.dart';
import 'package:Billa/screen/top3/galiMakeBid.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:Billa/model/mainGame.dart';
import '../../model/GaliGame.dart';
import '../../model/StarlineGame.dart';
import '../header/appbar.dart';
import '../top3/MakeBit.dart';

class GridViewWidget extends StatelessWidget {
  var gameData;
  final String whicGameName;

  GridViewWidget(
      {super.key, required this.gameData, required this.whicGameName});

  final List<String> imageUrls = [
    'assets/icon/1patti.png',
    'assets/icon/jodipatti.png',
    'assets/icon/2patti.png',

    'assets/icon/allpatti.png',
    'assets/icon/3patti.png',
    'assets/icon/3patti.png',
    'assets/icon/allpatti.png',
    // Add more if needed to match the longest gameType list
  ];

  final List<Map<String, dynamic>> gameTypeMain = [
    {'title': 'Single Digit', 'data': 'single_digit'},
    {'title': 'Jodi Digit', 'data': 'jodi_digit'},
    {'title': 'Single Panna', 'data': 'single_panna'},
    {'title': 'Double Panna', 'data': 'double_panna'},
    {'title': 'Triple Panna', 'data': 'triple_panna'},
    {'title': 'Half Sangam', 'data': 'half_sangam'},
    {'title': 'Full Sangam', 'data': 'full_sangam'},
  ];
  final List<Map<String, dynamic>> gameTypeMaintype2 = [
    {'title': 'Single Digit', 'data': 'single_digit'},
    {'title': 'Single Panna', 'data': 'single_panna'},
    {'title': 'Double Panna', 'data': 'double_panna'},
    {'title': 'Triple Panna', 'data': 'triple_panna'},
  ];

  final List<Map<String, dynamic>> gameTypeGali = [
    {'title': 'Jodi Digit', 'data': 'jodi_digit'},
    {'title': 'Right Digit', 'data': 'right_digit'},
    {'title': 'Left Digit', 'data': 'left_digit'},
  ];

  final List<Map<String, dynamic>> gameTypeStarline = [
    {'title': 'Single Digit', 'data': 'single_digit'},
    {'title': 'Single Panna', 'data': 'single_panna'},
    {'title': 'Double Panna', 'data': 'double_panna'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "${whicGameName.toString().replaceAll("_", " ").toUpperCase()}",
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          if (whicGameName == "gali_disawar" && gameData is GaliDisawarGame)
            Expanded(
              child: gameGrid(
                  gameType: gameTypeGali,
                  imageUrls: imageUrls,
                  allData: gameData,
                  whicGameName: whicGameName),
            ),
          if (whicGameName == "main_game" && gameData is GameList)
            gameData.open
                ? Expanded(
                    child: gameGrid(
                      gameType: gameTypeMain,
                      imageUrls: imageUrls,
                      allData: gameData,
                      whicGameName: whicGameName,
                    ),
                  )
                : Expanded(
                    child: gameGrid(
                        gameType: gameTypeMaintype2,
                        imageUrls: imageUrls,
                        allData: gameData,
                        whicGameName: whicGameName),
                  ),
          if (whicGameName == "star_line" && gameData is StarlineGame)
            Expanded(
              child: gameGrid(
                  gameType: gameTypeStarline,
                  imageUrls: imageUrls,
                  allData: gameData,
                  whicGameName: whicGameName),
            ),
        ],
      ),
    );
  }
}

Widget gameGrid({
  required List<Map<String, dynamic>> gameType,
  required List<String> imageUrls,
  allData,
  required String whicGameName,
}) {
  return GridView.count(
    crossAxisCount: 2,
    children: List.generate(gameType.length, (index) {
      return GestureDetector(
        onTap: () {
          if (whicGameName == "gali_disawar") {
            Get.to(GaliMakeBidPage(
              allData: allData,
              title: gameType[index]['data'],
              whicGameName: whicGameName,
            ));
          }

          if (whicGameName == "main_game") {
            Get.to(MakeBitPage(
              allData: allData,
              title: gameType[index]['data'],
              whicGameName: whicGameName,
            ));
          }

          if (whicGameName == "star_line") {
            Get.to(StarMakeBidPage(
              allData: allData,
              title: gameType[index]['data'],
              whicGameName: whicGameName,
            ));
          }
        },
        child: Container(
          margin: const EdgeInsets.all(8.0),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  imageUrls[index],
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Color.fromARGB(255, 185, 23, 11),
                  ),
                  height: 40,
                  width: Get.width / 2.5,
                  alignment: Alignment.center,
                  child: Text(
                    gameType[index]['title'].toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }),
  );
}
