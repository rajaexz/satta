import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winner11/model/StarlineGame.dart';
import 'package:winner11/model/mainGame.dart';
import 'package:winner11/screen/header/appbar.dart';
import 'package:winner11/screen/top3/controller/MakeBit_controller.dart';

import '../../model/GaliGame.dart';

class MakeBitPage extends StatelessWidget {
  final String? title;
  final dynamic allData;
  final dynamic whicGameName;
  MakeBitPage({Key? key, this.title, required this.allData, this.whicGameName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MakeBiteController controller =
        Get.put(MakeBiteController(allData, this.whicGameName));

    return Scaffold(
      appBar:
          CustomAppBar(title: title?.replaceAll('_', ' ').toUpperCase() ?? ''),
      body: GetBuilder<MakeBiteController>(
        builder: (controller) => MakeBitPageScreen(
            controller: controller,
            gameType: title,
            allData: allData,
            whicGameName: whicGameName),
      ),
    );
  }
}

class MakeBitPageScreen extends StatelessWidget {
  final TextEditingController _pointController = TextEditingController();
  final String? gameType;
  final dynamic allData;
  final dynamic whicGameName;
  final MakeBiteController controller;

  MakeBitPageScreen(
      {Key? key,
      required this.allData,
      required this.gameType,
      required this.whicGameName,
      required this.controller})
      : super(key: key);

  final List<String> singleDigit = [
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9'
  ];
  final List<String> jodiDigit = [
    '00',
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    '07',
    '08',
    '09',
    '10',
    '11',
    '12',
    '13',
    '14',
    '95',
    '96',
    '97',
    '98',
    '99'
  ];
  final List<String> singlePanna = [
    '120',
    '123',
    '124',
    '125',
    '126',
    '127',
    '128',
    '129',
    '130',
    '134',
    '135',
    '136',
    '137',
    '138',
  ];
  final List<String> doublePanna = [
    '100',
    '110',
    '112',
    '113',
    '114',
    '115',
    '116',
    '117',
    '118',
    '119',
    '122',
    '133',
    '144',
    '155',
  ];
  final List<String> triplePanna = [
    '000',
    '111',
    '222',
    '333',
    '444',
    '555',
    '666',
    '777',
    '888',
    '999'
  ];
  final List<String> panna = [
    '000',
    '100',
    '110',
    '111',
    '112',
    '113',
    '114',
    '115',
    '116',
    '117',
    '118',
    '119',
    '120',
    '122',
    '123',
  ];

  List<String> _getDropdownList(String gameType) {
    switch (gameType) {
      case 'single_digit':
        return singleDigit;
      case 'jodi_digit':
        return jodiDigit;
      case 'singl_panna':
        return singlePanna;
      case 'double_panna':
        return doublePanna;
      case 'triple_panna':
        return triplePanna;

      default:
        return panna;
    }
  }

  Widget getOpenredio(dynamic gameData) {
    if (gameData is GaliDisawarGame) {
      // Handle GaliDisawarGame type
      return Visibility(
        visible: false,
        child: Row(
          children: [
            Radio(
              value: 0,
              groupValue: controller.selectedValue!.value,
              onChanged: (value) {
                controller.selectedValue!.value = value!;
              },
              activeColor: Colors.black,
            ),
            const Text('Open', style: TextStyle(color: Colors.black)),
            Radio(
              value: 1,
              groupValue: controller.selectedValue!.value,
              onChanged: (value) {
                controller.selectedValue!.value = value!;
              },
              activeColor: Colors.black,
            ),
            const Text('Close', style: TextStyle(color: Colors.black)),
          ],
        ),
      );
    } else if (gameData is StarlineGame) {
      // Handle StarlineGame type
      // Assuming StarlineGame has a property 'open', adjust the condition accordingly
      return Visibility(
        visible: false,
        child: Row(
          children: [
            Radio(
              value: 0,
              groupValue: controller.selectedValue!.value,
              onChanged: (value) {
                controller.selectedValue!.value = value!;
              },
              activeColor: Colors.black,
            ),
            const Text('Open', style: TextStyle(color: Colors.black)),
            Radio(
              value: 1,
              groupValue: controller.selectedValue!.value,
              onChanged: (value) {
                controller.selectedValue!.value = value!;
              },
              activeColor: Colors.black,
            ),
            const Text('Close', style: TextStyle(color: Colors.black)),
          ],
        ),
      );
    } else if (gameData is GameList) {
      // Handle 'single_digit' case
      return gameData.open
          ? Row(
              children: [
                Radio(
                  value: 0,
                  groupValue: controller.selectedValue.value,
                  onChanged: (value) {
                    controller.selectedValue.value = value!;
                  },
                  activeColor: Colors.black,
                ),
                const Text('Open', style: TextStyle(color: Colors.black)),
                Radio(
                  value: 1,
                  groupValue: controller.selectedValue.value,
                  onChanged: (value) {
                    controller.selectedValue.value = value!;
                  },
                  activeColor: Colors.black,
                ),
                const Text('Close', style: TextStyle(color: Colors.black)),
              ],
            )
          : Container();
    } else {
      // Handle default case
      return Container(); // or some default widget if needed
    }
  }

