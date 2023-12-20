import 'package:flutter/material.dart';


  // Define custom colors for light theme
  final Color myColor =  Color(0xff303030);
    final Color myColor2 =  const Color.fromARGB(255, 61, 60, 60);
  final Color myColorWhite = Color.fromARGB(255, 255, 255, 255);
  final Color myColorWhite2 = Color.fromARGB(221, 249, 249, 249);
  final Color myColorRed = Color.fromARGB(255, 169, 37, 48);
  final Color myColorGray = Color.fromARGB(255, 217, 217, 217);
  
  
Color myColorDarkRed = Color.fromARGB(255, 130, 3, 3);
Color myColorgreen = Colors.green;


 var gredientColor =  LinearGradient(
              colors: [Color(0xFF8B0000), myColorRed], // Dark Red colors
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            );