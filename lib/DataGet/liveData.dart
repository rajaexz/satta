import 'dart:async';
import 'dart:convert';
import 'package:winner11/screen/live/live_model.dart';
import 'package:winner11/service/authapi.dart';
import 'package:get/get.dart';

class RealTimeDataController extends GetxController {
  var liveMatches = <LiveMatch>[].obs;
  final ApiService apiService = ApiService();
  

  @override
  void onInit() {
    super.onInit();
  _fetchRealTimeData();
  
  }

 

  void updateLiveMatches(List<LiveMatch> updatedMatches) {
    liveMatches.assignAll(updatedMatches);
  }



  Future<void> _fetchRealTimeData() async {
    try {
      var updatedMatches = await apiService.userAllLive(uri:"http://172.105.48.215/apiv4/liveMatchList/3e9ecab325646fe13c88466f48cfe73e");
      final List<LiveMatch> matches = updatedMatches["data"];

   
      updateLiveMatches(matches);
    } catch (error) {
      print('Error fetching real-time data: $error');
    }
  }

 
}
