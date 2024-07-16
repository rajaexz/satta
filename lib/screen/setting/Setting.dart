import 'dart:io';

import 'package:Billa/screen/component/darkmode.dart';
import 'package:Billa/utilis/borderbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:Billa/screen/header/appbar.dart';
import 'package:Billa/screen/header/headerTop.dart';
import 'package:Billa/service/authapi.dart';
import 'package:Billa/utilis/AllColor.dart';
import 'package:Billa/utilis/boxSpace.dart';
import 'package:Billa/utilis/fontstyle.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../utilis/globlemargin.dart';

import '../../service/authapi.dart';

final ThemeController themeController = Get.put(ThemeController());

class MySetting extends StatefulWidget {
  const MySetting({super.key});

  @override
  State<MySetting> createState() => _MySettingState();
}

class _MySettingState extends State<MySetting> {
  @override
  Widget build(BuildContext context) {
    List<Widget> listTiles = [];

    List<Map<String, dynamic>> tileData = [
      {
        'iconData': Icons.star_rate,
        'title': 'Rate Us',
        'onTap': () async {
          showRateUsDialogRating(context);
        },
      },
      {
        'iconData': Icons.update,
        'title': 'Chech for Update',
        'onTap': () async {
          showRateUsDialogUpdate(context);
        },
      },
      {
        'iconData': Icons.wallet,
        'title': 'Wallet History',
        'onTap': () async {
          Get.toNamed("/historyWallet");
        },
      },
    ];

    for (int index = 0; index < tileData.length; index++) {
      var data = tileData[index];
      listTiles.add(
        customListTile(
          index: index,
          iconData: data['iconData'],
          title: data['title'],
          onTap: data['onTap'],
        ),
      );
    }
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Settings',
      ),
      body: Container(
        margin: GlobleglobleMargin.globleMargin,
        child: Column(children: [
          Column(
            children: [
              Column(
                children: listTiles,
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
              borderRadius: boRadiusAll,
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
                Text(name, style: CustomStyles.header2TextStyle),
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
              "Enjoying our app?",
              style: TextStyle(
                color: myColor,
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

Widget customListTile({
  required int index,
  required IconData iconData,
  required String title,
  required VoidCallback onTap,
}) {
  return Obx(
    () => Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: border,
        borderRadius: boRadiusAll,
        color: themeController.isLightMode.value ? myColorWhite : myColor,
        boxShadow: [themeController.isLightMode.value ? boxdark : boxshadow2],
      ),
      child: ListTile(
        leading: Icon(iconData),
        title: Text(title, style: CustomStyles.header2TextStyle),
        onTap: onTap,
      ),
    ),
  );
}
