import 'package:winner11/screen/component/coundown.dart';
import 'package:winner11/utilis/AllColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:winner11/utilis/fontstyle.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../service/authapi.dart';

class CustomToaster {
  // static void showSuccess(BuildContext context, String message) {
  //   _showToast(context, message, Colors.green);
  // }

  // static void showWarning(BuildContext context, String message) {
  //   _showToast(context, message, Colors.orange);
  // }

  // static void _showToast(BuildContext context, String message, Color color) {
  //   final scaffold = ScaffoldMessenger.of(context);
  //   scaffold.showSnackBar(
  //     SnackBar(
  //       content: DefaultTextStyle(style: CustomStyles.smallTextStyle,
  //       child: Text(message)),
  //       backgroundColor: color,
  //     ),
  //   );
  // }

  static void showSuccess(BuildContext context, String message) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          text:message,
        );
  }
       static void showWarning(BuildContext context, String message) {
        QuickAlert.show(
          context: context,
   
       
          type: QuickAlertType.warning,
          text: message,
        );
  }
            static void showLoding(BuildContext context, String message) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.loading,
          text: message,
        );
  }
}


Future<void> showPopup(context) async {
    late SharedPreferences _prefs;
       _prefs  = await SharedPreferences.getInstance();
  // Your code to show the popup goes here
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: EdgeInsets.zero,
        content: 
        
       SizedBox(
              width: double.maxFinite,
              child: Stack(
                children: [
                  // Full Image
                  GestureDetector(
                    onTap: (){
                     
                  launchUrl(Uri.parse("https://google.com"));


                    },
                    child: Image.network(
                      'https://google.com',
                      fit: BoxFit.fitHeight,
                      height: 200,
                      // Adjust the height as needed
                    ),
                  ),
                  // Cancel Button
                  Positioned(
                    top: 8,
                    right: 8,
                    child: IconButton(
                      icon: Icon(Icons.close, color:myColorRed),
                      onPressed: () {
                        Navigator.of(context).pop();
                        _prefs.setString('lastPopupDate', getCurrentDate());
                      },
                    ),
                  ),
                ],
              ),
            )
 

        
        
        
        
        
        
        
        
        
        
        
      
      );
    },
  );
}











//networking 
showDialogBox(context,isAlertSet,setState,isDeviceConnected) => showCupertinoDialog<String>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title:
        Text('No Connection', style:  CustomStyles.smallTextStyle,),
          content:
      Text('Please check your internet connectivity',style: CustomStyles.smallTextStyle,),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.pop(context, 'Cancel');
                setState(() => isAlertSet = false);
                isDeviceConnected =
                    await InternetConnectionChecker().hasConnection;
                if (!isDeviceConnected && isAlertSet == false) {
                  showDialogBox(context,isAlertSet,setState,isDeviceConnected);
                  setState(() => isAlertSet = true);
                }
              },
              child:  Text('OK',   style : CustomStyles.smallTextStyle,) 
            ),
          ],
        ),
      );