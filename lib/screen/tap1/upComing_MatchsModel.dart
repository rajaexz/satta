class Match {
  final int? id;
  final int? matchId;
  final String? series;
  final String? matchDate;
  final String? matchTime;
  final String? matchType;
  final String? teamA;
  final String? sortNameA;
  final String? matchFlagA;
  final String? teamB;
  final String? sortNameB;
  final String? matchFlagB;
  final int? entryFee;
  final int? winningPrize;
  final String? matchStatus;

  Match({
    required this.id,
    required this.matchId,
    required this.series,
    required this.matchDate,
    required this.matchTime,
    required this.matchType,
    required this.teamA,
    required this.sortNameA,
    required this.matchFlagA,
    required this.teamB,
    required this.sortNameB,
    required this.matchFlagB,
    required this.entryFee,
    required this.winningPrize,
    required this.matchStatus,
  });

  factory Match.fromJson(Map<String, dynamic> json) {
    return Match(
      id: json['id'],
      matchId: json['match_id'],
      series: json['series'],
      matchDate: json['match_date'],
      matchTime: json['match_time'],
      matchType: json['match_type'],
      teamA: json['team_a'],
      sortNameA: json['sort_name_a'],
      matchFlagA: json['team_a_img'],
      teamB: json['team_b'],
      sortNameB: json['sort_name_b'],
      matchFlagB: json['team_b_img'],
      entryFee: json['entry_fee'],
      winningPrize: json['winning_prize'],
      matchStatus: json['match_status'],
    );
  }
}

class MatchData {
  final String message;
  final List<Match> result;

  MatchData({
    required this.message,
    required this.result,
  });

  factory MatchData.fromJson(Map<String, dynamic> json) {
    return MatchData(
      message: json['message'],
      result: (json['result'] as List<dynamic>)
          .map((resultJson) => Match.fromJson(resultJson))
          .toList(),
    );
  }
}
