class GameWin {
  final String gameId;
  final String session;
  final String gameType;
  final String openDigit;
  final String closeDigit;
  final String openPanna;
  final String closePanna;
  final String winPoints;
  final String bidPoints;
  final String wonAt;
  final String gameName;

  GameWin({
    required this.gameId,
    required this.session,
    required this.gameType,
    required this.openDigit,
    required this.closeDigit,
    required this.openPanna,
    required this.closePanna,
    required this.winPoints,
    required this.bidPoints,
    required this.wonAt,
    required this.gameName,
  });

  factory GameWin.fromJson(Map<String, dynamic>? json) {
    return GameWin(
      gameId: json?['game_id'] ?? '',
      session: json?['session'] ?? '',
      gameType: json?['game_type'] ?? '',
      openDigit: json?['open_digit'] ?? '',
      closeDigit: json?['close_digit'] ?? '',
      openPanna: json?['open_panna'] ?? '',
      closePanna: json?['close_panna'] ?? '',
      winPoints: json?['win_points'] ?? '',
      bidPoints: json?['bid_points'] ?? '',
      wonAt: json?['won_at'] ?? '',
      gameName: json?['game_name'] ?? '',
    );
  }
}
