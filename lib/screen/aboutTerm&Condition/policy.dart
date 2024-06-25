
import 'package:flutter/material.dart';
import 'package:winner11/screen/component/headNavi.dart';
import 'package:winner11/screen/component/treamsHeading.dart';
import 'package:winner11/screen/header/appbar.dart';
import 'package:winner11/service/authapi.dart';
import 'package:winner11/utilis/AllColor.dart';
import 'package:winner11/utilis/boxSpace.dart';
import 'package:winner11/utilis/globlemargin.dart';
class Privacy extends StatefulWidget {
  const Privacy({super.key});

  @override
  State<Privacy> createState() => _TarmAndState();
}

class _TarmAndState extends State<Privacy> {
    final ApiService apiService = ApiService();
  @override
  Widget build(BuildContext context) {
    final mQ = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
        title: 'Privacy Policy',
      ),
        body: SingleChildScrollView(
          child:             Column(
              children: [
             size20h,
              size20h,
                Container(
                  margin: GlobleglobleMargin.globleMargin,
                  child: Column(children: [
                      
                    SectionTitle(title: '1. Legal Privacy Policy'),
                            SectionContent(
                  content: "privacy_policy",
                            ),
                     
                  ],),
                )
              
                 ],
            )
     ),
        ),
      );
    
  }
}