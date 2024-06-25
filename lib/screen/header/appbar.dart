import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winner11/DataGet/notiLocal.dart';
import 'package:winner11/screen/component/darkmode.dart';
import 'package:winner11/screen/component/imageComponet.dart';
import 'package:winner11/screen/wallet/wallet.dart';
import 'package:winner11/service/authapi.dart';
import 'package:winner11/utilis/borderbox.dart';
import 'package:winner11/utilis/boxSpace.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utilis/AllColor.dart';
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget> actions;

  final ThemeController themeController;
  final NotiController notiController;

  CustomAppBar({
    required this.title,
    this.actions = const [],
  })   : themeController = Get.put(ThemeController()),
        notiController = Get.put(NotiController());
  var currentNotiNumber ;


  Future<void> fetchData() async {
    try {
      final ApiService apiService = ApiService();
      final data = await apiService.userallGet(uri: "/notification_get_user");

      var result = data["data"]["result"];
      notiController.updateNotificationCount(result);

      final store = await SharedPreferences.getInstance();
       currentNotiNumber = store.getInt('noti_number');
          
       print(currentNotiNumber);
        print(notiController.noti_number.value);
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Size get preferredSize => Size.fromHeight(56.0);

  @override
  Widget build(BuildContext context) {
    fetchData(); // Consider moving this to an init method

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
                return  const FractionallySizedBox(
                  heightFactor:
                      0.5, // Adjust this value to control the height (0.0 to 1.0).
                  child: MyWallet(),
                );
              },
            );
          },
          child: ImageComponent(
            myWidth: 50.0,
            myheight: 50.0,
            myImage: "assets/icon/wallet2.png",
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.sunny_snowing,
            color: myColorWhite,
          ), // Icon to display
          onPressed: () {
            themeController.toggleTheme();
          },
        ),
        Obx(
           ()=>Stack(
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
               Positioned(
                top: 10,
                left: 10,
                child:   currentNotiNumber != notiController.noti_number.value ? Container(height: 5, width:  5, decoration: BoxDecoration(borderRadius: boRadiusAll, color: myColor),) : const Text(""),)
         
            ],
          ),
        )
      ],
    );
  }
}
