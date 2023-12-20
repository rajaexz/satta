import 'package:winner11/banner/banner_Model.dart';
import 'package:winner11/screen/component/darkmode.dart';
import 'package:winner11/screen/tap1/upComing_MatchsModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winner11/screen/component/custom_toaster.dart';
import 'package:winner11/screen/component/imageComponet.dart';
import 'package:winner11/screen/component/shimmer.dart';
import 'package:winner11/screen/header/headerTop.dart';
import 'package:winner11/screen/tap2/mycontest.dart';
import 'package:winner11/service/authapi.dart';
import 'package:winner11/utilis/AllColor.dart';
import 'package:winner11/utilis/borderbox.dart';
import 'package:winner11/utilis/boxSpace.dart';
import 'package:winner11/utilis/fontstyle.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../banner/banner.dart';
import '../component/coundown.dart';

class UpComming extends StatefulWidget {
  const UpComming({super.key});

  @override
  State<UpComming> createState() => _UpCommingState();
}

class _UpCommingState extends State<UpComming> {
  late SharedPreferences _prefs;
  late String _lastPopupDate;
  @override
  void initState() {
    super.initState();
   _initPreferences();
  }


  Future<void> _initPreferences() async {
   _prefs  = await SharedPreferences.getInstance();
    _lastPopupDate = _prefs.getString('lastPopupDate') ?? '';

    if (_lastPopupDate != getCurrentDate()) {
      showPopup(context);
    }
  }

  final ThemeController themeController = Get.put(ThemeController());
  final ApiService apiService = ApiService();
  final String? id = Get.arguments as String?;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

// Mycontest ----------------------------------------------------------
FutureBuilder(
  future: apiService.userAllDoc(uri: "/user_upcoming_matches"),
  builder: (context, snapshot) {
    try {
      if (snapshot.connectionState == ConnectionState.waiting) {
        // While the future is still running, display a loading indicator
        return imageShimmer;
      } else if (snapshot.hasError) {
        // If an error occurred, display an error message
        return Text('Error: ${snapshot.error}');
      } else {
      
        // Data has been successfully fetched
        final data = (snapshot.data as Map<String, dynamic>)["data"]["result"];

        if (data == null || data.isEmpty) {
          return Text("");
        }

        return Column(
          children: [
            titlebtn(
              HeadName: "MY Contest match",
              context1: context,
              Headno: "See All",
              routes: "/AllShowContest",
            ),
            size20h,
            Mycontest(
              data: data,
              type: "upcoming_page",
            ),
            size10h,
          ],
        );
      }
    } catch (e) {
      return imageShimmer;
      // Handle network-related errors here, show a message to the user, etc.
    }
  },
),

       
        size10h,
        Simpletitlebtn(HeadName: "Upcomming Matches"),
//Upcoming Match List 

