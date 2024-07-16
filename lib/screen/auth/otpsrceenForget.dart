// ignore_for_file: use_build_context_synchronously

import 'package:Billa/screen/auth/controller/authController.dart';

import 'package:get/get.dart';

import 'package:Billa/routes/Api.dart';

import 'package:Billa/utilis/AllColor.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';

class OtpPageForget extends StatefulWidget {
  int? mobile;
  OtpPageForget({super.key, this.mobile});

  @override
  State<OtpPageForget> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPageForget> {
  final SignupController authController = Get.put(SignupController());

  var code = "";

  //api

  @override
  Widget build(BuildContext context) {
    var data = Get.arguments;
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
          fontSize: 20, color: myColorRed, fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: myColorWhite),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: myColorRed),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: myColorWhite,
      ),
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        margin: EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 25,
              ),
              const Text(
                "OTP Verification",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "We need to register your phone without getting started!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Pinput(
                length: 4,
                showCursor: true,
                onCompleted: (pin) {
                  code = pin;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: myColorRed,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () async {
                        authController.verifyOtp(data!, code);
                      },
                      child: Text(
                        "Verify Your Phone OTP",
                        style: TextStyle(color: myColorWhite),
                      ))),
              Row(
                children: [
                  TextButton(
                      onPressed: () {
                        Get.toNamed("/login");
                      },
                      child: DefaultTextStyle(
                        style: TextStyle(color: myColor),
                        child: Text(
                          "Edit Phone Number ?",
                        ),
                      )),
                  TextButton(
                      onPressed: () {
                        authController.resendotp();
                      },
                      child: DefaultTextStyle(
                        style: TextStyle(color: myColor),
                        child: Text(
                          "Resend opt ..",
                        ),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
