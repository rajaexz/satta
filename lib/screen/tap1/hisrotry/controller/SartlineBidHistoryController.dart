import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../../network/api_path.dart';
import '../../../../network/network_config.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../network/storage_repository.dart';

class BidHistoryController extends GetxController {
  var bidHistoryList = BidHistoryResponse(
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

  BidHistoryController(this.networkProvider);

  String get formattedFromDate =>
      DateFormat('yyyy-MM-dd HH:mm:ss').format(fromDate.value);
  String get formattedToDate =>
      DateFormat('yyyy-MM-dd HH:mm:ss').format(toDate.value);
  @override
  void onInit() {
    fetchBitStatement();
    super.onInit();
  }

  Future<void> fetchBitStatement() async {
    // final formDData =
    //     alfrom.FormData.fromMap({"from_date": fromDate, "to_date": toDate});

    isLoading(true);
    try {
      final token = await StorageRepository.getToken();
      print("Token: $token");

      final response = await _dio.get(
        '${ApiPath.baseUrl}starline_bid_history',
        options: Options(
          headers: {'Token': "$token"},
        ),
      );
      var jsonResponse = jsonDecode(response.data); // Decode the JSON response

      if (response.statusCode == 200) {
        if (jsonResponse['status'] == 'success') {
          bidHistoryList.value = BidHistoryResponse.fromJson(jsonResponse);
        } else {
          Get.snackbar('Failed to fetch data', jsonResponse['message']);
        }
      } else {
        Get.snackbar('Failed to fetch data', 'Server error');
      }
    } catch (e) {
      // Handle error
      print("Error: $e");
      Get.snackbar('Failed to fetch data', e.toString());
    } finally {
      isLoading(false);
    }
  }

  void updateDateRange(DateTime newFromDate, DateTime newToDate) {
    fromDate.value = newFromDate;
    toDate.value = newToDate;
    fetchBitStatement();
  }
}

class BidHistory {
  String gameId;
  String gameType;
  String leftDigit;
  String rightDigit;
  String bidPoints;
  String biddedAt;
  String gameName;

  BidHistory({
    required this.gameId,
    required this.gameType,
    required this.leftDigit,
    required this.rightDigit,
    required this.bidPoints,
    required this.biddedAt,
    required this.gameName,
  });

  factory BidHistory.fromJson(Map<String, dynamic> json) {
    return BidHistory(
      gameId: json['game_id'] ?? "",
      gameType: json['game_type'] ?? "",
      leftDigit: json['left_digit'] ?? "",
      rightDigit: json['right_digit'] ?? "",
      bidPoints: json['bid_points'],
      biddedAt: json['bidded_at'] ?? "",
      gameName: json['game_name'] ?? "",
    );
  }
}

class BidHistoryResponse {
  String message;
  String code;
  String status;
  List<BidHistory> data;

  BidHistoryResponse({
    required this.message,
    required this.code,
    required this.status,
    required this.data,
  });

  factory BidHistoryResponse.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<BidHistory> dataList =
        list.map((i) => BidHistory.fromJson(i)).toList();
    return BidHistoryResponse(
      message: json['message'],
      code: json['code'],
      status: json['status'],
      data: dataList,
    );
  }
}
