

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../header/appbar.dart';
import '../top3/SingleDigitPage.dart';

class GridViewWidget extends StatelessWidget {
    final List<String> imageUrls = [
    'https://th.bing.com/th/id/OIP.y0OiNv_Nn1a5Zn9kZYWDVQHaHd?rs=1&pid=ImgDetMain ',
    'https://clipart-library.com/new_gallery/dice-clipart-1.jpeg',
    'https://pngimg.com/uploads/dice/dice_PNG87.png',
    'https://w7.pngwing.com/pngs/989/1002/png-transparent-dominoes-dice-free-content-dice-s-free-game-white-rectangle-thumbnail.png',
    'https://placeimg.com/640/480/any',
     'https://placeimg.com/640/480/any',
      'https://placeimg.com/640/480/any',
  ];

      final List<String> gametype = [
    'Single Digit',
    'Jodi Digit',
    'Single Patti',
    'Doudle Patti',
    'Triple Patti',
      'Half Sangam',
        'Full Sangam',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: "My Game ",
        ),
      backgroundColor: Colors.white,
      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(4, (index) {
          return GestureDetector(
            onTap: () {
          
          Get.to(  SingleDigitPage() );
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
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      imageUrls[index], // Replace with your image URL
                      fit: BoxFit.cover,
                    ),
                  ),

                 Center(
                   child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color:  Color.fromARGB(255, 185, 23, 11),),
                     width: 80,
                     height: 40,
                     alignment:Alignment.center,
                     child: Text(gametype[index], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold,),),
                   ),
                 )

                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}