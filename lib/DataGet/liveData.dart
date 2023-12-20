import 'dart:async';
import 'dart:convert';
import 'package:winner11/screen/live/live_model.dart';
import 'package:winner11/service/authapi.dart';
import 'package:get/get.dart';

// class RealTimeDataController extends GetxController {
//   var liveMatches = <LiveMatch>[].obs;
//   final ApiService apiService = ApiService();
//   // Simulate real-time updates with a timer
//   late Timer _timer;

//   @override
//   void onInit() {
//     super.onInit();
//     _startTimer();
//     _fetchInitialData(); // Fetch initial data when the controller is initialized
//   }

//   void _startTimer() {
//     _timer = Timer.periodic(Duration(seconds: 3), (timer) {
//       _fetchRealTimeData(); // Fetch real-time data every 5 seconds
//     });
//   }

//   // Method to update real-time data
//   void updateLiveMatches(List<LiveMatch> updatedMatches) {
//     liveMatches.value = updatedMatches;
//   }

//   Future<void> _fetchInitialData() async {
//     try {
//       // Fetch initial data from your API
//         var initialMatches = await apiService.userAllLive(uri: "http://apicricketchampion.in/webservices/liveMatchList/20122cd5366e30f0847774c9d7698d30");
     
//       final List<LiveMatch> matches =initialMatches["data"];
//       updateLiveMatches(matches);
//     } catch (error) {
//       print('Error fetching initial data: $error');
//     }
//   }

//   Future<void> _fetchRealTimeData() async {
//     try {
// ;
//       // Fetch updated data from your API
//      var  updatedMatches = await apiService.userAllLive(uri: "http://apicricketchampion.in/webservices/liveMatchList/20122cd5366e30f0847774c9d7698d30");
    
//       final List<LiveMatch> matches =updatedMatches["data"];
//       updateLiveMatches(matches);
//     } catch (error) {
//       print('Error fetching real-time data: $error');
//     }
//   }



//   @override
//   void onClose() {
//     _timer.cancel(); // Cancel the timer when the controller is closed
//     super.onClose();
//   }
// }
class RealTimeDataController extends GetxController {
  var liveMatches = <LiveMatch>[].obs;
  final ApiService apiService = ApiService();
  late Timer _timer;

  @override
  void onInit() {
    super.onInit();
    _startTimer();
    _fetchInitialData();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _fetchRealTimeData();
    });
  }

  void updateLiveMatches(List<LiveMatch> updatedMatches) {
    liveMatches.assignAll(updatedMatches);
  }

  Future<void> _fetchInitialData() async {
    try {
      var initialMatches = await apiService.userAllLive(uri:  "http://apicricketchampion.in/webservices/liveMatchList/20122cd5366e30f0847774c9d7698d30");
           final List<LiveMatch> matches = initialMatches["data"];
      updateLiveMatches(matches);
    } catch (error) {
      print('Error fetching initial data: $error');
    }
  }

  Future<void> _fetchRealTimeData() async {
    try {
      var updatedMatches = await apiService.userAllLive(uri: "http://apicricketchampion.in/webservices/liveMatchList/20122cd5366e30f0847774c9d7698d30");
      final List<LiveMatch> matches = updatedMatches["data"];
      updateLiveMatches(matches);
    } catch (error) {
      print('Error fetching real-time data: $error');
    }
  }

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }
}
