import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winner11/screen/component/darkmode.dart';
import 'package:winner11/screen/profile/controller/profile_controller.dart';

import 'package:winner11/utilis/AllColor.dart';
import 'package:winner11/utilis/borderbox.dart';
import 'package:winner11/utilis/boxSpace.dart';
import 'package:winner11/utilis/fontstyle.dart';
import '../../network/storage_repository.dart';
import '../../service/authapi.dart';

final ThemeController themeController = Get.put(ThemeController());

Drawer myDrawer(BuildContext context) {
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
      'iconData': Icons.transfer_within_a_station,
      'title': 'Transfer',
      'onTap': () async {
        Get.toNamed('/transfer');
      },
    },
    {
      'iconData': Icons.biotech,
      'title': 'Bit History',
      'onTap': () async {
        Get.toNamed('/bitHistory');
      },
    },

    
    {
      'iconData': Icons.payment,
      'title': 'Payment',
      'onTap': () async {
        Get.toNamed('/paymentScreen');
      },
    },
    {
      'iconData': Icons.wind_power,
      'title': 'Win History',
      'onTap': () async {
        Get.toNamed('/winHistory');
      },
    },
    {
      'iconData': Icons.security,
      'title': 'Add Bank Account',
      'onTap': () async {
        Get.toNamed('/kyc');
      },
    },
  ];

  Widget customListTile({
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

  List<Widget> buildList(List<Map<String, dynamic>> data) {
    return data
        .map((item) => customListTile(
              iconData: item['iconData'],
              title: item['title'],
              onTap: item['onTap'],
            ))
        .toList();
  }

  return Drawer(
    child: Obx(
      () => ListView(
        children: [
          profileInfo(),
          Container(
            margin: EdgeInsets.all(13),
            decoration: BoxDecoration(
              border: border,
              borderRadius: boRadiusAll,
              color: themeController.isLightMode.value ? myColorWhite : myColor,
              boxShadow: [
                themeController.isLightMode.value ? boxdark : boxshadow2
              ],
            ),
            child: Column(
              children: buildList(tileData),
            ),
          ),
          Container(
            margin: EdgeInsets.all(13),
            decoration: BoxDecoration(
              border: border,
              borderRadius: boRadiusAll,
              color: themeController.isLightMode.value ? myColorWhite : myColor,
              boxShadow: [
                themeController.isLightMode.value ? boxdark : boxshadow2
              ],
            ),
            child: Column(
              children: buildList(impotentData),
            ),
          ),
          Container(
            margin: EdgeInsets.all(13),
            decoration: BoxDecoration(
              border: border,
              borderRadius: boRadiusAll,
              color: themeController.isLightMode.value ? myColorWhite : myColor,
              boxShadow: [
                themeController.isLightMode.value ? boxdark : boxshadow2
              ],
            ),
            child: Column(
              children: buildList(moreData),
            ),
          ),
          TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(myColorRed),
              padding: MaterialStateProperty.all(
                EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              ),
            ),
            onPressed: () {
              StorageRepository.destroyOfflineStorage();
              Get.toNamed('/login');
            },
            child: Text(
              "Logout",
              style: CustomStyleswhite.header2TextStyle,
            ),
          ),
          size10h,
        ],
      ),
    ),
  );
}

Widget profileInfo() {
      UserDetailsController? controller  = Get.put(UserDetailsController());

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
                borderRadius: BorderRadius.all(Radius.circular(100)),
              ),
              margin: EdgeInsets.only(bottom: 10, top: 100),
              child: CircleAvatar(
                radius: 50.0,
                backgroundImage: AssetImage("assets/logo.jpeg"),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  controller!.userDetails.value.data!.username ,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: CustomStyleswhite.headerTextStyle,
                ),
                Text(  controller!.userDetails.value.data!.mobile, style: CustomStyles.textExternelgray),
                size20h,
              ],
            ),
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
          child: Row(
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
          ),
        ),
      ),
    ],
  );
}
