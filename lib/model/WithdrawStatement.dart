class WithdrawStatement {
  final String points;
  final String transType;
  final String transDet;
  final String transStatus;
  final String createdAt;
  final String transMsg;

  WithdrawStatement({
    required this.points,
    required this.transType,
    required this.transDet,
    required this.transStatus,
    required this.createdAt,
    required this.transMsg,
  });

  factory WithdrawStatement.fromJson(Map<String, dynamic> json) {
    return WithdrawStatement(
      points: json['points']??" ",
      transType: json['trans_type']??" ",
      transDet: json['trans_det']??" ",
      transStatus: json['trans_status']??" ",
      createdAt: json['created_at']??" ",
      transMsg: json['trans_msg']??" ",
    );
  }
}

class WithdrawData {
  final String availablePoints;
  final String withdrawOpenTime;
  final String withdrawCloseTime;
  final List<WithdrawStatement> statement;

  WithdrawData({
    required this.availablePoints,
    required this.withdrawOpenTime,
    required this.withdrawCloseTime,
    required this.statement,
  });

  factory WithdrawData.fromJson(Map<String, dynamic> json) {
    var list = json['statement'] as List;
    List<WithdrawStatement> statementList = list.map((i) => WithdrawStatement.fromJson(i)).toList();

    return WithdrawData(
      availablePoints: json['available_points'] ?? "",
      withdrawOpenTime: json['withdraw_open_time'] ??" ",
      withdrawCloseTime: json['withdraw_close_time'] ??" ",
      statement: statementList,
    );
  }
}
