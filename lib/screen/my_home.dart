import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:Billa/banner/banner.dart';
import 'package:Billa/banner/banner_Model.dart';
import 'package:Billa/screen/component/deviceInfo.dart';
import 'package:Billa/service/authapi.dart';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Billa/screen/component/custom_toaster.dart';

import 'package:Billa/screen/header/appbar.dart';

import 'package:Billa/screen/header/sidebar.dart';

import 'package:Billa/screen/tap1/upcomming.dart';
import 'package:Billa/utilis/AllColor.dart';
import 'package:Billa/utilis/fontstyle.dart';

import 'package:Billa/utilis/globlemargin.dart';

import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:marquee_list/marquee_list.dart';
import 'controller/MyHomePage_controller.dart';

class MyHomePage extends GetView<MyHomePageController> {
  const MyHomePage({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    Get.put(MyHomePageController());

    return Scaffold(
      appBar: CustomAppBar(
        title: 'BILLO',
      ),
      body: GetBuilder<MyHomePageController>(
        init: controller,
        builder: (controller) => MyHomeVeiw(
          controller: controller,
        ),
      ),
      drawer: myDrawer(context),
    );
  }
}

class MyHomeVeiw extends StatefulWidget {
  MyHomePageController? controller;
  MyHomeVeiw({super.key, this.controller});

  @override
  State<MyHomeVeiw> createState() => _MyHomeVeiwState();
}

class _MyHomeVeiwState extends State<MyHomeVeiw> with TickerProviderStateMixin {
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

  ScrollController _scrollController = ScrollController();
  bool _showButton = false;
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refreshProfile,
      child: SingleChildScrollView(
        controller: _scrollController,
        child: widget.controller!.isLoading.value
            ? Column(
                children: [
                  Center(
                    child: CircularProgressIndicator(
                      color: myColor,
                    ),
                  ),
                ],
              )
            : Column(
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
                  BannerAdd(banners: widget.controller!.dataModel!.banner),

                  Container(
                    color: Colors.black.withOpacity(0.5),
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    height: 50.0,
                    child: MarqueeList(
                      scrollDirection:
                          Axis.horizontal, // By default, it's horizontal
                      children: [
                        Text(
                          widget.controller!.dataModel!.bannerMarquee,
                          style: CustomStyleswhite.header2TextStyle,
                        ),
                      ],
                    ),
                  ),

                  Container(
                    margin: GlobleglobleMargin.globleMargin,
                    child: const UpComming(),
                  ),
                ],
              ),
      ),
    );
  }
}
