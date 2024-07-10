import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:dio/src/form_data.dart' as alfrom;
import '../../../../network/api_path.dart';
import '../../../../network/storage_repository.dart';

class Galidisawarcontroller extends GetxController {
  var isLoading = false.obs;
  var starlineResponse = GaliBidHistoryResponse(
    message: '',
    code: '',
    status: '',
    data: [],
  ).obs;
  var fromDate = DateTime.now().obs;
  var toDate = DateTime.now().obs;

  final Dio _dio = Dio();

  @override
  void onInit() {
    fetchBitStatement();
    super.onInit();
  }

  String get formattedFromDate =>
      DateFormat('yyyy-MM-dd HH:mm:ss').format(fromDate.value);
  String get formattedToDate =>
      DateFormat('yyyy-MM-dd HH:mm:ss').format(toDate.value);

  Future<void> fetchBitStatement() async {
    final formDData =
        alfrom.FormData.fromMap({"from_date": fromDate, "to_date": toDate});

    isLoading(true);
    try {
      final token = await StorageRepository.getToken();
      print("Token: $token");

      final response = await _dio.get(
        '${ApiPath.baseUrl}gali_disawar_bid_history',
        data: formDData,
        options: Options(
          headers: {'Token': "$token"},
        ),
      );
      print("Response Data: ${response.data}");

      if (response.statusCode == 200) {
        var jsonResponse =
            jsonDecode(response.data); // Decode the JSON response
        print("JSON Response: $jsonResponse");

        if (jsonResponse['status'] == 'success') {
          starlineResponse.value =
              GaliBidHistoryResponse.fromJson(jsonResponse);
          print("Parsed Response: ${starlineResponse.value}");
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
}

class GaliBidHistory {
  String gameId;
  String gameType;
  String leftDigit;
  String rightDigit;
  String bidPoints;
  String biddedAt;
  String gameName;

  GaliBidHistory({
    required this.gameId,
    required this.gameType,
    required this.leftDigit,
    required this.rightDigit,
    required this.bidPoints,
    required this.biddedAt,
    required this.gameName,
  });

  factory GaliBidHistory.fromJson(Map<String, dynamic> json) {
    return GaliBidHistory(
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

class GaliBidHistoryResponse {
  String message;
  String code;
  String status;
  List<GaliBidHistory> data;

  GaliBidHistoryResponse({
    required this.message,
    required this.code,
    required this.status,
    required this.data,
  });

  factory GaliBidHistoryResponse.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<GaliBidHistory> dataList =
        list.map((i) => GaliBidHistory.fromJson(i)).toList();
    return GaliBidHistoryResponse(
      message: json['message'],
      code: json['code'],
      status: json['status'],
      data: dataList,
    );
  }
}