    FutureBuilder(
  future: apiService.userMatchList(data: {"id": id}, uri: '/show_matches'),
  builder: (context, snapshot) {
    try {
      if (snapshot.connectionState == ConnectionState.done) {
        if (snapshot.hasError) {
          throw Exception('Error: ${snapshot.error}');
        }
        final data = (snapshot.data as Map<String, dynamic>);
        final matchData = MatchData.fromJson(data['data']);
        final reversedData = List.from(matchData.result.reversed);
        final itemCount = reversedData.length;

        return Column(
          children: List.generate(itemCount, (index) {
            var match = reversedData[index];

            if (getMatchStatus(1, match.matchDate.toString(), match.matchTime.toString()) != "Match Over") {
              return GestureDetector(
                onTap: () {
                  CustomToaster.showWarning(context, "The Match Is Over");
                },
                child: Obx(() => Container(
                  height: 190,
                  margin: const EdgeInsets.only(top: 20),
                  padding: const EdgeInsets.only(top: 10, bottom: 5, right: 10, left: 10),
                  decoration: BoxDecoration(
                    border: border,
                    color: themeController.isLightMode.value ? myColorWhite : myColor,
                    boxShadow: [
                      themeController.isLightMode.value ? boxdark : boxshadow2
                    ],
                    borderRadius: boRadiusAll,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 30,
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  themeController.isLightMode.value
                                    ? "assets/banner.png"
                                    : "assets/banner-dark.png"),
                                fit: BoxFit.fill,
                                alignment: Alignment.centerRight),
                            ),
                            child: Container(
                              width: 260,
                              child: Text(
                                "${match.series}",
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          const Column(
                            children: [
                           Icon(Icons.tv)
                            ],
                          ),
                          const Column(
                            children: [
                              Icon(Icons.access_alarm),
                            ],
                          )
                        ],
                      ),
                      size10h,
                      ImageColoum(
                        Image1: match.matchFlagA,
                        Image2: match.matchFlagB,
                        short_nameA: match.sortNameA,
                        short_nameB: match.sortNameB,
                        long_nameA: match.teamA,
                        long_nameB: match.teamB,
                        matchData: match.matchDate,
                        matchtime: match.matchTime,
                      ),
                      Divider(),
                      Row(
                        children: [
                          Container(
                            width: 250,
                            height: 40,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/banner1.png"),
                                fit: BoxFit.contain,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(top: 10.0, left: 15.0),
                              child: Text(
                                "MEGA ₹1 Core",
                                style: CustomStyles.textExternel,
                              ),
                            ),
                          )
                        ],
                      )
                      // ... Add more UI elements for Match Over scenario
                    ],
                  ),
                )),
              );
            } else {
              return InkWell(
                onTap: () {
                  Get.toNamed('/contList', arguments: {"poolId": match.matchId, "id": id});
                },
                child: Obx(() => Container(
                  height: 190,
                  margin: EdgeInsets.only(top: 20),
                  padding: const EdgeInsets.only(top: 10, bottom: 5, right: 10, left: 10),
                  decoration: BoxDecoration(
                    border: border,
                    color: themeController.isLightMode.value ? myColorWhite : myColor,
                    boxShadow: [
                      themeController.isLightMode.value ? boxdark : boxshadow2
                    ],
                    borderRadius: boRadiusAll,
                  ),
                  child: Container(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 30,
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    themeController.isLightMode.value
                                      ? "assets/banner.png"
                                      : "assets/banner-dark.png"),
                                  fit: BoxFit.fill,
                                  alignment: Alignment.centerRight),
                              ),
                              child: Container(
                                width: 260,
                                child: Text(
                                  "${match.series}",
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            const Column(
                              children: [
                                Icon(Icons.tv),
                              ],
                            ),
                            const Column(
                              children: [
                                Icon(Icons.access_alarm),
                              ],
                            )
                          ],
                        ),
                        size10h,
                        ImageColoum(
                          Image1: match.matchFlagA,
                          Image2: match.matchFlagB,
                          short_nameA: match.sortNameA,
                          short_nameB: match.sortNameB,
                          long_nameA: match.teamA,
                          long_nameB: match.teamB,
                          matchData: match.matchDate,
                          matchtime: match.matchTime,
                        ),
                        Divider(),
                        Row(
                          children: [
                            Container(
                              width: 250,
                              height: 40,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/banner1.png"),
                                  fit: BoxFit.contain,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(top: 10.0, left: 15.0),
                                child: Text(
                                  "MEGA ₹1 Core",
                                  style: CustomStyles.textExternel,
                                ),
                              ),
                            )
                          ],
                        )
                        // ... Add more UI elements for Match Over scenario
                      ],
                    ),
                  ),
                )),
              );
            }
          }),
        );
      } else if (snapshot.connectionState == ConnectionState.waiting) {
        return imageShimmer;
      } else {
        return Text('Data retrieval is not in progress');
      }
    } catch (e) {
      print('Error in FutureBuilder: $e');
      // Handle the error gracefully, e.g., display an error message to the user
      return          imageShimmer;
;
    }
  },
)
  ],
    );
  }
}

ImageColoum(
    {Image1,
    Image2,
    short_nameA,
    short_nameB,
    long_nameA,
    long_nameB,
    matchData,
    matchtime}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ImageComponentNet(
                myWidth: 40.0,
                myheight: 40.0,
                myImage: Image1 ?? "",
              ),
              size10w,
              Text(
                short_nameA ?? "",
                style: CustomStyles.smallTextStyle,
              )
            ],
          ),
          size10h,
          Text(
            long_nameA ?? "",
            style: CustomStyles.header3TextStyle,
          )
        ],
      ),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            // Text(

            //   getMatchStatus(
            //     1, // Total seconds until the match starts
            //     matchData, // Match date (customize it according to your data)
            //     matchtime,
            //   ),
            //   style: TextStyle(
            //     color: myColorRed,
            //     fontSize: 16,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            SimpleCounter(
                matchDate: matchData, matchTime: matchtime, totalSeconds: 1)
          ],
        ),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              Text(
                short_nameB ?? "",
                style: CustomStyles.smallTextStyle,
              ),
              size10w,
              ImageComponentNet(
                myWidth: 40.0,
                myheight: 40.0,
                myImage: Image2 ?? "",
              ),
            ],
          ),
          size10h,
          Container(
            alignment: Alignment.bottomRight,
            width: 100,
            child: Text(long_nameB ?? "",
                style: CustomStyles.header3TextStyle,
                overflow: TextOverflow.ellipsis),
          )
        ],
      ),
    ],
  );
}
