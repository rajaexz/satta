class GameData {
  final String id;
  final String name;
  final String chartUrl;
  final bool play;
  final bool open;
  final bool marketOpen;
  final String openTime;
  final String closeTime;
  final int sortCol;
  final String result;

  GameData({
    required this.id,
    required this.name,
    required this.chartUrl,
    required this.play,
    required this.open,
    required this.marketOpen,
    required this.openTime,
    required this.closeTime,
    required this.sortCol,
    required this.result,
  });

  factory GameData.fromJson(Map<String, dynamic> json) {
    return GameData(
      id: json['id'],
      name: json['name'],
      chartUrl: json['chart_url'],
      play: json['play'],
      open: json['open'],
      marketOpen: json['market_open'],
      openTime: json['open_time'],
      closeTime: json['close_time'],
      sortCol: json['sortcol'],
      result: json['result'],
    );
  }
}
