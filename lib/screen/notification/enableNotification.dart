import 'package:flutter/material.dart';
import 'package:Billa/utilis/AllColor.dart';
import 'package:Billa/utilis/fontstyle.dart';

class MyNotificationEnable extends StatefulWidget {
  const MyNotificationEnable({Key? key}) : super(key: key);

  @override
  State<MyNotificationEnable> createState() => _MyNotificationEnableState();
}

class _MyNotificationEnableState extends State<MyNotificationEnable> {
  bool forAndroid = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: ListTile(
          trailing: Switch(
            activeColor: myColorRed,
            activeTrackColor: Colors.cyan,
            inactiveThumbColor: Colors.blueGrey.shade600,
            inactiveTrackColor: Colors.grey.shade400,
            splashRadius: 50.0,
            value: forAndroid,
            onChanged: (value) {
              setState(() {
                forAndroid = value;
              });
            },
          ),
          leading: Icon(Icons.info),
          title: Row(
            children: [
              Text(
                'Notifications On / Off   ',
                style: CustomStyles.header2TextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
