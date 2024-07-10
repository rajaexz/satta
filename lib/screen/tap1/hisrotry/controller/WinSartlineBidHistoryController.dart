// network/network_provider.dart
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';

// controllers/win_history_controller.dart
import 'package:intl/intl.dart';

import '../../../../network/api_path.dart';
import '../../../../network/network_config.dart';
import '../../../../network/storage_repository.dart';

class WinHistoryController extends GetxController {
  var winHistoryList = WinHistoryResponse(
    message: '',
    code: '',
    status: '',
    data: [],
  ).obs;
  var isLoading = false.obs;
  final Dio _dio = Dio();
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
      final token = await StorageRepository.getToken();
      final response = await _dio.get(
        '${ApiPath.baseUrl}starline_win_history',
        options: Options(
          headers: {'Token': "$token"},
        ),
      );
      var jsonResponse = jsonDecode(response.data); // Decode the JSON response
      if (jsonResponse['status'] == 'success') {
        // Check status from JSON response
        winHistoryList.value = WinHistoryResponse.fromJson(jsonResponse);
      } else {
        Get.showSnackbar(GetSnackBar(
          message: jsonResponse['message'], // Show message from JSON response
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
