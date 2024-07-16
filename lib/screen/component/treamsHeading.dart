import 'package:flutter/material.dart';
import 'package:Billa/utilis/fontstyle.dart';

class SubSectionTitle extends StatelessWidget {
  final String title;

  SubSectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16.0, top: 8.0, right: 16.0),
      child: Text(
        title,
        style: CustomStyles.smallTextStyle,
      ),
    );
  }
}

class SectionContent extends StatelessWidget {
  final String content;

  SectionContent({required this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        content,
        style: CustomStyles.smallTextStyle,
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        title,
        style: CustomStyles.headerTextStyle,
      ),
    );
  }
}
