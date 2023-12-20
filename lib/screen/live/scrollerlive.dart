import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:winner11/service/authapi.dart';
import 'package:winner11/utilis/AllColor.dart';
import 'package:winner11/utilis/fontstyle.dart';

import '../../banner/banner.dart';
import '../../utilis/borderbox.dart';
import '../../utilis/boxSpace.dart';
import '../header/headerTop.dart';
import 'live.dart';

class CaroselLive extends StatefulWidget {
  const CaroselLive({super.key});

  @override
  State<CaroselLive> createState() => _CaroselLiveState();
}

class _CaroselLiveState extends State<CaroselLive> {
  final CarouselController _carouselController = CarouselController();
  int _currentSlide = 0;

  @override
  Widget build(BuildContext context) {
    final ApiService apiService = ApiService();
    final matches = apiService.liveMatches;
    return Column(
      children: [
        Simpletitlebtn(HeadName: "Live Matches"),
        FutureBuilder<void>(
          future: apiService.userAllLive(
              uri:
                  "http://apicricketchampion.in/webservices/liveMatchList/20122cd5366e30f0847774c9d7698d30"),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Handle loading state
              return Container(
                  height: 160,
                  width: 330,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    border: border,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const CircularProgressIndicator());
            } else if (snapshot.hasError) {
              // Handle error state
              print(snapshot.error);
              return Text('Error: ${snapshot.error}');
            } else {
              // Continue with your code for handling the data
              final matches = apiService.liveMatches;
              return CarouselSlider(
                carouselController: _carouselController,
                options: CarouselOptions(
                  height: 180,
                  initialPage: _currentSlide,
                  autoPlay: false,
                  pageSnapping: false,
                  aspectRatio: 8 / 9,
                  pauseAutoPlayInFiniteScroll: true,
                  autoPlayCurve: Curves.easeInExpo,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  viewportFraction: 1.0,
                  disableCenter: false,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentSlide = index;
                    });
                  },
                  enlargeStrategy: CenterPageEnlargeStrategy.scale,
                ),
                items: matches.map((match) {
                  return Container(
                    width: 330,
                    height: 180,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      border: border,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 5),
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
                                      width: 130,
                                      child: Text(
                                        match.series,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 9),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                teamheadingscore2(
                                    teamAImg: match.teamAImg,
                                    teamBImg: match.teamBImg,
                                    teamName: match.teamAShort,
                                    teamName2: match.teamBShort,
                                    teamScore: match.teamAScore,
                                    teamScore2: match.teamBScore,
                                    teamOver: match.teamAOver,
                                   
                                    teamOver2: match.teamBOver),
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
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10, top: 10),
                            child: Text(
                              truncateText(match.venue, 60),
                              style: CustomStyles.smallTextStyle,
                            ),
                          ),
                        ],
                      ),
                    ]),
                  );
                }).toList(),
              );
            }
          },
        ),
        size20h,
        Row(
          children: List<Widget>.generate(
            matches
                .length, // Replace `totalSlides` with the total number of slides
            (index) {
              return Container(
                width: 8,
                height: 8,
                margin: EdgeInsets.symmetric(horizontal: 3),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentSlide == index ? myColorRed : myColorWhite,
                    border: border),
              );
            },
          ),
        ),
 ],
    );
  }
}
