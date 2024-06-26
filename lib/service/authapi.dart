

import 'package:dio/dio.dart';
import 'package:get/get.dart';

class ApiService extends GetxService {
  late Dio _dio;

  @override
  void onInit() {
    super.onInit();
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://example.com', // replace with your base URL
        connectTimeout: Duration(seconds: 5000),
        receiveTimeout:  Duration(seconds: 3000),
      ),
    );
  }

  Future get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      return response;
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }

  Future post(String path, {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.post(path, data: data);
      return response;
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }
}


