import 'package:Billa/service/authapi.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';

//contraction
// contractionDeviceInfo(context) async {
//   final ApiService apiService = ApiService();

//   var data = await apiService.userallGet(uri: "/toggle_get_user");

//   if (data["status"] == "200") {

//     if (data["data"]["status"] != "Active") {

//       await DialogHelper.showInputDialog(context);
//     }
//   } else {
//     return null;
//   }
// }

Future<void> getDeviceInfo(context) async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  AndroidDeviceInfo androidInfo;
  IosDeviceInfo iosInfo;
  var deviceId = "";
  var deviceName = "";
  try {
    if (Theme.of(context).platform == TargetPlatform.android) {
      androidInfo = await deviceInfo.androidInfo;
      deviceId = androidInfo.androidId;
      deviceName = androidInfo.model;
      if (androidInfo != "" && deviceId != "" && deviceName != "") {
        var demo = {};
      } else {
        return;
      }
    } else if (Theme.of(context).platform == TargetPlatform.iOS) {
      iosInfo = await deviceInfo.iosInfo;
      deviceId = iosInfo.identifierForVendor;
      deviceName = iosInfo.utsname.machine;

      if (iosInfo != "" && deviceId != "" && deviceName != "") {
        var demo = {};
      } else {
        return;
      }
    }
  } catch (e) {
    print('Error getting device info: $e');
  }
}
