import 'package:winner11/DataGet/notiLocal.dart';
import 'package:winner11/screen/component/shimmer.dart';
import 'package:winner11/service/authapi.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winner11/screen/component/darkmode.dart';
import 'package:winner11/utilis/AllColor.dart';
import 'package:winner11/utilis/borderbox.dart';
import 'package:winner11/utilis/boxSpace.dart';
import 'package:winner11/utilis/fontstyle.dart';
import 'package:winner11/utilis/globlemargin.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../header/appbar.dart';

class MyNoti extends StatefulWidget {
  const MyNoti({super.key});

  @override
  State<MyNoti> createState() => _MyNotiState();
}

class _MyNotiState extends State<MyNoti> {
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
    return Scaffold(
        appBar: CustomAppBar(
          title: 'Notifications',
        ),
        body: SafeArea(
          child: Container(
            margin: GlobleglobleMargin.globleMargin,
            child: Column(
              children: [
                RefreshIndicator(
                  onRefresh: () async {
                    // here we are refresh indigetor
                  },
                  child: Column(children: [
                    size20h,
                    Container(
                      child: NotificationItem(),
                    )
                  ]),
                ),
              ],
            ),
          ),
        ));
  }
}

class NotificationItem extends StatefulWidget {
  NotificationItem();

  @override
  State<NotificationItem> createState() => _NotificationItemState();
}

class _NotificationItemState extends State<NotificationItem> {
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    fetchAndUpdateNotificationCount();
  }

  Future<void> fetchAndUpdateNotificationCount() async {
    try {
      final ApiService apiService = ApiService();
      final store = await SharedPreferences.getInstance();

      // Fetch data
      final data = await apiService.userallGet(uri: "/notification_get_user");

      if (data != null) {
        final NotiController notiController = Get.put(NotiController());
        var result = data["data"]["result"];
        notiController.updateNotificationCount(result);

        // Store updated notification count in SharedPreferences
        store.setInt('noti_number', notiController.noti_number.value);
      }
    } catch (e) {
      // Handle errors appropriately (e.g., log or show an error message)
      print("Error fetching and updating notification count: $e");
    }
  }

  final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Notifications"),
      body: Container(
        margin: GlobleglobleMargin.globleMargin,
        child: FutureBuilder(
          future: apiService.userallGet(
            uri: "/notification_get_user",
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              final data = (snapshot.data as Map<String, dynamic>)['data'];

              if (data != null) {
                var result = data["result"];

                if (result != '[]') {
                  return ListView.builder(
                    shrinkWrap: true,
                    reverse: true,
                    itemCount: result.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> item = result[index];
                      return Obx(
                        () => Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(top: 20),
                          decoration: BoxDecoration(
                            border: border,
                            color: themeController.isLightMode.value
                                ? myColorWhite
                                : myColor,
                            boxShadow: [
                              themeController.isLightMode.value
                                  ? boxshadow2
                                  : boxdark
                            ],
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
                                    "WINNER11",
                                    style: TextStyle(
                                      color: myColorRed,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w800,
                                      fontFamily: 'Roboto1',
                                    ),
                                  ),
                                  const Icon(Icons.notification_important)
                                ],
                              ),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.only(left: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      item["tittle"],
                                      style: CustomStyles.header3TextStyle,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                      maxLines: 3,
                                    ),
                                    Text(
                                      "${item["description"]}",
                                      style: CustomStyles.smallTextStyle,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                      maxLines: 3,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          "${item["timestamp"].toString().split('T')[0].toString()} \n ${item["timestamp"].toString().split('T')[1].toString()} ",
                                          style:
                                              CustomStyles.verysmallTextStyle,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.center,
                                          softWrap: true,
                                          maxLines: 3,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Text('No match data available');
                }
              } else {
                return Text('No data available');
              }
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Scaffold(
                  body: Center(
                      child: summer2)); // Replace with your shimmer widget
            } else {
              return Text('Data retrieval is not in progress');
            }
          },
        ),
      ),
    );
  }
}

class ExpandableText extends StatefulWidget {
  final String text;

  ExpandableText(this.text);

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          isExpanded ? widget.text : widget.text.substring(0, 50) + '...',
          style: CustomStyles.textExternelgray,
          overflow: TextOverflow.ellipsis,
          softWrap: true,
          maxLines: 3,
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: isExpanded
              ? Icon(Icons.arrow_drop_down)
              : Icon(Icons.arrow_drop_up),
        ),
      ],
    );
  }
}
