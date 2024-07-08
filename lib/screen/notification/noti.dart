import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winner11/main.dart';
import 'package:winner11/screen/component/darkmode.dart';
import 'package:winner11/screen/notification/controller/noti_controller.dart';
import 'package:winner11/utilis/AllColor.dart';
import 'package:winner11/utilis/borderbox.dart';
import 'package:winner11/utilis/boxSpace.dart';
import 'package:winner11/utilis/fontstyle.dart';
import 'package:winner11/utilis/globlemargin.dart';

import '../header/appbar.dart';

class MyNoti extends StatefulWidget {
  const MyNoti({super.key});

  @override
  State<MyNoti> createState() => _MyNotiState();
}

class _MyNotiState extends State<MyNoti> {
  final NotificationController notificationController =
      Get.put(NotificationController());

  @override
  void initState() {
    super.initState();
    notificationController.readNotification();
    notificationController.fetchData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Notifications',
      ),
      body: SafeArea(
        child: Container(
          margin: GlobleglobleMargin.globleMargin,
          child: RefreshIndicator(
            onRefresh: () async {
              await notificationController.readNotification();
            },
            child: Column(
              children: [
                size20h,
                Obx(() {
                  if (notificationController.dataModel.value != null) {
                    final dataModel = notificationController.dataModel.value!;
                    return Expanded(
                      child: Column(
                        children: [
                          _buildNotificationItem(
                            title: "BILLA",
                            notice: dataModel.addFundNotice,
                          ),
                          _buildNotificationItem(
                            title: "BILLA",
                            notice: dataModel.appNotice,
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Expanded(child: Center(child: Text("No Data")));
                  }
                }),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          notificationController.readNotification();
        },
        child: Icon(Icons.refresh),
      ),
    );
  }

  Widget _buildNotificationItem(
      {required String title, required String notice}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        border: border,
        color: myColorWhite,
        borderRadius: boRadius5,
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                title,
                style: TextStyle(
                  color: myColorRed,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Roboto1',
                ),
              ),
              const Icon(Icons.notification_important),
            ],
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notice.isNotEmpty ? notice : " ",
                  style: CustomStyles.header3TextStyle,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  maxLines: 3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      DateTime.now().toString(),
                      style: CustomStyles.verysmallTextStyle,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      maxLines: 3,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
