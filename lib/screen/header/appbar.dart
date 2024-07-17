import 'package:Billa/screen/wallet/wallet_controller.dart/all_hestory_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:Billa/screen/component/darkmode.dart';
import 'package:Billa/screen/component/imageComponet.dart';
import 'package:Billa/service/authapi.dart';
import 'package:Billa/utilis/borderbox.dart';
import 'package:Billa/utilis/boxSpace.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utilis/AllColor.dart';
import '../../utilis/fontstyle.dart';
import '../wallet/walletHestory.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget> actions;

  final ThemeController themeController;

  CustomAppBar({
    required this.title,
    this.actions = const [],
  }) : themeController = Get.put(ThemeController());
  var currentNotiNumber;

  @override
  Size get preferredSize => Size.fromHeight(56.0);

  @override
  Widget build(BuildContext context) {
    AllHestoryController controller = Get.put(AllHestoryController());
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/top-banner.png"),
          fit: BoxFit.cover,
        )),
      ),
      title: Row(
        children: [
          size10w,
          InkWell(
            onTap: () async {
              final store = await SharedPreferences.getInstance();
              var id = store.getString('userId');
              Get.toNamed("/home", arguments: id);
            },
            child: DefaultTextStyle(
              style: TextStyle(
                color: myColorWhite,
                fontSize: 20,
                fontWeight: FontWeight.w800,
                fontFamily: 'Roboto1',
              ),
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                maxLines: 2,
              ),
            ),
          ),
        ],
      ),
      foregroundColor: myColorWhite,
      actions: [
        GestureDetector(
            onTap: () {
              showModalBottomSheet<void>(
                showDragHandle: true,
                useSafeArea: true,
                isScrollControlled: true,
                elevation: 8,
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  ),
                ),
                builder: (BuildContext context) {
                  return const FractionallySizedBox(
                    heightFactor:
                        0.5, // Adjust this value to control the height (0.0 to 1.0).
                    child: Myhestory(),
                  );
                },
              );
            },
            child: Row(
              children: [
                ImageComponent(
                  myWidth: 50.0,
                  myheight: 50.0,
                  myImage: "assets/icon/wallet2.png",
                ),
                Obx(
                      () {
                    final withdrawData = controller.withdrawData.value;
                    return withdrawData != null
                        ? Text(
                      "₹${withdrawData.availablePoints}",
                      style: CustomStyles.headerTextStyle,
                    )
                        : Text(
                      "Loading...", // Or any other placeholder text
                      style: CustomStyles.headerTextStyle,
                    );
                  },
                ),
              ],
            )
        ),
        // IconButton(
        //   icon: Icon(
        //     Icons.sunny_snowing,
        //     color: myColorWhite,
        //   ), // Icon to display
        //   onPressed: () {
        //     themeController.toggleTheme();
        //   },
        // ),
        Stack(
          children: [
            IconButton(
              icon: Icon(
                Icons.notifications_none,
                color: myColorWhite,
              ), // Icon to display
              onPressed: () {
                Get.toNamed('/myNoti');
              },
            ),
          ],
        ),
      ],
    );
  }
}
