import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:Billa/utilis/borderbox.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../utilis/AllColor.dart';
import '../utilis/app_constant.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const routeName = '/';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  final _splashDelay = 3000;
  late AnimationController _animationController;

  String? tokenpin;
  String? token;

  String? phone;
  String? Intro;
  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _animationController.forward();
    super.initState();

    _loadWidget();
  }

  _loadWidget() async {
    final store = await SharedPreferences.getInstance();
    tokenpin = store.getString(AppConstant.tokenKeypin);
    token = store.getString(AppConstant.tokenKey);
    phone = store.getString(AppConstant.phone);
    Intro = store.getString(AppConstant.isinto);
    var duration = Duration(milliseconds: _splashDelay);

    return Timer(duration, navigationPage);
  }

  Future<void> navigationPage() async {
    if (Intro == "0" || Intro == null) {
      Get.offNamed("/intro");
    } else {
      tokenpin != null && phone != null
          ? Get.offNamed("/setpin")
          : Get.offNamed("/login");
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myColorWhite,
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          height: 600,
          child: Center(
              child: ScaleTransition(
                  scale: _animationController,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                              image: AssetImage("assets/splash.jpeg"),
                              fit: BoxFit.fill,
                            ),
                            borderRadius: boRadiusAll,
                          ),
                          height: 200, // Set the height as needed
                          width: 200, // Set the width as needed
                        ),
                      ),
                    ],
                  ))),
        ),
      ),
    );
  }
}
