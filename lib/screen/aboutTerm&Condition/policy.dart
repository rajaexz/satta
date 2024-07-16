import 'package:flutter/material.dart';
import 'package:Billa/screen/component/headNavi.dart';
import 'package:Billa/screen/component/treamsHeading.dart';
import 'package:Billa/screen/header/appbar.dart';
import 'package:Billa/service/authapi.dart';
import 'package:Billa/utilis/AllColor.dart';
import 'package:Billa/utilis/boxSpace.dart';
import 'package:Billa/utilis/globlemargin.dart';

class Privacy extends StatefulWidget {
  const Privacy({super.key});

  @override
  State<Privacy> createState() => _TarmAndState();
}

class _TarmAndState extends State<Privacy> {
  @override
  Widget build(BuildContext context) {
    final mQ = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Privacy Policy',
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            size20h,
            size20h,
            Container(
              margin: GlobleglobleMargin.globleMargin,
              child: Column(
                children: [
                  SectionTitle(title: '1. Legal Privacy Policy'),
                  SectionContent(
                    content: "privacy_policy",
                  ),
                ],
              ),
            )
          ],
        )),
      ),
    );
  }
}