  void _addBid() {
    // Check if the required fields are not empty
    if (_pointController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter the points.');
      return;
    }

    if (controller.selectedDigit!.value.isEmpty) {
      Get.snackbar('Error', 'Please select a digit.');
      return;
    }
    switch (whicGameName) {
      case 'gali_disawar':
        controller.bids.add({
          "game_id": allData.id.toString(),
          "game_type": gameType.toString(),
          "session": controller.selectedValue.value == 0 ? "Open" : "Close",
          "bid_points": _pointController.text,
          "left_digit": controller.selectedValue.value == 0
              ? controller.selectedDigit!.value.toString()
              : "",
          "right_digit": controller.selectedValue.value == 1
              ? controller.selectedDigit!.value.toString()
              : "",
          "open_panna": "",
          "close_panna": ""
        });

        break;
      case 'star_line':
        controller.bids.add({
          "game_id": allData.id.toString(),
          "game_type": gameType.toString(),
          "session": controller.selectedValue.value == 0 ? "Open" : "Close",
          "bid_points": _pointController.text,
          "digit": controller.selectedValue.value == 0
              ? controller.selectedDigit!.value.toString()
              : "",
          "panna": controller.selectedValue.value == 1
              ? controller.selectedDigit!.value.toString()
              : "",
        });
        break;
      case 'main_game':
        controller.bids.add({
          "game_id": allData.id.toString(),
          "game_type": gameType.toString(),
          "session": controller.selectedValue.value == 0 ? "Open" : "Close",
          "bid_points": _pointController.text,
          "open_digit": controller.selectedValue.value == 0
              ? controller.selectedDigit!.value.toString()
              : "",
          "close_digit": controller.selectedValue.value == 1
              ? controller.selectedDigit!.value.toString()
              : "",
          "open_panna": "",
          "close_panna": ""
        });
        break;
      default:
        controller.bids.add({
          "game_id": allData.id.toString(),
          "game_type": gameType.toString(),
          "session": controller.selectedValue.value == 0 ? "Open" : "Close",
          "bid_points": _pointController.text,
          "open_digit": controller.selectedValue.value == 0
              ? controller.selectedDigit!.value.toString()
              : "",
          "close_digit": controller.selectedValue.value == 1
              ? controller.selectedDigit!.value.toString()
              : "",
          "open_panna": "",
          "close_panna": ""
        });

        break;
    }

    // If validation passes, add the bid

    // Clear the input fields after adding the bid
    controller.selectedDigit!.value = "";
    _pointController.clear();
  }

  void _deleteBid(int index) {
    controller.bids.removeAt(index);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        height: 900,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Today Date',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              const SizedBox(height: 4),
              Text(
                DateTime.now().toString().split(' ')[0],
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text(
                'Session Type',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              const SizedBox(height: 8),
              const SizedBox(height: 16),
              //===============//
              getOpenredio(allData),

              Row(
                children: [
                  Expanded(
                    child: DropdownButton<String>(
                      value: controller.selectedDigit!.value.isEmpty
                          ? null
                          : controller.selectedDigit!.value,
                      hint: const Text('Select Digit'),
                      items: _getDropdownList(gameType!).map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        controller.selectedDigit!.value = newValue!;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      controller: _pointController,
                      decoration: const InputDecoration(
                        hintText: 'Enter Point',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _addBid,
                style: ElevatedButton.styleFrom(
                  shadowColor: Colors.black,
                  backgroundColor: Colors.red[900],
                ),
                child: const Text('Add', style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 16),
              Container(
                color: Colors.red[800],
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: const Row(
                  children: [
                    Expanded(
                        child: Text('Digit',
                            style: TextStyle(color: Colors.white))),
                    Expanded(
                        child: Text('Point',
                            style: TextStyle(color: Colors.white))),
                    Expanded(
                        child: Text('Type',
                            style: TextStyle(color: Colors.white))),
                    Expanded(
                        child: Text('Delete',
                            style: TextStyle(color: Colors.white))),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.bids.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(
                            'Digit: ${controller.bids[index]['open_digit']} | Point: ${controller.bids[index]['bid_points']}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteBid(index),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Text('Total Bids: ${controller.bids.length}'),
                  ),
                  Expanded(
                    child: Text(
                        'Total Point: ${controller.bids.fold<int>(0, (sum, bid) => sum + int.parse(bid['bid_points'] ?? '0'))}'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  controller.fetchWinStatement(gameName: whicGameName);
                },
                style: ElevatedButton.styleFrom(
                  shadowColor: Colors.black,
                  backgroundColor: Colors.red[900],
                ),
                child:
                    const Text('Submit', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
