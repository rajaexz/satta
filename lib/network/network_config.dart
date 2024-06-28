import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:winner11/network/storage_repository.dart';
import 'package:winner11/utilis/utility.dart';

import 'api_path.dart';

class NetworkProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = ApiPath.baseUrl;
    httpClient.maxAuthRetries = 3;

    httpClient.addRequestModifier<void>((request) async {
      final store = await SharedPreferences.getInstance();
      // store.setString('KYCstatus', kyc);
      var token = await StorageRepository.getToken();
      print("----------${token}");
      request.headers['token'] = '${token}';
      return request;
    });

    httpClient.addResponseModifier((request, response) {
      Get.log(
          "Http Status ::: ${request.url} == ${response.statusCode} --- ${HttpStatus.unauthorized}");
      Get.log("Http Status ::: ${request.url} == ${response.body}");

      if (response.statusCode == HttpStatus.unauthorized) {
        Utility.loggedOut();
      }

      return response;
    });

    super.onInit();
  }

  Future<Response> postCommonCallForm(String url, dynamic data) =>
      post(url, FormData(data));

  Future<Response> postCommonCallBody(String url, dynamic data) =>
      post(url, data);

  Future<Response> getCall(String url) => get(url);

  Future<Response> getCallQuery(String url, dynamic query) =>
      get(url, query: query);
}