class GaliDisawarRate {
  String name;
  String costAmount;
  String earningAmount;

  GaliDisawarRate({
    required this.name,
    required this.costAmount,
    required this.earningAmount,
  });

  factory GaliDisawarRate.fromJson(Map<String, dynamic> json) {
    return GaliDisawarRate(
      name: json['name'] ?? '',
      costAmount: json['cost_amount'] ?? '',
      earningAmount: json['earning_amount'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'cost_amount': costAmount,
      'earning_amount': earningAmount,
    };
  }
}

class GaliDisawarGame {
  String name;
  String time;
  String id;
  String result;
  bool play;

  GaliDisawarGame({
    required this.name,
    required this.time,
    required this.id,
    required this.result,
    required this.play,
  });

  factory GaliDisawarGame.fromJson(Map<String, dynamic> json) {
    return GaliDisawarGame(
      name: json['name'] ?? '',
      time: json['time'] ?? '',
      id: json['id'] ?? '',
      result: json['result'] ?? '',
      play: json['play'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'time': time,
      'id': id,
      'result': result,
      'play': play,
    };
  }
}

class GaliDisawarResponse {
  String message;
  String code;
  String status;
  String galiDisawarChart;
  List<GaliDisawarRate> galiDisawarRates;
  List<GaliDisawarGame> galiDisawarGames;

  GaliDisawarResponse({
    required this.message,
    required this.code,
    required this.status,
    required this.galiDisawarChart,
    required this.galiDisawarRates,
    required this.galiDisawarGames,
  });

  factory GaliDisawarResponse.fromJson(Map<String, dynamic> json) {
    var ratesList = json['gali_disawar_rates'] as List? ?? [];
    List<GaliDisawarRate> rates =
        ratesList.map((i) => GaliDisawarRate.fromJson(i)).toList();

    var gamesList = json['gali_disawar_game'] as List? ?? [];
    List<GaliDisawarGame> games =
        gamesList.map((i) => GaliDisawarGame.fromJson(i)).toList();

    return GaliDisawarResponse(
      message: json['message'] ?? '',
      code: json['code'] ?? '',
      status: json['status'] ?? '',
      galiDisawarChart: json['gali_disawar_chart'] ?? '',
      galiDisawarRates: rates,
      galiDisawarGames: games,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'code': code,
      'status': status,
      'gali_disawar_chart': galiDisawarChart,
      'gali_disawar_rates':
          galiDisawarRates.map((rate) => rate.toJson()).toList(),
      'gali_disawar_game':
          galiDisawarGames.map((game) => game.toJson()).toList(),
    };
  }
}
