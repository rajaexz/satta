import 'package:flutter/material.dart';
import 'package:winner11/screen/component/imageComponet.dart';
import 'package:winner11/utilis/boxSpace.dart';
import 'package:winner11/utilis/fontstyle.dart';

teamA_B({Image1, Image2 , data}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ImageComponentNet(
                myWidth: 30.0,
                myheight: 30.0,
                myImage: Image1,
              ),
              size10w,
            Text(
              data["team_a_short"],
             style: CustomStyles.smallTextStyle,
 
            )
            ],
          ),
          size10h,
                  Text(
                    
                    data["team_a"],
                        style: CustomStyles.smallTextStyle,
                    )
        ],
      ),
    
      Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
            Text(
               
               data["team_b_short"],
               style: CustomStyles.smallTextStyle,
             
            ),
              size10w,
              ImageComponentNet(
                myWidth: 30.0,
                myheight: 30.0,
                myImage:Image2,
              ),
            ],
          ),
          size10h,
              Text(
                 
                data["team_b"],
                  style: CustomStyles.smallTextStyle,
             
                )
        ],
      ),
    ],
  );
}
