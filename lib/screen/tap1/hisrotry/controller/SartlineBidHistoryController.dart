import 'package:get/get.dart';

import '../../../../network/api_path.dart';
import '../../../../network/network_config.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BidHistoryController extends GetxController {
  var bidHistoryList = <BidHistory>[].obs;
  var isLoading = false.obs;

  var fromDate = DateTime.now().obs;
  var toDate = DateTime.now().obs;

  final NetworkProvider networkProvider;

  BidHistoryController(this.networkProvider);

  String get formattedFromDate => DateFormat('yyyy-MM-dd HH:mm:ss').format(fromDate.value);
  String get formattedToDate => DateFormat('yyyy-MM-dd HH:mm:ss').format(toDate.value);

  void fetchBidHistory() async {
    try {
      isLoading(true);
    var response = await networkProvider.postCommonCallForm(' ${ApiPath.baseUrl}starline_bid_history', {"from_date":fromDate ,"to_date":toDate} );
       if (response.status == 'success') {
        bidHistoryList.value = response.body;
      } else {
        Get.showSnackbar(GetSnackBar(
          message: response.bodyString,
          duration: Duration(seconds: 2),
        ));
      }
    } catch (e) {
      Get.showSnackbar(GetSnackBar(
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
    fetchBidHistory();
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
    List<BidHistory> dataList = list.map((i) => BidHistory.fromJson(i)).toList();
    return BidHistoryResponse(
      message: json['message'],
      code: json['code'],
      status: json['status'],
      data: dataList,
    );
  }
}
