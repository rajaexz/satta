import 'package:flutter/material.dart';

import 'package:Billa/screen/component/treamsHeading.dart';
import 'package:Billa/screen/header/appbar.dart';

import 'package:Billa/utilis/globlemargin.dart';

class Myaboutus extends StatefulWidget {
  const Myaboutus({super.key});

  @override
  State<Myaboutus> createState() => _MyaboutusState();
}

class _MyaboutusState extends State<Myaboutus> {
  @override
  Widget build(BuildContext context) {
    final mQ = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: "About Us",
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Container(
              margin: GlobleglobleMargin.globleMargin,
              child: Column(
                children: [
                  SectionTitle(title: '1. Legal About Us'),
                  SectionContent(
                    content: "about_us",
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
