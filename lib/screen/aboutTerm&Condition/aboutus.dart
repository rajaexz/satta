import 'package:flutter/material.dart';
import 'package:winner11/screen/component/headNavi.dart';
import 'package:winner11/screen/component/shimmer.dart';
import 'package:winner11/screen/component/treamsHeading.dart';
import 'package:winner11/screen/header/appbar.dart';
import 'package:winner11/service/authapi.dart';
import 'package:winner11/utilis/AllColor.dart';
import 'package:winner11/utilis/fontstyle.dart';
import 'package:winner11/utilis/globlemargin.dart';

class Myaboutus extends StatefulWidget {
  const Myaboutus({super.key});

  @override
  State<Myaboutus> createState() => _MyaboutusState();
}

class _MyaboutusState extends State<Myaboutus> {
  @override
    Widget build(BuildContext context) {
          final ApiService apiService = ApiService();
    final mQ = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar:CustomAppBar(
          title: "About Us",
        ),
        body: SingleChildScrollView(
           child:    FutureBuilder(
          future:
              apiService.userAllDoc( uri: '/user_about_us'),
          builder: (context, snapshot) {
       return     Column(
              children: [
                Container(
                  margin: GlobleglobleMargin.globleMargin,
                  child: Column(children: [
                      
                    SectionTitle(title: '1. Legal About Us'),
                            SectionContent(
                  content: "about_us" ,
                            ),
                  
                  ],),
                )
              
                 ],
            );
  
              },
                )
          ),
      ),
    );
  }

}