import 'package:winner11/screen/header/Userdata_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winner11/screen/component/pop.dart';
import 'package:winner11/screen/component/shimmer.dart';
import 'package:winner11/utilis/AllColor.dart';

import 'package:winner11/utilis/fontstyle.dart';


import '../../service/authapi.dart';

Drawer myDrawer(context, id) {
  final ApiService apiService = ApiService();
  return Drawer(
    child: Column(
      children: [
    FutureBuilder(
  future: apiService.userMatchList(data: {"id": id}, uri: '/get_all_data_user'),
  builder: (context, snapshot) {
    try {
      if (snapshot.connectionState == ConnectionState.done) {
        if (snapshot.hasError) {
          return showShummer2;
        }

        final data = (snapshot.data as Map<String, dynamic>)['data'];
        if (data != null) {
          final result = data["result"][0];


          if (result != null) {
            UserProfile userProfile = UserProfile.fromJson(result);

            return Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 90),
                  color: myColorRed,
                  child: Row(
                    children: <Widget>[
                      Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(20.0),
                            child: CircleAvatar(
                              radius: 30.0,
                              backgroundImage: NetworkImage("https://winners11.in/images/${userProfile.image}")
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(userProfile.name ?? "",
                              style: CustomStyleswhite.headerTextStyle),
                          Text(userProfile.phone?.toString() ?? "",
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              style: CustomStyleswhite.header2TextStyle),
                        ],
                      )
                    ],
                  ),
                ),
                
                ListTile(
                  leading: Icon(Icons.policy),
                  title: Text('Profile', style: CustomStyles.header2TextStyle),
                  onTap: () {
                    Get.toNamed("/showProfile", arguments: result);
                  },
                ),
              ],
            );
          } else {
            return showShummer2;
          }
        } else {
          return const Text('No data available');
        }
      } else if (snapshot.connectionState == ConnectionState.waiting) {
        return showShummer2; // Display a loading indicator
      } else {
        return showShummer2;
      }
    } catch (e) {
      print('Error: $e');
      // Handle other errors, show an error message, or return an error widget
      return showShummer2;
    }
  },
),

        ListTile(
          leading: Icon(Icons.settings), // Change the icon to "settings"
          title: Text('Settings', style: CustomStyles.header2TextStyle),
          onTap: () async {
            Get.toNamed('/setting');
          },
        ),
        ListTile(
          leading: Icon(Icons.logout), // Change the icon to "control_point"
          title: Text('Logout', style: CustomStyles.header2TextStyle),
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return CustomPopupDialog2(); // Custom pop-up widget
              },
            );
          },
        ),
        ListTile(
          leading:
              Icon(Icons.policy), // Change the icon to a different policy icon
          title: Text('More', style: CustomStyles.header2TextStyle),
          onTap: () {
            Get.toNamed('/mySeeMore');
          },
        ),
      ],
    ),
  );
}
