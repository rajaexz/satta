import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:Billa/utilis/AllColor.dart';

class CustomStyles {
  static TextStyle verysmallTextStyle = TextStyle(
    fontSize: 8,
    fontWeight: FontWeight.w700,
    fontFamily: 'Roboto1', // Use the same font family name here
  );
  static TextStyle smallTextStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    fontFamily: 'Roboto1', // Use the same font family name here
  );

  static TextStyle headerTextStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    fontFamily: 'Roboto1', // Use the same font family name here
  );
  static TextStyle header2TextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    fontFamily: 'Roboto1', // Use the same font family name here
  );
  static TextStyle header3TextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    fontFamily: 'Roboto1', // Use the same font family name here
  );
  static TextStyle header5TextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    fontFamily: 'Roboto1', // Use the same font family name here
  );

  // textExternel text
  static TextStyle textExternel = TextStyle(
      color: myColorRed, fontFamily: "Roboto1", fontWeight: FontWeight.bold);

  static TextStyle textExternelgreen = TextStyle(
      fontFamily: "Roboto1",
      color: myColorgreen,
      fontSize: 12,
      fontWeight: FontWeight.w400);

  static TextStyle textExternelgray = TextStyle(
      fontFamily: "Roboto1",
      color: myColorGray,
      fontSize: 12,
      fontWeight: FontWeight.w400);
}

// white font style
class CustomStyleswhite {
  static TextStyle verysmallTextStyle = TextStyle(
    color: myColorWhite,
    fontSize: 8,
    fontWeight: FontWeight.w700,
    fontFamily: 'Roboto1', // Use the same font family name here
  );
  static TextStyle smallTextStyle = TextStyle(
    color: myColorWhite,
    fontSize: 12,
    fontWeight: FontWeight.w700,
    fontFamily: 'Roboto1', // Use the same font family name here
  );

  static TextStyle headerTextStyle = TextStyle(
    color: myColorWhite,
    fontSize: 20,
    fontWeight: FontWeight.w700,
    fontFamily: 'Roboto1', // Use the same font family name here
  );
  static TextStyle header2TextStyle = TextStyle(
    color: myColorWhite,
    fontSize: 18,
    fontWeight: FontWeight.w400,
    fontFamily: 'Roboto1', // Use the same font family name here
  );
}
