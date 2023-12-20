import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:winner11/screen/header/appbar.dart';
import 'package:winner11/screen/header/headerTop.dart';

import 'package:winner11/utilis/fontstyle.dart';

import '../header/sidebar.dart';
import '../../utilis/globlemargin.dart';

class SeeMore extends StatelessWidget {
  const SeeMore({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'More',
      ),
      body: Container(
        margin: GlobleglobleMargin.globleMargin,
        child: Column(children: [
     Column(
  children: [
    Simpletitlebtn(
      HeadName: "Documentation",
    ),
    ListTile(
      trailing: const Icon(Icons.arrow_forward),
      leading: getIconForTitle("Terms & Condition"),
      title: Row(
        children: [
          Text('Terms & Condition', style: CustomStyles.header2TextStyle),
        ],
      ),
      onTap: () {
        Get.toNamed('/tarmAnd');
      },
    ),
    ListTile(
      trailing: Icon(Icons.arrow_forward),
      leading: getIconForTitle("About Us"),
      title: Row(
        children: [
          Text('About Us', style: CustomStyles.header2TextStyle),
        ],
      ),
      onTap: () {
        Get.toNamed('/myAboutus');
      },
    ),
  
    ListTile(
      trailing: Icon(Icons.arrow_forward),
      leading: getIconForTitle("Privacy Policy"),
      title: Row(
        children: [
          Text('Privacy Policy', style: CustomStyles.header2TextStyle),
        ],
      ),
      onTap: () {
        Get.toNamed('/privacy');
      },
    ),

    ListTile(
      trailing: Icon(Icons.arrow_forward),
      leading: getIconForTitle("Faq"),
      title: Row(
        children: [
          Text('FAQ', style: CustomStyles.header2TextStyle),
        ],
      ),
      onTap: () {
        Get.toNamed('/faq');
      },
    ),
  ],
)

   ]),
      ),
    );
    
  }

}

Icon getIconForTitle(String title) {
  switch (title) {
    case "Terms & Condition Policy":
      return Icon(Icons.info);
    case "About Us":
      return Icon(Icons.account_circle);
        case "Privacy Policy":
      return Icon(Icons.help);
    case "FAQ":
      return Icon(Icons.help);
    // Add more cases for other titles as needed
    default:
      return Icon(Icons.info);
  }
}
