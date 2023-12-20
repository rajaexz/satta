import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winner11/screen/component/coundown.dart';
import 'package:winner11/screen/component/imageComponet.dart';
import 'package:winner11/screen/header/appbar.dart';
import 'package:winner11/screen/header/headerTop.dart';
import 'package:winner11/service/authapi.dart';
import 'package:winner11/utilis/AllColor.dart';
import 'package:winner11/utilis/alinement.dart';
import 'package:winner11/utilis/borderbox.dart';
import 'package:winner11/utilis/boxSpace.dart';
import 'package:winner11/utilis/fontstyle.dart';
import 'package:winner11/utilis/globlemargin.dart';

class AllShowContest extends StatefulWidget {
  var data;

  AllShowContest({super.key, this.data});

  @override
  State<AllShowContest> createState() => _AllShowContestState();
}

class _AllShowContestState extends State<AllShowContest> {
  @override
  Widget build(BuildContext context) {
    final ApiService apiService = ApiService();

    return Scaffold(
      appBar: CustomAppBar(title: ""),
      body: Container(
        margin: GlobleglobleMargin.globleMargin,
        child: FutureBuilder(
          future: apiService.userAllDoc(data: {}, uri: "/specific_user_matches"),
          builder: (context, snapshot) {
          
            if (snapshot.connectionState == ConnectionState.waiting) {
              // While the future is still running, display a loading indicator
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              // If an error occurred, display an error message
              return Text('Error: ${snapshot.error}');
            } else {
          
              final data =
                  (snapshot.data as Map<String, dynamic>)["data"]["result"];
          
         
          
               
               
                return Column(
                  children: [
                    Simpletitlebtn(
                      HeadName: "MY Contest  All match ",
                    ),
                    size10h,
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> item =data[index];
                  
                    return    Container(
                      margin: EdgeInsets.only(top: 10),
                      child:
                       GestureDetector(
                            onTap: () {
                              Get.toNamed('/myContestStatus');
                            },
                            child: Container(
                          
                                height: 70,
                                padding: const EdgeInsets.only(
                                    top: 5, bottom: 5, right: 10, left: 10),
                                decoration: BoxDecoration(
                                  
                                    border: border, borderRadius: boRadiusAll),
                                child: Column(children: [
                                  size10h,
                                  ImageSelect(
                                      Image1: "assets/ball.png",
                                      Image2: "assets/ball.png",
                                      data: item),
                                ])),
                          ),
                    );
                     
                     
                       },
                    ),
                  ],
                );
              
              
            }
          },
        ),
      ),
    );
  }

  ImageSelect({Image1, Image2, data}) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Positioned(
                  child: Container(
                    padding: EdgeInsets.all(3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            ImageComponentNet(
                              myWidth: 30.0,
                              myheight: 30.0,
                              myImage: data["team_a_img"].toString(),
                            ),
                            size10w,
                            Text(
                              data["team_a_short"].toString(),
                              style: CustomStyles.smallTextStyle,
                            ),
                          ],
                        ),
                        size10h,
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      height: 40.0,
                      width: 40.0,
                      decoration: BoxDecoration(
                          color: data["selected_team"] == data["team_a"]
                              ? myColorGray.withOpacity(0.5)
                              : Colors.transparent,


                          borderRadius: BorderRadius.circular(100)),
                      child: data["selected_team"] == data["team_a"]
                          ? Icon(
                              Icons.check,
                              size: 30,
                              color: myColorDarkRed,
                            )
                          : null,
                    ),
                  ),
                ),

                // GestureDetector(
                // onTap: (){
                //    setState(() {
                //      deleteDB(data["id"]);
                //    });

                // },
                // child: Positioned(
                //   bottom: 0,
                //   right: 0,
                //   child: Icon(Icons.delete, size: 50,),)),
              ],
            ),
          ],
        ),

        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Text(
                getMatchStatus(
                  1, // Total seconds until the match starts
                  data["match_date"]
                      .toString(), // Match date (customize it according to your data)
                  data["match_time"].toString(),
                ),
                style: TextStyle(
                  color: myColorRed,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),

        Stack(
          children: [
            Positioned(
              child: Container(
                padding: EdgeInsets.all(3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                          data["team_b_short"].toString(),
                          style: CustomStyles.smallTextStyle,
                        ),
                        size10w,
                        ImageComponentNet(
                          myWidth: 30.0,
                          myheight: 30.0,
                          myImage: data["team_b_img"].toString(),
                        ),
                      ],
                    ),
                    size10h,
                  ],
                ),
              ),
            ),
           
           
           
            Positioned(
              top: 0,
              right: 0,
              child: InkWell(
                onTap: () {},
                child: Container(
                  height: 40.0,
                  width: 40.0,
                  decoration: BoxDecoration(
                      color: data["selected_team"] == data["team_b"]
                          ? myColorGray.withOpacity(0.5)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(100)),
                  child: data["selected_team"].toString() ==  data["team_b"]
                      ? Icon(
                          Icons.check,
                          size: 30,
                          color: myColorDarkRed,
                        )
                      : null,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
