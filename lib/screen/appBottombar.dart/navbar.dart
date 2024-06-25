import 'package:winner11/screen/component/darkmode.dart';
import 'package:winner11/utilis/AllColor.dart';
import 'package:flutter/material.dart';

import 'package:winner11/utilis/borderbox.dart';
import 'package:winner11/utilis/fontstyle.dart';
import 'package:get/get.dart';

class NavBarMusicWidget extends StatefulWidget {
  const NavBarMusicWidget({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _NavBarMusicWidgetState createState() => _NavBarMusicWidgetState();
}

class _NavBarMusicWidgetState extends State<NavBarMusicWidget> {
  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
  }

  final ThemeController themeController = Get.put(ThemeController());
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
            color: themeController.isLightMode.value ? myColorWhite : myColor,
            boxShadow: [
              themeController.isLightMode.value ? boxshadow2 : boxdark
            ]),
        child: Stack(
          children: [
            Row(
          
              mainAxisAlignment: MainAxisAlignment.spaceAround,
           
              children: [

                InkWell(
  onTap: () {
    Get.toNamed("/home");
  },
  child: TextButtonapp(
    text: "Home",
    icon: themeController.isLightMode.value
        ? Icon(Icons.home_outlined)
        : Icon(Icons.home, color: Colors.white),
  ),
),
       InkWell(
  onTap: () {
    Get.toNamed('/myContestStatus');
  },
  child: TextButtonapp(
    text: "My Contest",
    icon: themeController.isLightMode.value
        ? Icon(Icons.play_arrow_outlined)
        : Icon(Icons.play_arrow, color: Colors.white), // Customize color if needed
  ),
),
InkWell(
  onTap: () {
    Get.toNamed("/blog");
  },
  child: TextButtonapp(
    text: "News",
    icon: themeController.isLightMode.value
        ? Icon(Icons.sports_cricket_outlined)
        : Icon(Icons.sports_cricket, color: Colors.white),
  ),
),
InkWell(
  onTap: () {
    Get.toNamed('/live');
  },
  child: TextButtonapp(
    text: "Live",
    icon: themeController.isLightMode.value
        ? Icon(Icons.live_tv)
        : Icon(Icons.live_tv, color: Colors.white),
  ),
),

   ],
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: non_constant_identifier_names
TextButtonapp({text, required Icon icon, bool isActive = false}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      icon,
      const SizedBox(width: 8), // Adjust the spacing between icon and label as needed
      Text(
        text.toString(),
        style: isActive
            ? CustomStyles.textExternel.copyWith(color: Colors.blue) // Adjust the active style
            : CustomStyles.textExternel,
      ),
    ],
  );
}