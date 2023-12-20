  import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:winner11/utilis/borderbox.dart';
// ignore: non_constant_identifier_names
ImageComponent({dynamic myWidth, dynamic myheight,myImage}){
  return    Container(
                          width: myWidth ,
                          height: myheight ,
                          decoration: BoxDecoration(
                           image:  DecorationImage(
                        image: AssetImage(myImage),
                        fit: BoxFit.contain,
                        alignment: Alignment.centerRight),
                         
                          ),
                           );
  }
ImageComponentNet({dynamic myWidth, dynamic myheight, myImage}){
  return   Container(
  width: myWidth,
  height: myheight,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(50),
    border: border3
  ),
  child: ClipRRect(
    borderRadius: BorderRadius.circular(50),
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5), // Adjust the opacity as needed
        ),
        child: Image.network(
          myImage.toString(),
          fit: BoxFit.fill,
          alignment: Alignment.centerRight,
        ),
      ),
    ),
  ),
);

  }
  var summerImage  = BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/top-banner.png"),
             fit: BoxFit.cover)
        );