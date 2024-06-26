
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winner11/screen/component/darkmode.dart';
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


  @override
  void initState() {
    super.initState();
    fetchAndUpdateNotificationCount();
  }

  Future<void> fetchAndUpdateNotificationCount() async {
   
  }

  final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Notifications"),
      body: Container(
        margin: GlobleglobleMargin.globleMargin,
        child:     ListView.builder(
          shrinkWrap: false,
                 
                    
                    itemCount: 1,
                    itemBuilder: (context, index) {
                     return             Container(
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
                                      "BILLA",
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
                                        "tittle",
                                        style: CustomStyles.header3TextStyle,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: true,
                                        maxLines: 3,
                                      ),
                                      Text(
                                        "Description",
                                        style: CustomStyles.smallTextStyle,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: true,
                                        maxLines: 3,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            DateTime.now().toString(),
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
                          );
             
                    },
                  )
    
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
