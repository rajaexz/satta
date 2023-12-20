import 'dart:async';

import 'package:winner11/DataGet/notiLocal.dart';
import 'package:winner11/banner/banner.dart';
import 'package:winner11/banner/banner_Model.dart';
import 'package:winner11/screen/appBottombar.dart/navbar.dart';
import 'package:winner11/screen/component/coundown.dart';
import 'package:winner11/screen/component/deviceInfo.dart';
import 'package:winner11/screen/component/imageComponet.dart';
import 'package:winner11/service/authapi.dart';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winner11/screen/component/custom_toaster.dart';

import 'package:winner11/screen/header/appbar.dart';

import 'package:winner11/screen/header/sidebar.dart';

import 'package:winner11/screen/tap/topIndigetor.dart';
import 'package:winner11/screen/tap1/upcomming.dart';

import 'package:winner11/utilis/AllColor.dart';

import 'package:winner11/utilis/globlemargin.dart';

import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;

  int _currentSlide = 0;
  final String? id = Get.arguments as String?;
  final ApiService apiService = ApiService();
  @override
  void initState() {
    super.initState();
    getConnectivity();
    
    fetchDataAndStore();
  }

  final NotiController notiController = Get.put(NotiController());

  // notificatio dotte
  fetchDataAndStore() async {
        WidgetsBinding.instance?.addPostFrameCallback((_) async {
      await contractionDeviceInfo(context);
    });
    // Initialize noti_number with a default value (e.g., 0)
        final store = await SharedPreferences.getInstance();

       store.setString('checkWelcome',"1");
  }

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

  @override
  Widget build(BuildContext context) {
    
    return RefreshIndicator(
      onRefresh: _refreshProfile,
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'WINNER11',
        ),
        drawer: myDrawer(context, id),
        body: SingleChildScrollView(
          child: Column(
            children: [
              //Indigator
              Container(
                  height: 50,
                  margin: EdgeInsets.zero,
                color: myColorRed,
                  child: Indigator(currentPage: 0)),

              //banner----------------------------------------------------
              FutureBuilder(
                future: apiService.userAllDoc(uri: "/user_banner"),
                builder: (context, snapshot) {
                  try {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError || snapshot.data == null) {
                      throw Exception(
                          'Error: ${snapshot.error ?? "No data available"}');
                    } else {
                      var bannersData = (snapshot.data
                          as Map<String, dynamic>)['data']["result"];
                
                      List<Banners> banners = bannersData
                          .map<Banners>((json) => Banners.fromJson(json))
                          .toList();
                      return BannerAdd(
                          banners: banners, currentSlide: _currentSlide);
                    }
                  } catch (e) {
                    print('Error in FutureBuilder: $e');
                    // Handle the error gracefully, e.g., display an error message to the user
                    return Text('An error occurred. Please try again later.');
                  }
                },
              ),

              Container(
                margin: GlobleglobleMargin.globleMargin,
                child: const UpComming(),
              ),
          
            ],
          ),
        ),
        bottomNavigationBar: const NavBarMusicWidget(),
      ),
    );
  }
}
