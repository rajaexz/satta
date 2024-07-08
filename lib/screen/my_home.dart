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
import 'package:winner11/utilis/AllColor.dart';

import 'package:winner11/utilis/globlemargin.dart';

import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
                    margin: GlobleglobleMargin.globleMargin,
                    child: const UpComming(),
                  ),
                ],
              ),
      ),
    );
  }
}
