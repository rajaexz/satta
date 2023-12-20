import 'package:winner11/screen/component/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winner11/Db/insertData.dart';
import 'package:winner11/screen/component/custom_toaster.dart';
import 'package:winner11/screen/component/imageComponet.dart';
import 'package:winner11/service/authapi.dart';
import 'package:winner11/utilis/AllColor.dart';
import 'package:winner11/utilis/boxSpace.dart';
import 'package:winner11/utilis/fontstyle.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/main.dart';

class CustomPopupDialog extends StatelessWidget {
  ApiService apiservice = ApiService();
  var Adata;
  var textValue;
  CustomPopupDialog({super.key, this.Adata, this.textValue});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: SizedBox(
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Confirmation',
              style: CustomStyles.headerTextStyle,
            ),
            IconButton(
              icon: const Icon(
                  Icons.cancel_presentation_outlined), // Icon to display
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      ),
      content: FutureBuilder(
          future: apiservice.userAllDoc(uri: '/fetch_balance'),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              final data =
                  (snapshot.data as Map<String, dynamic>)["data"]?["balance"];

              if (data != null) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Entry",
                          style: CustomStyles.smallTextStyle,
                        ),
                        Text(
                          "Rs. ₹${Adata["data"]["entry_fee"].toString()} ",
                          style: CustomStyles.textExternelgreen,
                        )
                      ],
                    ),
                    size20h,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Winning prize",
                          style: CustomStyles.smallTextStyle,
                        ),
                        Text(
                          "Rs.  ₹${Adata["data"]["winning_prize"].toString()} ",
                          style: CustomStyles.textExternelgreen,
                        )
                      ],
                    ),
                    Divider(),
                   ],
                );
              } else {
                return   summer2;
              }
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return summer2 ;
              // Display a loading indicator
            } else {
              return Text('Data retrieval is not in progress');
            }
          }),
      actions: <Widget>[
        TextButton(
          onPressed: () async {
        
            insertData( context: context, name: textValue,data: Adata); 


          },
          child: Text(
            'Join Contest',
            style: CustomStyles.textExternel,
          ),
        ),
      ],
    );
  }
}

class CustomPopupDialog2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Do yo want log out',
            style: CustomStyles.headerTextStyle,
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ImageComponent(
            myWidth: 50.0,
            myheight: 50.0,
            myImage: "assets/ball.png",
          ),
          size20h,
          Text(
            "winner11",
            style: TextStyle(
              color: myColorRed,
              fontSize: 22,
              fontWeight: FontWeight.w800,
              fontFamily: 'Roboto1',
            ),
          ),
        ],
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
                'Cancel',
                style: CustomStyles.textExternel,
              ),
            ),
            TextButton(
              onPressed: () async {
                final store = await SharedPreferences.getInstance();
                CustomToaster.showSuccess(
                    context, "   User Successfully Logout");

                store.remove("userId");
                   store.remove("token");
                   store.remove("checkWelcome");
                   store.remove("lastPopupDate");
                   store.remove("into");
                Get.offAllNamed("/login");
              },
              child: Text(
                'Logout',
                style: CustomStyles.textExternel,
              ),
            ),
          ],
        )
      ],
    );
  }
}

// Show a custom input dialog
Future<void> showInputDialog(
    {required BuildContext context, textValue, data}) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Do you want save Contest !'),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CustomPopupDialog(
                    Adata: data,
                    textValue: textValue,
                  ); // Custom pop-up widget
                },
              );
            },
            child: Text('Save'),
          ),
        ],
      );
    },
  );
}

showProgressDialog(BuildContext context, message) {
  showDialog(
    context: context,
    barrierDismissible:
        false, // Prevents dismissing the dialog when tapping outside
    builder: (BuildContext context) {
      return AlertDialog(
        content: Row(
          children: [
            const CircularProgressIndicator(),
            const SizedBox(width: 16.0),
            Text("$message "),
          ],
        ),
      );
    },
  );
}


class DialogHelper {
  static Future<void> showInputDialog(BuildContext context) async {
    return showDialog(
       barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
  title: Text('Warning'),
  content: Text('An error occurred while processing your request. Please try again later.'),
  actions: <Widget>[

  ],
);
      },
    );
  }
}

Future<void> showInputDialogAllType({required BuildContext context, required String data}) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(data),
        actions: <Widget>[
          // Add any actions you want for the dialog here
        ],
      );
    },
  );
}