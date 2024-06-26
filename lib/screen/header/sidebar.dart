import 'package:winner11/screen/component/darkmode.dart';
import 'package:winner11/screen/header/Userdata_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winner11/screen/component/shimmer.dart';
import 'package:winner11/utilis/AllColor.dart';
import 'package:winner11/utilis/borderbox.dart';
import 'package:winner11/utilis/boxSpace.dart';

import 'package:winner11/utilis/fontstyle.dart';

import '../../network/storage_repository.dart';
import '../../service/authapi.dart';

final ThemeController themeController = Get.put(ThemeController());
Drawer myDrawer(context) {
  List<Widget> listTiles = [];
  List<Widget> listData = [];
  List<Widget> impotent = [];
  List<Map<String, dynamic>> tileData = [
    {
      'iconData': Icons.settings,
      'title': 'Settings',
      'onTap': () async {
        Get.toNamed('/setting');
      },
    },
  ];

  List<Map<String, dynamic>> moreData = [
    {
      'iconData': Icons.info,
      'title': 'Terms & Condition',
      'onTap': () async {
        Get.toNamed('/tarmAnd');
      },
    },
    {
      'iconData': Icons.account_circle,
      'title': 'About Us',
      'onTap': () async {
        Get.toNamed('/myAboutus');
      },
    },
    {
      'iconData': Icons.help,
      'title': 'Privacy Policy',
      'onTap': () async {
        Get.toNamed('/privacy');
      },
    },
    {
      'iconData': Icons.help,
      'title': 'FAQ',
      'onTap': () async {
        Get.toNamed('/faq');
      },
    },
  ];

  List<Map<String, dynamic>> impotentData = [
    {
      'iconData': Icons.money,
      'title': 'Withdraw',
      'onTap': () async {
        Get.toNamed('/withdraw');
      },
    },
    {
      'iconData': Icons.security,
      'title': 'Add bank Account',
      'onTap': () async {
        Get.toNamed('/kyc');
      },
    },
  ];

  Widget customListTile({
    required int index,
    required IconData iconData,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(
        iconData,
        color: myColorRed,
      ),
      title: Text(title, style: CustomStyles.header2TextStyle),
      onTap: onTap,
    );
  }

//////////////////////////////////////////////////////////////
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

//////////////////////////////////////////////////////////////
  for (int index = 0; index < moreData.length; index++) {
    var data = moreData[index];
    listData.add(
      customListTile(
        index: index,
        iconData: data['iconData'],
        title: data['title'],
        onTap: data['onTap'],
      ),
    );
  }
//////////////////////////////////////////////////////////////
  for (int index = 0; index < impotentData.length; index++) {
    var data = impotentData[index];
    impotent.add(
      customListTile(
        index: index,
        iconData: data['iconData'],
        title: data['title'],
        onTap: data['onTap'],
      ),
    );
  }

  return Drawer(
    child: Obx(
      () => Column(
        children: [
          Expanded(
            child: Column(
              children: [
                profileInfo(),
                Container(
                  margin: EdgeInsets.all(13),
                  decoration: BoxDecoration(
                    border: border,
                    borderRadius: boRadiusAll,
                    color: themeController.isLightMode.value
                        ? myColorWhite
                        : myColor,
                    boxShadow: [
                      themeController.isLightMode.value ? boxdark : boxshadow2
                    ],
                  ),
                  child: Column(
                    children: listTiles,
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(13),
                  decoration: BoxDecoration(
                    border: border,
                    borderRadius: boRadiusAll,
                    color: themeController.isLightMode.value
                        ? myColorWhite
                        : myColor,
                    boxShadow: [
                      themeController.isLightMode.value ? boxdark : boxshadow2
                    ],
                  ),
                  child: Column(
                    children: impotent,
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(13),
                  decoration: BoxDecoration(
                    border: border,
                    borderRadius: boRadiusAll,
                    color: themeController.isLightMode.value
                        ? myColorWhite
                        : myColor,
                    boxShadow: [
                      themeController.isLightMode.value ? boxdark : boxshadow2
                    ],
                  ),
                  child: Column(
                    children: listData,
                  ),
                ),
              ],
            ),
          ),
          TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(myColorRed),
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 30, vertical: 10))),
              isSemanticButton: true,
              onPressed: () {
                StorageRepository.destroyOfflineStorage();
                Get.toNamed('/login');
              },
              child: Text(
                "Logout",
                style: CustomStyleswhite.header2TextStyle,
              )),
          size10h
        ],
      ),
    ),
  );
}

profileInfo() {
  return Stack(
    alignment: Alignment.topCenter,
    children: [
      Container(
        color: myColor,
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  border: border,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(100),
                  )),
              margin: const EdgeInsets.only(bottom: 10, top: 100),
              child: const CircleAvatar(
                  radius: 50.0,
                  backgroundImage: AssetImage("assets/logo.jpeg")),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("7011448878",
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: CustomStyleswhite.headerTextStyle),
                Text("raja " ?? "", style: CustomStyles.textExternelgray),
                size20h
              ],
            )
          ],
        ),
      ),
      Positioned(
        left: 20,
        top: 100,
        child: InkWell(
            onTap: () {
              Get.toNamed("/showProfile");
            },
            child: const Row(
              children: [
                Icon(
                  Icons.list_alt,
                  size: 40,
                  color: Colors.white,
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                  color: Colors.white,
                ),
              ],
            )),
      ),
    ],
  );
}
