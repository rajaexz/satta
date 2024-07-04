class StarlineRate {
  String name;
  String costAmount;
  String earningAmount;

  StarlineRate(
      {required this.name,
      required this.costAmount,
      required this.earningAmount});

  factory StarlineRate.fromJson(Map<String, dynamic> json) {
    return StarlineRate(
      name: json['name'] ?? '', // Provide default empty string if null
      costAmount:
          json['cost_amount'] ?? '', // Provide default empty string if null
      earningAmount:
          json['earning_amount'] ?? '', // Provide default empty string if null
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

class StarlineGame {
  String name;
  String id;
  String result;
  bool play;

  StarlineGame(
      {required this.name,
      required this.id,
      required this.result,
      required this.play});

  factory StarlineGame.fromJson(Map<String, dynamic> json) {
    return StarlineGame(
      name: json['name'] ?? '', // Provide default empty string if null
      id: json['id'] ?? '', // Provide default empty string if null
      result: json['result'] ?? '', // Provide default empty string if null
      play: json['play'] ?? false, // Provide default false if null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
      'result': result,
      'play': play,
    };
  }
}

class StarlineResponse {
  String message;
  String code;
  String status;
  String starlineChart;
  List<StarlineRate> starlineRates;
  List<StarlineGame> starlineGames;

  StarlineResponse({
    required this.message,
    required this.code,
    required this.status,
    required this.starlineChart,
    required this.starlineRates,
    required this.starlineGames,
  });

  factory StarlineResponse.fromJson(Map<String, dynamic> json) {
    var ratesList = json['starline_rates'] as List? ?? [];
    List<StarlineRate> rates =
        ratesList.map((i) => StarlineRate.fromJson(i)).toList();

    var gamesList = json['starline_game'] as List? ?? [];
    List<StarlineGame> games =
        gamesList.map((i) => StarlineGame.fromJson(i)).toList();

    return StarlineResponse(
      message: json['message'] ?? '', // Provide default empty string if null
      code: json['code'] ?? '', // Provide default empty string if null
      status: json['status'] ?? '', // Provide default empty string if null
      starlineChart:
          json['starline_chart'] ?? '', // Provide default empty string if null
      starlineRates: rates,
      starlineGames: games,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'code': code,
      'status': status,
      'starline_chart': starlineChart,
      'starline_rates': starlineRates.map((rate) => rate.toJson()).toList(),
      'starline_game': starlineGames.map((game) => game.toJson()).toList(),
    };
  }
}
