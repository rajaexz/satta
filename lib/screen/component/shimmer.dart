import 'package:flutter/material.dart';
import 'package:winner11/utilis/AllColor.dart';
import 'package:winner11/utilis/boxSpace.dart';
import 'package:shimmer/shimmer.dart';

var showShummer = Shimmer.fromColors(
  baseColor: Color.fromARGB(255, 202, 200, 200),
  highlightColor: const Color.fromARGB(255, 245, 245, 245),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      mycontainerL(300.0),
      size20h,
      mycontainerL(200.0),
      size20h,
      mycontainerL(100.0),
      size20h,
      mycontainerL(300.0),
      size20h,
         size20h,
        mycontainerR(330.0),
      size20h,
      mycontainerR(200.0),
      size20h,
      mycontainerR(100.0),
      size20h,
      mycontainerR(300.0)
    ],
  ),
);

mycontainerL(summW) {
  return Container(
    width: summW,
    height: 20,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
    ),
  );
}
mycontainerR(summW) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Container(
        alignment: Alignment.topRight,
        width: summW,
        height: 20,
        decoration: BoxDecoration(
          color: myColorRed,
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    ],
  );
}



var showShummer2 = Shimmer.fromColors(
  baseColor: myColorRed,
  highlightColor: const Color.fromARGB(255, 245, 245, 245),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      mycontainerL(300.0),
      size20h,
      mycontainerL(200.0),
      size20h,
      mycontainerL(100.0),
      size20h,
      mycontainerL(300.0),
   
    ],
  ),
);



var summer2 = Shimmer.fromColors(
  baseColor: Color.fromARGB(255, 202, 200, 200),
  highlightColor: const Color.fromARGB(255, 245, 245, 245),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: Colors.white,
            width: 2.0,
          ),
        ),
        child: Container(
          width: 300,
          height: 200,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
                mycontainerL(300.0),
      size20h,
      mycontainerL(200.0),
      size20h,
      mycontainerL(100.0),
      size20h,
      mycontainerL(300.0),
            ],
          ),
        ),
      ),
   ],
  ),
);


var imageShimmer  = Image.asset(
    'assets/summer.png',
    width: 400,
    height: 799,
  );
      
