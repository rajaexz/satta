
import 'package:flutter/material.dart';

import 'package:winner11/utilis/AllColor.dart';

BorderRadius boRadiusAll = const BorderRadius.all(
  Radius.circular(10),
);


BorderRadius boRadius5 = const BorderRadius.all(
  Radius.circular(5),
);

////////////////////////////Border
Border border = Border.all(

  color: myColorGray,
  width: 0.5,
  style: BorderStyle.solid,
);
Border border2 = Border.all(
  color: myColorGray,
  width: 0.6,
  style: BorderStyle.solid,
);
Border border3 = Border.all(
  color: myColorRed,
  width:2,
  style: BorderStyle.solid,
);
Border borderRed = Border.all(
  color: myColorRed,
  width: 0.5,
  style: BorderStyle.solid,
);

Border borderB =  const Border(
      bottom: BorderSide(
      
        width: 0.5,
        style: BorderStyle.solid,
      ),);

Border borderT =  const Border(
      top: BorderSide(
      
        width: 0.5,
        style: BorderStyle.solid,
      ),);


      
var boxshadow = BoxShadow(
  color:   myColorGray,
  blurRadius: 6.0,
  spreadRadius: 2.0,
  offset: Offset(1.0, 1.0),
);
var boxshadow2 =    BoxShadow(
                  color:Color.fromARGB(255, 224, 224, 224),
                  offset: Offset(0.0, 0.0),
                  blurRadius: 2.0,
                );

                var boxdark =    BoxShadow(
                  color: Color.fromRGBO(17, 17, 26, 0.05),
                  offset: Offset(0, 4),
                  blurRadius: 16,
                );
               