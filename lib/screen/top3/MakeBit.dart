import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winner11/screen/header/appbar.dart';
import 'package:winner11/screen/top3/controller/MakeBit_controller.dart';
class MakeBitPage extends StatelessWidget {
  final String? title;
  final dynamic allData;

  MakeBitPage({Key? key, this.title, required this.allData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MakeBiteController controller = Get.put(MakeBiteController(allData));

    return Scaffold(
      appBar: CustomAppBar(title: title?.replaceAll('_', ' ').toUpperCase() ?? ''),
      body: GetBuilder<MakeBiteController>(
        builder: (controller) => MakeBitPageScreen(
          controller: controller,
          gameType: title,
          allData: allData,
        ),
      ),
    );
  }
}
class MakeBitPageScreen extends StatelessWidget {

  final TextEditingController _pointController = TextEditingController();
  final String? gameType;
  final dynamic allData;
  final MakeBiteController controller;

  final List<String> digitOptions = List<String>.generate(10, (i) => i.toString());

  String? _selectedDigit;

  MakeBitPageScreen({Key? key, required this.allData, this.gameType, required this.controller}) : super(key: key);

  void _addBid() {
    // Check if the required fields are not empty
    if (_pointController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter the points.');
      return;
    }

    if (_selectedDigit == null || _selectedDigit!.isEmpty) {
      Get.snackbar('Error', 'Please select a digit.');
      return;
    }

    // If validation passes, add the bid
  controller. bids.add({
      "game_id": allData.id,
      "game_type": gameType ?? '',
      "session": controller.selectedValue.value == 0 ? "Open" : "Close",
      "bid_points": _pointController.text,
      "open_digit": controller.selectedValue.value == 0 ? _selectedDigit! : "",
      "close_digit": controller.selectedValue.value == 1 ? _selectedDigit! : "",
      "open_panna": "",
      "close_panna": ""
    });

    // Clear the input fields after adding the bid
    _selectedDigit = null;
    _pointController.clear();
  }

  void _deleteBid(int index) {
     controller. bids.removeAt(index);
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
                style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text(
                'Session Type',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              const SizedBox(height: 8),
              Row(
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
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: DropdownButton<String>(
                      value: _selectedDigit,
                      hint: const Text('Select Digit'),
                      items: digitOptions.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        _selectedDigit = newValue!;
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
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: const Row(
                  children: [
                    Expanded(child: Text('Digit', style: TextStyle(color: Colors.white))),
                    Expanded(child: Text('Point', style: TextStyle(color: Colors.white))),
                    Expanded(child: Text('Type', style: TextStyle(color: Colors.white))),
                    Expanded(child: Text('Delete', style: TextStyle(color: Colors.white))),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount:  controller. bids.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(
                            'Digit: ${ controller. bids[index]['open_digit']} | Point: ${ controller. bids[index]['bid_points']}'),
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
                    child: Text('Total Bids: ${ controller. bids.length}'),
                  ),
                  Expanded(
                    child: Text('Total Point: ${ controller. bids.fold<int>(0, (sum, bid) => sum + int.parse(bid['bid_points'] ?? '0'))}'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  controller.fetchWinStatement( 
                  );
                },
                style: ElevatedButton.styleFrom(
                  shadowColor: Colors.black,
                  backgroundColor: Colors.red[900],
                ),
                child: const Text('Submit', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
