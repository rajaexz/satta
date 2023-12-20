import 'package:winner11/screen/component/coundown.dart';
import 'package:winner11/screen/component/shimmer.dart';
import 'package:winner11/utilis/AllColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:winner11/utilis/fontstyle.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../service/authapi.dart';
    final ApiService apiService = ApiService();
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
        
        FutureBuilder(
  future: apiService.userAllDoc(uri: "/popup_get_user"),
  builder: (context, snapshot) {
    try {
      if (snapshot.connectionState == ConnectionState.waiting) {
        // While the future is still running, display a loading indicator
        return  Container(
      height: 200,
      child: const CircularProgressIndicator());
      } else if (snapshot.hasError) {
        // If an error occurred, display an error message
        return Text('Error: ${snapshot.error}');
      } else {
      
        // Data has been successfully fetched
        final data = (snapshot.data as Map<String, dynamic>)["data"]["result"];

        if (data == null || data.isEmpty) {
          return const Text("");
        }

     return SizedBox(
              width: double.maxFinite,
              child: Stack(
                children: [
                  // Full Image
                  GestureDetector(
                    onTap: (){
                     
                  launchUrl(Uri.parse(data["url"]));


                    },
                    child: Image.network(
                      'https://winners11.in/images/${data["image"]}',
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
            );
       
        
    }
    } catch (e) {
      return  Scaffold(body: 
      
      
    Container(
      height: 200,
      child: CircularProgressIndicator()));
      // Handle network-related errors here, show a message to the user, etc.
    }
  },
),

        
        
        
        
        
        
        
        
        
        
        
      
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