
import 'package:flutter/material.dart';
import 'package:winner11/screen/component/headNavi.dart';
import 'package:winner11/screen/component/treamsHeading.dart';
import 'package:winner11/screen/header/appbar.dart';
import 'package:winner11/service/authapi.dart';
import 'package:winner11/utilis/AllColor.dart';
import 'package:winner11/utilis/boxSpace.dart';
import 'package:winner11/utilis/globlemargin.dart';
class TarmAnd extends StatefulWidget {
  const TarmAnd({super.key});

  @override
  State<TarmAnd> createState() => _TarmAndState();
}

class _TarmAndState extends State<TarmAnd> {
    final ApiService apiService = ApiService();
  @override
  Widget build(BuildContext context) {
    final mQ = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        
   appBar: CustomAppBar(
        title: 'Term & Condition',
      ),
        body: SingleChildScrollView(
          child:          Column(
              children: [
               size20h,
               size20h,
                Container(
                  margin: GlobleglobleMargin.globleMargin,
                  child: Column(children: [
                      
                    SectionTitle(title: '1. Legal Term And Condition'),
                            SectionContent(
                  content: "term_condition",
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