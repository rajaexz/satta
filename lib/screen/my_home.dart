import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:winner11/banner/banner.dart';
import 'package:winner11/banner/banner_Model.dart';
import 'package:winner11/screen/component/deviceInfo.dart';
import 'package:winner11/service/authapi.dart';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winner11/screen/component/custom_toaster.dart';

import 'package:winner11/screen/header/appbar.dart';

import 'package:winner11/screen/header/sidebar.dart';

import 'package:winner11/screen/tap1/upcomming.dart';

import 'package:winner11/utilis/globlemargin.dart';

import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;

  @override
  void initState() {
    super.initState();
    getConnectivity();

    // fetchDataAndStore();
  }

  setStoreKYC(kyc) async {
    final store = await SharedPreferences.getInstance();
    store.setString('KYCstatus', kyc);
  }

  // notificatio dotte
  // fetchDataAndStore() async {
  //       WidgetsBinding.instance?.addPostFrameCallback((_) async {
  //     await contractionDeviceInfo(context);
  //   });
  //   // Initialize noti_number with a default value (e.g., 0)
  //       final store = await SharedPreferences.getInstance();

  //      store.setString('checkWelcome',"1");
  // }

  getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
        (ConnectivityResult result) async {
          isDeviceConnected = await InternetConnectionChecker().hasConnection;
          if (!isDeviceConnected && isAlertSet == false) {
            // ignore: use_build_context_synchronously
            showDialogBox(context, isAlertSet, setState, isDeviceConnected);
            setState(() => isAlertSet = true);
          }
        },
      );
  Future<void> _refreshProfile() async {
    setState(() {/* update state */});
  }

  final List<String> imageUrls = [
    'assets/onboarding1.png',
    'assets/onboarding2.jpg',
    'assets/onboarding0.jpg',
  ];
ScrollController _scrollController = ScrollController();
bool _showButton = false; 
  @override
  Widget build(BuildContext context) {
    List<String> banners = imageUrls.map((url) => url).toList();

    return RefreshIndicator(
      onRefresh: _refreshProfile,
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'BILLO',
        ),
        drawer: myDrawer(context),
        body: SingleChildScrollView(

          controller: _scrollController,
          child: Column(
            children: [
              //banner----------------------------------------------------
_showButton
                ? ElevatedButton(
                    onPressed: () {
                      // Handle button press
                    },
                    child: Text('Button'),
                  )
                : SizedBox.shrink(),
              BannerAdd(banners: banners, currentSlide: banners.length),
              Container(
                margin: GlobleglobleMargin.globleMargin,
                child: const UpComming(),
              ),
            ],
          ),
        ),
        // bottomNavigationBar: const NavBarMusicWidget(),
      ),
    );
  }
}
