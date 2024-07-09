// network/network_provider.dart
import 'dart:convert';

import 'package:get/get.dart';

// controllers/win_history_controller.dart
import 'package:intl/intl.dart';

import '../../../../network/api_path.dart';
import '../../../../network/network_config.dart';

class WinHistoryController extends GetxController {
  var winHistoryList = <WinHistory>[].obs;
  var isLoading = false.obs;

  var fromDate = DateTime.now().obs;
  var toDate = DateTime.now().obs;

  final NetworkProvider networkProvider;

  WinHistoryController(this.networkProvider);

  String get formattedFromDate =>
      DateFormat('yyyy-MM-dd HH:mm:ss').format(fromDate.value);
  String get formattedToDate =>
      DateFormat('yyyy-MM-dd HH:mm:ss').format(toDate.value);

  void fetchWinHistory() async {
    try {
      isLoading(true);
      var response = await networkProvider.postCommonCallForm(
          ' ${ApiPath.baseUrl}starline_win_history',
          {"from_date": fromDate, "to_date": toDate});

      var jsonResponse = jsonDecode(response.body); // Decode the JSON response
      if (response.status == 'success') {
        winHistoryList.value = jsonResponse;
      } else {
        Get.showSnackbar(GetSnackBar(
          message: response.bodyString,
          duration: Duration(seconds: 2),
        ));
      }
    } catch (e) {
      Get.showSnackbar(const GetSnackBar(
        message: 'Error fetching data',
        duration: Duration(seconds: 2),
      ));
    } finally {
      isLoading(false);
    }
  }

  void updateDateRange(DateTime newFromDate, DateTime newToDate) {
    fromDate.value = newFromDate;
    toDate.value = newToDate;
    fetchWinHistory();
  }
}

// models/win_history.dart
class WinHistory {
  String gameId;
  String gameType;
  String digit;
  String panna;
  String bidPoints;
  String biddedAt;
  String gameName;

  WinHistory({
    required this.gameId,
    required this.gameType,
    required this.digit,
    required this.panna,
    required this.bidPoints,
    required this.biddedAt,
    required this.gameName,
  });

  factory WinHistory.fromJson(Map<String, dynamic> json) {
    return WinHistory(
      gameId: json['game_id'],
      gameType: json['game_type'],
      digit: json['digit'],
      panna: json['panna'],
      bidPoints: json['bid_points'],
      biddedAt: json['bidded_at'],
      gameName: json['game_name'],
    );
  }
}

class WinHistoryResponse {
  String message;
  String code;
  String status;
  List<WinHistory> data;

  WinHistoryResponse({
    required this.message,
    required this.code,
    required this.status,
    required this.data,
  });

  factory WinHistoryResponse.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<WinHistory> dataList =
        list.map((i) => WinHistory.fromJson(i)).toList();
    return WinHistoryResponse(
      message: json['message'],
      code: json['code'],
      status: json['status'],
      data: dataList,
    );
  }
}
