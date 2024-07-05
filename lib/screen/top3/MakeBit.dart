  import 'package:flutter/material.dart';

import '../header/appbar.dart';

class SingleDigitPage extends StatelessWidget {

  final List<Map<String, String>> _bids = [];
  final TextEditingController _openDigitController = TextEditingController();
  final TextEditingController _pointPanaController = TextEditingController();
  final TextEditingController _pointController = TextEditingController();

  SingleDigitPage({super.key});
    void _addBid() {
    // setState(() {
      _bids.add({
        'digit': _openDigitController.text,
        'pana': _pointPanaController.text,
        'point': _pointController.text,
      // });
    });

    _openDigitController.clear();
    _pointPanaController.clear();
    _pointController.clear();
  }
 void _deleteBid(int index) {
    // setState(() {
      _bids.removeAt(index);
    // });
  }
 
 
 
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: CustomAppBar(
          title: "SINGLE DIGIT",
        ),
      body: SizedBox(
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
              const Text(
                '23-6-2024',
                style: TextStyle(
                    color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
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
                    groupValue: 1,
                    onChanged: (value) {},
                    activeColor: Colors.black,
                  ),
                  const Text('Open', style: TextStyle(color: Colors.black)),
                  Radio(
                    value: 1,
                    groupValue: 1,
                    onChanged: (value) {},
                    activeColor: Colors.black,
                  ),
                  const Text('Close', style: TextStyle(color: Colors.black)),
                ],
              ),
              const SizedBox(height: 16),
               Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _openDigitController,
                      decoration: const InputDecoration(
                        hintText: 'Enter Digit',
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(

                    child: TextField(
                          
                              controller: _pointPanaController,
                      decoration: const InputDecoration(
                        hintText: 'Enter Point',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                shadowColor: Colors.black,
                  backgroundColor: Colors.red[900],
                ),
                child: const Text('Add'),
              ),
              const SizedBox(height: 16),
              Container(
                color: Colors.red[800],
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: const Row(
                  children: [
                    Expanded(child: Text('Digit', style: TextStyle(color: Colors.black))),
                    Expanded(child: Text('Point', style: TextStyle(color: Colors.black))),
                    Expanded(child: Text('Type', style: TextStyle(color: Colors.black))),
                    Expanded(child: Text('Delete', style: TextStyle(color: Colors.black))),
                  ],
                ),
              ),
            Expanded(
              child: ListView.builder(
                itemCount: _bids.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text('Digit: ${_bids[index]['digit']} | Pana: ${_bids[index]['pana']} | Point: ${_bids[index]['point']}'),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteBid(index),
                      ),
                    ),
                  );
                },
              ),
            ),     const SizedBox(height: 16),
               Row(
                children: [
                  Expanded(
                    child:  Text('Total Bids: ${_bids.length}'),
                    ),
                   Expanded(
                  child: Text('Total Point: ${_bids.fold<int>(0, (sum, bid) => sum + int.parse(bid['point'] ?? '0'))}'),

          
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
             shadowColor: Colors.black,
                  backgroundColor: Colors.red[900],
                ),
                child: const Text('Submit',style: TextStyle(color: Colors.white),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}