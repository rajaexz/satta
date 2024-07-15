import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:winner11/screen/auth/controller/PinController.dart';
import 'package:winner11/screen/auth/forget_pin.dart';
import 'package:winner11/screen/tap1/upcomming.dart';

import '../../network/network_config.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utilis/alinement.dart';
import '../../utilis/boxSpace.dart';
import '../../utilis/fontstyle.dart';

class PinPage extends StatelessWidget {
  final PinController pinController = Get.put(PinController());
  var makepin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Obx(() {
            if (pinController.isLoading.value) {
              return CircularProgressIndicator();
            } else {
              return Column(
              
                children: [
                  
        
        
                    size20h,
                  size20h,
                  size20h,
                  size20h,
                  size20h,
                  size20h,
                  size20h,
                  Column(
                    crossAxisAlignment: AlignmentStartCross,
                    children: [
                      Text("Eenter Set Pin ",
                          style: CustomStyles.headerTextStyle),
                      size10h,
                      Text("Get 50 Coins on  Sign up",
                          style: CustomStyles.smallTextStyle),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: AlignmentStartCross,
                    children: [
                      size10h,
                      size10h,
                      size20h,
                      size20h,
                      Text("Best Of Luck",
                          style: CustomStyles.header2TextStyle),
                      size10h,
                      size10h,
        
                ]),
                  Pinput(
                    length: 4,
                    obscureText: true,
                    controller: pinController.setpinController,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed:pinController.errorMessage.isEmpty
                        ? () {
                            // Manually trigger login for testing or alternative UI flow
                            pinController.loginWithPin();
                          }
                        : null,
                    child: const Text('Submit'),
                  ),
                  const SizedBox(height: 20),
                         customImageContainer(
                      context: context,
                      imageUrl: 'assets/wh.jpg',
                      onTap: openWhatsApp,
                      name: "Whatsapp",
                      imageSize: 50),
           
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Logic to reset the PIN
                      pinController.setpinController.clear();
                      Get.to(ForgotPasswordScreenPIN());
                    },
                    child: const Text('Reset PIN'),
                  ),
                ],
              );
            }
          }),
        ),
      ),
    );
  }


  
  

Future<void> openWhatsApp() async {
  const phoneNumber = '1234567890'; // Replace with the actual phone number
  final whatsappUrl = 'whatsapp://send?phone=$phoneNumber';

  if (await canLaunch(whatsappUrl)) {
    await launch(whatsappUrl);
  } else {
    throw 'Could not launch $whatsappUrl';
  }
}
}
