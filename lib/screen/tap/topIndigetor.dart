import 'package:flutter/material.dart';
import 'package:winner11/utilis/globlemargin.dart';

import '../../utilis/AllColor.dart';

class Indigator extends StatefulWidget {
  var currentPage;
  Indigator({super.key, required int this.currentPage});
  @override
  State<Indigator> createState() => _IndigatorState();
}

class _IndigatorState extends State<Indigator> {
  final int _numPages = 3;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    List<String> mytext = ["SELECT MATCH", "JOIN CONTEST", "FINISHED"];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == widget.currentPage
          ? _indicator(true, mytext[i],i)
          : _indicator(false, mytext[i],i));
    }
    return list;
  }

  Widget _indicator(bool isActive, text , num) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
            padding: GlobleglobleMargin.Margin10H,
          
            margin: EdgeInsets.only(right: 10),
            child: Text(
              text,
              style: TextStyle(fontSize: 11, color: isActive ? myColorWhite: myColorGray,   ),
            )),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              height:isActive ? 16.0 : 10.0,
              width: isActive ? 30.0 : 10.0,
              decoration: BoxDecoration(
              color: myColorWhite,
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              child:   num == 0
    ? Icon(Icons.star, size: isActive ? 15.0 : 10.0, color: myColor)
    : num == 1
        ? Icon(Icons.group_add, size: isActive ? 11.0 : 10.0, color: myColor)
        : num == 2
            ? Icon(Icons.check_circle, size: isActive ? 13.0 : 10.0, color: myColor)
            : Icon(Icons.error), // Default icon for unknown status
              // Icon(Icons.arrow_forward ,size:  isActive ? 11.0 : 10.0, color: myColor ),
            ),
           ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
       decoration: BoxDecoration(border:  Border.all(

  color: myColorRed,
  width: 0.5,
  style: BorderStyle.solid,
       )),
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _buildPageIndicator(),
      ),
    );
  }
}
