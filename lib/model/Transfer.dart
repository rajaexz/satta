class TransferVerifyResponse {
  final String message;
  final String code;
  final String status;
  final TransferVerifyData data;

  TransferVerifyResponse({
    required this.message,
    required this.code,
    required this.status,
    required this.data,
  });

  factory TransferVerifyResponse.fromJson(Map<String, dynamic> json) {
    return TransferVerifyResponse(
      message: json['message'],
      code: json['code'],
      status: json['status'],
      data: TransferVerifyData.fromJson(json['data']),
    );
  }
}

class TransferVerifyData {
  final String name;

  TransferVerifyData({required this.name});

  factory TransferVerifyData.fromJson(Map<String, dynamic> json) {
    return TransferVerifyData(name: json['name']);
  }
}



class TransferPointsResponse {
  final String message;
  final String code;
  final String status;

  TransferPointsResponse({
    required this.message,
    required this.code,
    required this.status,
  });

  factory TransferPointsResponse.fromJson(Map<String, dynamic> json) {
    return TransferPointsResponse(
      message: json['message'],
      code: json['code'],
      status: json['status'],
    );
  }
}
