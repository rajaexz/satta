import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../model/bitlist.dart';
import '../../../utilis/app_constant.dart';


class GameBidController extends GetxController {
  var bids = <GameData>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchGameBids();
    super.onInit();
  }

  void fetchGameBids() async {
   
    final store = await SharedPreferences.getInstance();
   var  token = store.getString(AppConstant.tokenKey);

    try {
      isLoading(true);
      var response = await http.get(
        Uri.parse('https://development.smapidev.co.in/api/Api/main_game_list'), // Replace with your API URL
        headers: {
          'Content-Type': 'application/json',
          'Token':token.toString(), // Your API token
        },
         );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['status'] == 'success') {
          var bidList = data['data'] as List;
          bids.value = bidList.map((e) => GameData.fromJson(e)).toList();
        }
      }
    } finally {
      isLoading(false);
    }
  }
}
