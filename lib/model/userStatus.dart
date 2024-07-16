import 'dart:convert';

class UserStatusResponse {
  String message;
  String code;
  String status;
  Data data;

  UserStatusResponse({
    required this.message,
    required this.code,
    required this.status,
    required this.data,
  });

  factory UserStatusResponse.fromJson(Map<String, dynamic> json) {
    return UserStatusResponse(
      message: json['message'],
      code: json['code'],
      status: json['status'],
      data: Data.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'code': code,
      'status': status,
      'data': data.toJson(),
    };
  }
}

class Data {
  String availablePoints;
  String transfer;
  String upiName;
  String upiPaymentId;
  String maximumDeposit;
  String minimumDeposit;
  String maximumWithdraw;
  String minimumWithdraw;
  String maximumTransfer;
  String minimumTransfer;
  String maximumBidAmount;
  String minimumBidAmount;

  Data({
    required this.availablePoints,
    required this.transfer,
    required this.upiName,
    required this.upiPaymentId,
    required this.maximumDeposit,
    required this.minimumDeposit,
    required this.maximumWithdraw,
    required this.minimumWithdraw,
    required this.maximumTransfer,
    required this.minimumTransfer,
    required this.maximumBidAmount,
    required this.minimumBidAmount,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      availablePoints: json['available_points'],
      transfer: json['transfer'],
      upiName: json['upi_name'],
      upiPaymentId: json['upi_payment_id'],
      maximumDeposit: json['maximum_deposit'],
      minimumDeposit: json['minimum_deposit'],
      maximumWithdraw: json['maximum_withdraw'],
      minimumWithdraw: json['minimum_withdraw'],
      maximumTransfer: json['maximum_transfer'],
      minimumTransfer: json['minimum_transfer'],
      maximumBidAmount: json['maximum_bid_amount'],
      minimumBidAmount: json['minimum_bid_amount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'available_points': availablePoints,
      'transfer': transfer,
      'upi_name': upiName,
      'upi_payment_id': upiPaymentId,
      'maximum_deposit': maximumDeposit,
      'minimum_deposit': minimumDeposit,
      'maximum_withdraw': maximumWithdraw,
      'minimum_withdraw': minimumWithdraw,
      'maximum_transfer': maximumTransfer,
      'minimum_transfer': minimumTransfer,
      'maximum_bid_amount': maximumBidAmount,
      'minimum_bid_amount': minimumBidAmount,
    };
  }
}
