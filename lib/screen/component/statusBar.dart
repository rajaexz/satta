import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:Billa/utilis/AllColor.dart';

class SystemUiConfig extends GetxController {
  Rx<SystemUiOverlayStyle> overlayStyle = Rx<SystemUiOverlayStyle>(
    SystemUiOverlayStyle(
      statusBarColor: myColorRed,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  void setStatusBarStyle(SystemUiOverlayStyle style) {
    overlayStyle.value = style;
  }
}
