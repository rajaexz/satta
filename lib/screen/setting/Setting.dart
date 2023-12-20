import 'dart:io';

import 'package:winner11/utilis/borderbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:winner11/screen/header/appbar.dart';
import 'package:winner11/screen/header/headerTop.dart';
import 'package:winner11/service/authapi.dart';
import 'package:winner11/utilis/AllColor.dart';
import 'package:winner11/utilis/boxSpace.dart';
import 'package:winner11/utilis/fontstyle.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../utilis/globlemargin.dart';

class MySetting extends StatefulWidget {
  const MySetting({super.key});

  @override
  State<MySetting> createState() => _MySettingState();
}

class _MySettingState extends State<MySetting> {
      final ApiService apiService = ApiService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Settings',
      ),
      body: Container(
        margin: GlobleglobleMargin.globleMargin,
        child: Column(children: [
          Column(
            children: [
           
              
              ListTile(
                trailing: Icon(Icons.arrow_forward),
                leading: Icon(
                    Icons.info), // Change the icon to a different policy icon
                title: Row(
                  children: [
                    Text('KYC', style: CustomStyles.header2TextStyle),
                    size20w,
                    size20w,
                    size20w,
                    size20w,  size20w,
                   
             
                    size20w,
                     ],
                ),
                onTap: () {
                  Get.toNamed('/kyc');
                },
              ),
          
                 ListTile(
                trailing: Icon(Icons.arrow_forward),
                leading: Icon(
                    Icons.info), // Change the icon to a different policy icon
                title: Row(
                  children: [
                    Text('Rate Us', style: CustomStyles.header2TextStyle),
                 
                  ],
                ),
                onTap: () {
                  showRateUsDialogRating(context);
                  
                },
              ),

              
                 ListTile(
                trailing: Icon(Icons.arrow_forward),
                leading: Icon(
                    Icons.info), // Change the icon to a different policy icon
                title: Row(
                  children: [
                    Text('Check For Update', style: CustomStyles.header2TextStyle),
                 
                  ],
                ),
                onTap: () {
                 showRateUsDialogUpdate(context);
                  
                },
              ),
                 ListTile(
                trailing: Icon(Icons.arrow_forward),
                leading: Icon(
                    Icons.info), // Change the icon to a different policy icon
                title: Row(
                  children: [
                    Text('Withdraw', style: CustomStyles.header2TextStyle),
                 
                  ],
                ),
                onTap: () {
                  Get.toNamed('/withdraw');
                },
              ),

               ListTile(
                trailing: Icon(Icons.arrow_forward),
                leading: Icon(
                    Icons.info), // Change the icon to a different policy icon
                title: Row(
                  children: [
                    Text('History Wallet', style: CustomStyles.header2TextStyle),
                 
                  ],
                ),
                onTap: () {
                
    Get.toNamed("/historyWallet");  },
              ),
        ],
          )
        ]),
      ),
    );
  }
}






customSliderbarUpdate(context, name, icons) {
  return InkWell(
    onTap: () async {
      showRateUsDialogUpdate(context);
    },
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: Container(
            height: 40,
            width: 100,
            margin: const EdgeInsets.only(left: 5, right: 5),
            decoration: BoxDecoration(
              borderRadius:boRadiusAll,
            ),
            child: Icon(icons),
          ),
        ),
        Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style:CustomStyles.header2TextStyle),
                const SizedBox(
                  height: 5,
                ),
              ],
            )),
        Expanded(
          flex: 1,
          child: Container(
            height: 70,
            width: 100,
            margin: const EdgeInsets.only(left: 10),
            child: InkWell(
                onTap: () {}, child: const Icon(Icons.arrow_forward_ios)),
          ),
        ),
      ],
    ),
  );
}
showRateUsDialogUpdate(BuildContext context) async {

  return showDialog<bool>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: myColorWhite,
        contentTextStyle: TextStyle(
          color: myColor,
          fontFamily: 'Lora',
          fontWeight: FontWeight.w400,
          fontSize: 10,
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Update Available",
              style: TextStyle(
                color: myColor,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Please consider updating us!",
              style: TextStyle(
                color:myColor,
                fontSize: 16,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(
              "Maybe later",

            ),
          ),
          TextButton(
            onPressed: () {
              launchRateAppURLUpdate();
              Navigator.pop(context, true);
            },
            child: Text(
              "Update Now",
   
            ),
          ),
        ],
      );
    },
  );
}

void launchRateAppURLUpdate() async {
  // The package name (Android) or app ID (iOS) of your app
  const String packageName = 'your_app_package_name';
  const String iOSAppId = 'your_app_id';

  if (await canLaunchUrl(
      Uri.parse(_getStoreUrlUpdata(packageName, iOSAppId)))) {
    await launchUrl(Uri.parse(_getStoreUrlUpdata(packageName, iOSAppId)));
  } else {
    throw 'Could not launch store URL';
  }
}

String _getStoreUrlUpdata(String packageName, String iOSAppId) {
  if (Platform.isAndroid) {
    return 'https://play.google.com/store/apps/details?id=$packageName';
  } else if (Platform.isIOS) {
    return 'https://apps.apple.com/us/app/your-app-name/$iOSAppId';
  } else {
    throw 'Unsupported platform';
  }
}

/////////////////////////////////////////////////////rating 
showRateUsDialogRating(BuildContext context) async {


  return showDialog<bool>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor:myColorWhite,
        contentTextStyle: TextStyle(
          color: 
              
               myColor,
          fontFamily: 'Lora',
          fontWeight: FontWeight.w400,
          fontSize: 10,
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Enjoying our app?",
              style: TextStyle(
                color:  myColor,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Please consider rating us!",
              style: TextStyle(
                color: myColor,
                fontSize: 16,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(
              "Maybe later",
              style: TextStyle(
                color: myColor,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              launchRateAppURL();
              Navigator.pop(context, true);
            },
            child: Text(
              "Rate Now",
              style: TextStyle(color: myColor),
            ),
          ),
        ],
      );
    },
  );
}

void launchRateAppURL() async {
  // The package name (Android) or app ID (iOS) of your app
  const String packageName = 'your_app_package_name';
  const String iOSAppId = 'your_app_id';

  if (await canLaunchUrl(Uri.parse(_getStoreUrl(packageName, iOSAppId)))) {
    await launchUrl(Uri.parse(_getStoreUrl(packageName, iOSAppId)));
  } else {
    throw 'Could not launch store URL';
  }
}
String _getStoreUrl(String packageName, String iOSAppId) {
  if (Platform.isAndroid) {
    return 'https://play.google.com/store/apps/details?id=$packageName';
  } else if (Platform.isIOS) {
    return 'https://apps.apple.com/us/app/your-app-name/$iOSAppId';
  } else {
    throw 'Unsupported platform';
  }
}
