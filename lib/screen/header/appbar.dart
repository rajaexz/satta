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
  final ThemeController themeController = Get.put(ThemeController());
  final String title;
  final List<Widget> actions;
     final NotiController notiController = Get.put(NotiController());
  CustomAppBar({
    required this.title,
    this.actions = const [],
  });
   fatchData() async {
        final ApiService apiService = ApiService();
          final data = await apiService.userallGet(uri: "/notification_get_user");

 
   
        var result = data["data"]["result"];
        notiController.updateNotificationCount(result);
          final store = await SharedPreferences.getInstance();
     var currentNotiNumber = store.getInt('noti_number');
  

   }

  @override
  Size get preferredSize => Size.fromHeight(56.0);

  @override
  Widget build(BuildContext context) {

    print("hello ");
    return Container(
      
      child: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
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
          Row(
            children: [
              notiController.hasNewNotification.value  ? Container(height: 5, width:  5, decoration: BoxDecoration(borderRadius: boRadiusAll, color: myColor),) : const Text(""),
              IconButton(
                icon: Icon(
                  Icons.notifications_none,
                  color: myColorWhite,
                ), // Icon to display
                onPressed: () {
                  print(notiController.hasNewNotification.value );
                  Get.toNamed('/myNoti');
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
