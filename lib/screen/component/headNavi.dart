import 'package:flutter/material.dart';
import 'package:Billa/utilis/AllColor.dart';

createPositioned(context) {
  return Positioned(
    top: 25.0,
    left: 0.0,
    child: MaterialButton(
      onPressed: () {
        Navigator.pop(context);
      },
      textColor: myColor,
      padding: const EdgeInsets.all(6),
      child: const Icon(
        Icons.arrow_back,
        size: 25,
      ),
    ),
  );
}
