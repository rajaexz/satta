import 'package:winner11/DataGet/liveData.dart';
import 'package:winner11/screen/component/darkmode.dart';
import 'package:winner11/screen/component/imageComponet.dart';
import 'package:winner11/screen/header/appbar.dart';
import 'package:flutter/material.dart';

import 'package:winner11/service/authapi.dart';
import 'package:winner11/utilis/AllColor.dart';
import 'package:winner11/utilis/borderbox.dart';
import 'package:winner11/utilis/boxSpace.dart';
import 'package:winner11/utilis/fontstyle.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../utilis/globlemargin.dart';
class LiveScore extends StatelessWidget {
   LiveScore({super.key});
   final RealTimeDataController realTimeDataController =
        Get.put(RealTimeDataController());

    final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return     Obx(() {
            
                if (realTimeDataController.liveMatches.isEmpty) {
                  return  Lottie.asset('assets/empty.json');
                } else {
                  return Column(
               
                     
                    children:realTimeDataController.liveMatches.map((match) {
                      return InkWell(
                        onTap: () {},
                        child: Container(
                        
                          height: 220,
                          margin: EdgeInsets.only(bottom: 30),
                          decoration:  BoxDecoration(
                                  color: themeController.isLightMode.value
                                      ? myColorWhite
                                      : myColor,
                                  boxShadow: [
                                    themeController.isLightMode.value
                                        ? boxshadow2
                                        : boxdark
                                  ],
                                  border: border,
                                  borderRadius: boRadiusAll),
                          child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, top: 5),
                                child: Row(
                                  children: [
                                    Text(
                                      '•${match.matchStatus}',
                                      style: CustomStyles.smallTextStyle,
                                    ),
                                    size20w,
                                    Expanded(
                                        flex: 1,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: 150,
                                              child: Text(
                                                match.series,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(fontSize: 13),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: Text(
                                                  "${match.matchTime} : ${match.matchDate}"),
                                            )
                                          ],
                                        ))
                                  ],
                                ),
                              ),
                              Divider(
                                color: myColorRed,
                                thickness: 1,
                              ),
                              // Row of team 1
                              Row(
                                children: [
                                  size20w,
                                  Expanded(
                                    flex: 3,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        teamheadingscore2(
                                          teamAOver: match.teamAOver,
                                          teamBOver: match.teamBOver,
                                          teamBScore: match.teamBScore,
                                          teamAScore: match.teamAScore,
                                            teamAImg: match.teamAImg,
                                            teamBImg: match.teamBImg,
                                            teamName: match.teamAShort,
                                            teamName2: match.teamBShort,
                                            teamScore: match.teamAScore,
                                            teamScore2: match.teamBScore,
                                            teamOver: match.teamAOver,
                                            teamOver2: match.teamBOver,
                                            
                                            matchType:match.matchType),
                                      ],
                                    ),
                                  ),
                                  size20w,
                                ],
                              ),
                              Divider(
                                color: myColorRed,
                                thickness: 1,
                              ),

                 
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, top: 10),
                                    child: Text(
                                      truncateText(match.venue, 60),
                                      style: CustomStyles.smallTextStyle,
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Text(match.matchType,
                                          style: CustomStyles.textExternel),
                                    
                                    ],
                                  )
                                ],
                              ),
                          
                                       Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Row(
                                    
                                    children: [
                                  
                                      //Aw -
                                      Text(match.favTeam.toString()),
                                     size20w,
                                      Container(
                                        height: 35,
                                        width: 60,
                                        decoration: BoxDecoration(
                                          color: Colors.black54,
                                        borderRadius: BorderRadius.only(
      topLeft: Radius.circular(5), // Adjust the radius as needed

    ),
                                          border: border,
                                        ),
                                        child: Center(
                                          child: Text(
                                            match.min.toString(),
                                            style:
                                              TextStyle(color: Colors.white,  fontSize: 12,
    fontWeight: FontWeight.w700, ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                 
                                  Container(
                                    height: 35,
                                    width: 60,
                                    decoration: BoxDecoration(
                                    color: Colors.grey,
                                      border: border,
                                                    borderRadius: BorderRadius.only(
      bottomRight: Radius.circular(5), // Adjust the radius as needed

    ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        match.max.toString(),
                                        style: CustomStyles.smallTextStyle,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }
              });
        
  }
}
class LiveScores extends StatefulWidget {
  const LiveScores({super.key});

  @override
  State<LiveScores> createState() => _LiveScoresState();
}

class _LiveScoresState extends State<LiveScores> {
  @override
  Widget build(BuildContext context) {

    final RealTimeDataController realTimeDataController =
        Get.put(RealTimeDataController());

    final ThemeController themeController = Get.put(ThemeController());

    return Scaffold(
      appBar: CustomAppBar(title: "ALL Live"),
      body: Container(
        margin: GlobleglobleMargin.globleMargin,
        child: SingleChildScrollView(
          child:     Obx(() {
            
                if (realTimeDataController.liveMatches.isEmpty) {
                  return  Lottie.asset('assets/empty.json');
                } else {
                  return Column(
               
                     
                    children:realTimeDataController.liveMatches.map((match) {
                      return InkWell(
                        onTap: () {},
                        child: Container(
                        
                          height: 220,
                          margin: EdgeInsets.only(bottom: 30),
                          decoration:  BoxDecoration(
                                  color: themeController.isLightMode.value
                                      ? myColorWhite
                                      : myColor,
                                  boxShadow: [
                                    themeController.isLightMode.value
                                        ? boxshadow2
                                        : boxdark
                                  ],
                                  border: border,
                                  borderRadius: boRadiusAll),
                          child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, top: 5),
                                child: Row(
                                  children: [
                                    Text(
                                      '•${match.matchStatus}',
                                      style: CustomStyles.smallTextStyle,
                                    ),
                                    size20w,
                                    Expanded(
                                        flex: 1,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: 150,
                                              child: Text(
                                                match.series,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(fontSize: 13),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: Text(
                                                  "${match.matchTime} : ${match.matchDate}"),
                                            )
                                          ],
                                        ))
                                  ],
                                ),
                              ),
                              Divider(
                                color: myColorRed,
                                thickness: 1,
                              ),
                              // Row of team 1
                              Row(
                                children: [
                                  size20w,
                                  Expanded(
                                    flex: 3,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        teamheadingscore2(
                                          teamAOver: match.teamAOver,
                                          teamBOver: match.teamBOver,
                                          teamBScore: match.teamBScore,
                                          teamAScore: match.teamAScore,
                                            teamAImg: match.teamAImg,
                                            teamBImg: match.teamBImg,
                                            teamName: match.teamAShort,
                                            teamName2: match.teamBShort,
                                            teamScore: match.teamAScore,
                                            teamScore2: match.teamBScore,
                                            teamOver: match.teamAOver,
                                            teamOver2: match.teamBOver,
                                            
                                            matchType:match.matchType),
                                      ],
                                    ),
                                  ),
                                  size20w,
                                ],
                              ),
                              Divider(
                                color: myColorRed,
                                thickness: 1,
                              ),

                 
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, top: 10),
                                    child: Text(
                                      truncateText(match.venue, 60),
                                      style: CustomStyles.smallTextStyle,
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Text(match.matchType,
                                          style: CustomStyles.textExternel),
                                    
                                    ],
                                  )
                                ],
                              ),
                          
                                       Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Row(
                                    
                                    children: [
                                  
                                      //Aw -
                                      Text(match.favTeam.toString()),
                                     size20w,
                                      Container(
                                        height: 35,
                                        width: 60,
                                        decoration: BoxDecoration(
                                          color: Colors.black54,
                                        borderRadius: BorderRadius.only(
      topLeft: Radius.circular(5), // Adjust the radius as needed

    ),
                                          border: border,
                                        ),
                                        child: Center(
                                          child: Text(
                                            match.min.toString(),
                                            style:
                                              TextStyle(color: Colors.white,  fontSize: 12,
    fontWeight: FontWeight.w700, ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                 
                                  Container(
                                    height: 35,
                                    width: 60,
                                    decoration: BoxDecoration(
                                    color: Colors.grey,
                                      border: border,
                                                    borderRadius: BorderRadius.only(
      bottomRight: Radius.circular(5), // Adjust the radius as needed

    ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        match.max.toString(),
                                        style: CustomStyles.smallTextStyle,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }
              })
             ),
      ),
    );
  }
}

teamheadingscore2({
  teamAOver,
  teamBOver,
  teamBScore,
  teamAScore,
  teamAImg,
  teamBImg,
  teamName,
  teamName2,
  teamScore,
  teamScore2,
  teamOver,
  teamOver2,
  teamType,
  matchTime,
  matchType
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ImageComponentNet(
                  myWidth: 40.0, myheight: 40.0, myImage: teamAImg.toString()),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                 Text(teamName.toString(), style: CustomStyles.smallTextStyle)  ,
                 matchType == "Test" ?   Column(
                   children: [
                     Text("${ teamAScore}", style: CustomStyles.smallTextStyle,),
                      Text("${ teamAOver}  (Over)",style: CustomStyles.smallTextStyle,),
                 
                   ],
                 ) : Text("${teamScore}-${teamOver.toString()}" ,
                      style: CustomStyles.smallTextStyle),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
        ],
      ),

      
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ImageComponentNet(
                  myWidth: 40.0, myheight: 40.0, myImage: teamBImg.toString()),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(teamName2.toString(),
                      style: CustomStyles.smallTextStyle),
                         matchType == "Test" ?   Column(
                           children: [
                             Text("${ teamBScore}", style: CustomStyles.smallTextStyle,),
                               Text("${ teamBOver} (Over)" ,style: CustomStyles.smallTextStyle,),
                           ],
                         ) : 

                  Text("${teamScore2}/${teamOver2.toString()}",
                      style: CustomStyles.smallTextStyle),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

String truncateText(String text, int maxLength) {
  if (text.length <= maxLength) {
    return text;
  } else {
    return text.substring(0, maxLength) + "...";
  }
}


// //live scroller 

// class LiveCo extends StatefulWidget {
//   const LiveCo({super.key});

//   @override
//   State<LiveCo> createState() => _LiveCoState();
// }

// class _LiveCoState extends State<LiveCo> {
//   @override
//   Widget build(BuildContext context) {
//     return  CarouselSlider(
//                     carouselController: _carouselController,
//                     options: CarouselOptions(
//                       height: screenWidth * 0.6,
//                       initialPage: 1,
//                       autoPlay: true,
//                       pageSnapping: true,
//                       aspectRatio: 8 / 9,
//                       pauseAutoPlayInFiniteScroll: true,
//                       autoPlayCurve: Curves.easeInExpo,
//                       enableInfiniteScroll: true,
//                       autoPlayAnimationDuration:
//                           const Duration(milliseconds: 800),
//                       viewportFraction: 1.0,
//                       disableCenter: false,
//                       onPageChanged: (index, reason) {
//                         setState(() {
//                           _currentSlide = index;
//                         });
//                       },
//                       enlargeStrategy: CenterPageEnlargeStrategy.scale,
//                     ),
//                    );
// }