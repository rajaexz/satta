import 'package:flutter/material.dart';

import 'package:Billa/screen/component/treamsHeading.dart';
import 'package:Billa/screen/header/appbar.dart';

import 'package:Billa/utilis/boxSpace.dart';
import 'package:Billa/utilis/globlemargin.dart';

class TarmAnd extends StatefulWidget {
  const TarmAnd({super.key});

  @override
  State<TarmAnd> createState() => _TarmAndState();
}

class _TarmAndState extends State<TarmAnd> {
  @override
  Widget build(BuildContext context) {
    final mQ = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Term & Condition',
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
                  SectionTitle(title: '1. Legal Term And Condition'),
                  SectionContent(
                    content: "term_condition",
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
