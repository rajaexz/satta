// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:Billa/screen/auth/controller/authController.dart';

import 'package:get/get.dart';

import 'package:Billa/routes/Api.dart';

import 'package:Billa/utilis/AllColor.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';

class OtpPagePin extends StatefulWidget {
  var code;
  OtpPagePin({super.key, this.code});

  @override
  State<OtpPagePin> createState() => _OtpPagePinState();
}

class _OtpPagePinState extends State<OtpPagePin> {
  final SignupController authController = Get.put(SignupController());

  //api

  @override
  Widget build(BuildContext context) {

var   number =  Get.arguments;
    var otpcode;
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        margin: EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/onboarding0.jpg',
                width: 150,
                height: 150,
              ),
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
                  otpcode = pin;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  GestureDetector(
                      onTap: () {
                 authController.verifyOtpPin(number,otpcode);
                       

                      },
                      child: DefaultTextStyle(
                        style: TextStyle(color: myColor),
                        child: const Text(
                          "verify",
                        ),
                      )),
                  TextButton(
                      onPressed: () {
                        authController.resendotpPIn(otpcode);
                      },
                      child: DefaultTextStyle(
                        style: TextStyle(color: myColor),
                        child: const Text(
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
