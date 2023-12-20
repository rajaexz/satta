import 'dart:async';

import 'package:winner11/screen/component/deviceInfo.dart';
import 'package:winner11/utilis/boxSpace.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:winner11/utilis/borderbox.dart';
import 'package:winner11/utilis/globlemargin.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utilis/AllColor.dart';

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

  String? allreadyExit;
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
    allreadyExit = store.getString('userId');
    Intro = store.getString('into');
    var duration = Duration(milliseconds: _splashDelay);

    return Timer(duration, navigationPage);
  }

  Future<void> navigationPage() async {
    if (Intro == "0" || Intro == null) {
      Get.offNamed("/intro");
    } else {
      final store = await SharedPreferences.getInstance();
      allreadyExit != null
          ? Get.offNamed("/home", arguments: store.getString("userId"))
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
      backgroundColor: myColorRed,
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
                      Container(
                     
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/splash.png"),
                            fit: BoxFit.fill,
                          ),
                          borderRadius: boRadiusAll,
                        ),
                        height: 200, // Set the height as needed
                        width: 200, // Set the width as needed
                      ),
                    
                      Lottie.asset('assets/ball.json', width: 200, height: 200)
         
                    ],
                  ))),
        ),
      ),
    );
  }
}
