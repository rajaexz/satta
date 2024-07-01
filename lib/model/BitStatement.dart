class Game {
  final String gameId;
  final String gameType;
  final String session;
  final String openDigit;
  final String closeDigit;
  final String openPanna;
  final String closePanna;
  final String bidPoints;
  final String biddedAt;
  final String gameName;

  Game({
    required this.gameId,
    required this.gameType,
    required this.session,
    required this.openDigit,
    required this.closeDigit,
    required this.openPanna,
    required this.closePanna,
    required this.bidPoints,
    required this.biddedAt,
    required this.gameName,
  });

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      gameId: json['game_id'],
      gameType: json['game_type'],
      session: json['session'],
      openDigit: json['open_digit'],
      closeDigit: json['close_digit'],
      openPanna: json['open_panna'],
      closePanna: json['close_panna'],
      bidPoints: json['bid_points'],
      biddedAt: json['bidded_at'],
      gameName: json['game_name'],
    );
  }
}
