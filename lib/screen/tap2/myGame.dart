import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../header/appbar.dart';
import '../top3/MakeBit.dart';

class GridViewWidget extends StatelessWidget {
var gameData;
  final String? whicGameName;

  GridViewWidget({super.key, required this.gameData, this.whicGameName});

  final List<String> imageUrls = [
    'https://th.bing.com/th/id/OIP.y0OiNv_Nn1a5Zn9kZYWDVQHaHd?rs=1&pid=ImgDetMain',
    'https://clipart-library.com/new_gallery/dice-clipart-1.jpeg',
    'https://pngimg.com/uploads/dice/dice_PNG87.png',
    'https://w7.pngwing.com/pngs/989/1002/png-transparent-dominoes-dice-free-content-dice-s-free-game-white-rectangle-thumbnail.png',
    'https://th.bing.com/th/id/OIP.y0OiNv_Nn1a5Zn9kZYWDVQHaHd?rs=1&pid=ImgDetMain',
    'https://clipart-library.com/new_gallery/dice-clipart-1.jpeg',
    'https://pngimg.com/uploads/dice/dice_PNG87.png',
    'https://w7.pngwing.com/pngs/989/1002/png-transparent-dominoes-dice-free-content-dice-s-free-game-white-rectangle-thumbnail.png',
    'https://th.bing.com/th/id/OIP.y0OiNv_Nn1a5Zn9kZYWDVQHaHd?rs=1&pid=ImgDetMain',
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
        title: "My Game ",
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          if (whicGameName == "gali_disawar")
            Expanded(
              child: gameGrid(gameType: gameTypeGali, imageUrls: imageUrls,  allData: gameData),
            ),
          if (whicGameName == "main_game")
            Expanded(
              child: gameGrid(gameType: gameTypeMain, imageUrls: imageUrls, allData: gameData),
            ),
          if (whicGameName == "star_line")
            Expanded(
              child: gameGrid(gameType: gameTypeStarline, imageUrls: imageUrls, allData: gameData),
            ),
        ],
      ),
    );
  }
}

Widget gameGrid({required List<Map<String, dynamic>> gameType, required List<String> imageUrls, allData}) {
  return GridView.count(
    crossAxisCount: 2,
    children: List.generate(gameType.length, (index) {
      return GestureDetector(
        onTap: () {
          Get.to(MakeBitPage(allData: allData, title: gameType[index]['data']));
        },
        child: Container(
          margin: EdgeInsets.all(8.0),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  imageUrls[index],
                  fit: BoxFit.cover,
                ),
              ),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Color.fromARGB(255, 185, 23, 11),
                  ),
                  width: 100,
                  height: 40,
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
