  import 'package:flutter/material.dart';

import '../header/appbar.dart';

class SingleDigitPage extends StatelessWidget {
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
              const Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Enter Digit',
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
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
                  itemCount: 0, // Update this with your item count
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      color: Colors.red[700],
                      child: Row(
                        children: [
                          const Expanded(child: Text('Digit', style: TextStyle(color: Colors.black))),
                          const Expanded(child: Text('Point', style: TextStyle(color: Colors.black))),
                          const Expanded(child: Text('Type', style: TextStyle(color: Colors.black))),
                          Expanded(
                            child: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.black),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              const Row(
                children: [
                  Expanded(
                    child: Text(
                      'Total Bids : 0',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Total Point : 0',
                      style: TextStyle(color: Colors.black),
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
                child: const Text('Submit',style: TextStyle(color: Colors.white),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}