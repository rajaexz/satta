import 'dart:convert';

import 'package:winner11/screen/component/custom_toaster.dart';
import 'package:winner11/service/authapi.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

ApiService apiservice = ApiService();

Future<void> insertData({context, String? name, data}) async {
  final store = await SharedPreferences.getInstance();

  var id = store.getString('userId');
  
  var myApi = await apiservice.userMatchList(data: {
    "id": id,
    "pool_id": data["data"]["id"].toString(),
    "team": name == "teams1"
        ? data["data"]["team_a"].toString()
        : data["data"]["team_b"].toString()
  }, uri: "/get_poolId");
 switch (myApi["data"]["message"]) {
    case "Repeated entity":
      CustomToaster.showWarning(context, "${myApi["data"]["message"]}");

   print("hit1");
      break;
    case "must be a string":
      CustomToaster.showWarning(context,"${myApi["data"]["message"]}");
       
   
      break;
    case "please put valid team":
      CustomToaster.showWarning(context, "${myApi["data"]["message"]}");
     
     
      break;

    case "unable to enter in the match":
      CustomToaster.showWarning(context,"${myApi["data"]["message"]}");

      break;

    default:
      if (myApi["status"] == 401) {
        CustomToaster.showWarning(context, "${myApi["data"]["message"]}");
     
      } else {
        CustomToaster.showSuccess(context, "${myApi["data"]["message"]}");
                
        Get.offAllNamed("/home", arguments: id);
      }
  }
}
