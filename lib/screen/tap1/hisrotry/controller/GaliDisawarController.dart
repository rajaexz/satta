import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../network/api_path.dart';
import '../../../../network/network_config.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Galidisawarcontroller extends GetxController {
  var isLoading = false.obs;
  final Dio _dio = Dio();
  BidHistoryResponse? games;

  var fromDate = DateTime.now().obs;
  var toDate = DateTime.now().obs;

  @override
  void onInit() {
    fetchBitStatement();
    super.onInit();
  }

  Future<void> fetchBitStatement() async {
    isLoading(true);
    try {
      final token = 'JZzG5NPNnOCRS5lO'; // Use your actual token here
      final response = await _dio.post(
        ' ${ApiPath.baseUrl}gali_disawar_bid_history',
        options: Options(headers: {'Token': "JZzG5NPNnOCRS5lO"}),
        data: {
          'from_date':
              '${fromDate.value.toIso8601String().split('T').first} 00:00:00',
          'to_date':
              '${toDate.value.toIso8601String().split('T').first} 23:59:59',
        },
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.data);
        if (jsonResponse['status'] == 'success') {
          games = BidHistoryResponse.fromJson(jsonResponse);
        } else {
          Get.showSnackbar(const GetSnackBar(
            title: "Something went wrong",
            message: "Incomplete",
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
          ));
        }
      }
    } catch (e) {
      Get.showSnackbar(GetSnackBar(
        title: "Error",
        message: e.toString(),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 2),
      ));
    } finally {
      isLoading(false);
    }
  }

  void updateDates(DateTime from, DateTime to) {
    fromDate.value = from;
    toDate.value = to;
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
      gameId: json['game_id'],
      gameType: json['game_type'],
      leftDigit: json['left_digit'],
      rightDigit: json['right_digit'],
      bidPoints: json['bid_points'],
      biddedAt: json['bidded_at'],
      gameName: json['game_name'],
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
