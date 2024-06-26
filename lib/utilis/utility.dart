import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:url_launcher/url_launcher.dart';
import 'dart:math' as math;

import '../network/storage_repository.dart';

import 'app_constant.dart';

class Utility {
  static Future<void> launchEmailViewOrVC(String url) async {
    if (!await launchUrl(
      Uri(scheme: "mailto", path: url),
    )) {
      throw 'Could not launch $url';
    }
  }

  static Future<void> launchMobile(String url) async {
    if (!await launchUrl(
      Uri(scheme: "tel", path: url),
    )) {
      throw 'Could not launch $url';
    }
  }

  static InputDecoration getInputDecoration(String hintText) => InputDecoration(
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        hintText: hintText,
        hintStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.italic,
            color: Colors.grey),
        filled: true,
        fillColor: Color(0xffF4F5F5),
      );

  static showError(String message) {
    // showNotification(
    //     title: "Error!",
    //     message: message,
    //     backgroundColor: Colors.red,
    //     autoDismissible: true,
    //     messageStyle: Styles.notificationStyle,
    //     titleStyle: Styles.notificationStyle,
    //     animDuration: 500);
  }

  static showSuccess(String message) {
    // showNotification(
    //     title: "Success!",
    //     message: message,
    //     autoDismissible: true,
    //     backgroundColor: Colors.green,
    //     messageStyle: Styles.notificationStyle,
    //     titleStyle: Styles.notificationStyle,
    //     animDuration: 500);
  }

  static showWarning(String message) {
    // showNotification(
    //     title: "Success!",
    //     message: message,
    //     autoDismissible: true,
    //     backgroundColor: Colors.yellowAccent,
    //     messageStyle: Styles.notificationStyle,
    //     titleStyle: Styles.notificationStyle,
    //     animDuration: 500);
    // ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
    //   content: Text("${message}"),
    //   backgroundColor: Colors.yellowAccent,
    // ));
  }

  static void loggedOut() async {
    // try{
    //   await StartUpService.networkProvider!.getCommonCall(ApiPath.logout,{"aa":""});
    //   await StorageRepository.destroyOfflineStorage();
    //   await Get.putAsync(() => StartUpService().init());
    //   Get.offAllNamed(Routes.login);
    // }catch(e){
    //   Get.offAllNamed(Routes.login);
    //
    // }
  }
}
