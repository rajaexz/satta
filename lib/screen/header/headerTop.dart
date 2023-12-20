
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:winner11/utilis/fontstyle.dart';

import '../../utilis/AllColor.dart';


Widget titlebtn({
  required String? HeadName, // Add "?" for null safety
  required BuildContext context1,
  required dynamic Headno, // Change the type to "dynamic" for flexibility
  required String? routes, // Add "?" for null safety
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      SizedBox(
      
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  HeadName ?? "Default Text", // Provide a default text if HeadName is null
                  style: CustomStyles.headerTextStyle,
                ),
              ],
            ),
          ],
        ),
      ),
      InkWell(
        onTap: () {
          Get.toNamed(routes?.toString() ?? "/home"); // Provide a default route if routes is null
        },
        child: Text("($Headno)"),
      ),
    ],
  );
}

Simpletitlebtn(
    {required String HeadName,
 
  }) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      SizedBox(
        height: 24,
        child: Column(
          children: [
            
            Row(
              children: [
                Text(
                  HeadName,
                  style:CustomStyles.header5TextStyle,
                ),
               
              ],
            ),
          ],
        ),
      ),
    ],
  );
}




// here is using titel button 

class TopHeaderPopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
         
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                
                IconButton(
                  icon:  Icon(
                    Icons.arrow_back,
                    color: myColor!, // Close button color
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the popup
                  },
                ),
              ],
            ),
          ),
      
        ],
      );
    
  }
}

