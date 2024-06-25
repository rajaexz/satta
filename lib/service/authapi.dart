import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:winner11/screen/live/live_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
class ApiService {
  final String baseUrl =
      'https://winners11.in'; // Use "http" or "https" as needed
  final Dio dio = Dio();

  ApiService();


  Future<Map<String, dynamic>> userPostAllApi(
      {Map<String, dynamic>? data, uri}) async {
    final store = await SharedPreferences.getInstance();
    final token = store.getString("token");

    try {
      dio.options.baseUrl = baseUrl;
      dio.options.headers = {
        'Content-Type': 'application/json',
        'Authorization': uri == "/user_Login" ? token : "",
      };

      final response = await dio.post('$uri', data: data);
   
      if (response.statusCode == 200) {
     
        return {"data": response.data, "status": "200"};

      } else {
        return {"data": "nodata", "status": response.statusCode};
      }
    } catch (e) {
      throw Exception('Failed to make the API request: $e');
    }
  }


userMatchList({Map<String, dynamic>? data, uri}) async {
  final store = await SharedPreferences.getInstance();
  final token = store.getString("token");

  try {
    dio.options.baseUrl = baseUrl;
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    final response = await dio.post('$uri', data: data);
print(response);
    if (response.statusCode == 200) {
      return {"data": response.data, "status": "200"};
    } else {
      return {"data": "nodata", "status": response.statusCode};
    }

  } on DioException  catch (e) {
    if (e.response != null && e.response!.statusCode == 401) {
      // Handle 401 Unauthorized error here
    
      return {"data": "unauthorized", "status": 401};
    } else {
      // Handle other DioErrors or rethrow if needed
      throw Exception('Failed to make the API request: $e');
    }
  } catch (e) {
    // Catch general exceptions
    throw Exception('Failed to make the API request: $e');
  }
}

  userallType({Map<String, dynamic>? data, uri}) async {
    final store = await SharedPreferences.getInstance();
    final token = store.getString("token");
  
    try {
      dio.options.baseUrl = baseUrl;
      dio.options.headers = {
        'Content-Type': 'application/json',
        'Authorization': token,
      };
 
      final response = await dio.post('$uri', data: data);
      if (response.statusCode == 200) {
    
        return {"data": response.data, "status": "200"};
      } else {
        return {"data": "nodata", "status": response.statusCode};
      }
    } catch (e) {
      throw  {"data": "nodata", "status": "error"};
    }
  }

  userallGet({Map<String, dynamic>? data, uri}) async {
    final store = await SharedPreferences.getInstance();
    final token = store.getString("token");
  
    try {
      dio.options.baseUrl = baseUrl;
      dio.options.headers = {
        'Content-Type': 'application/json',
        'Authorization': token,
      };

      final response = await dio.get('$uri');

      if (response.statusCode == 200) {
    
        return {"data": response.data, "status": "200"};
      } else {
        return {"data": "nodata", "status": response.statusCode};
      }
    } catch (e) {
      throw Exception('Failed to make the API request: $e');
    }
  }

  userAllDoc({ data, uri}) async {
    final store = await SharedPreferences.getInstance();
    final token = store.getString("token");

    final id = store.getString("userId");

    try {
      dio.options.baseUrl = baseUrl;
      dio.options.headers = {
        'Content-Type': 'application/json',
        'Authorization': token,
      };

      final response = await dio.post('$uri', data: {"id": id});
  
      if (response.statusCode == 200 ) {
        return {"data": response.data, "status": "200"};
      } else {
        return {"data": "nodata", "status": response.statusCode};
      }

      
    } catch (e) {
      return {"data": "$e"};
    }
  }

Future<String> userImageUpload({
  required File panImage,
  required String id,
  String? url,
}) async {
  final store = await SharedPreferences.getInstance();
  final token = store.getString("token");

 

  

  FormData formData = FormData.fromMap({
    'id': id,
    'image': await MultipartFile.fromFile(
      panImage.path,
      filename: 'image.jpg',
    ),
  });

  try {
    Dio dio = Dio();
    dio.options.baseUrl = baseUrl;
    dio.options.headers['Content-Type'] = 'multipart/form-data';
    dio.options.headers['Authorization'] = 'Bearer $token';

    final response = await dio.post(
      url ?? '', // Use the provided URL or an empty string if it's null
      data: formData,
    );

    if (response.statusCode == 200) {
      return response.data.toString();
    } else {
         return "not-ok";
    }
  } catch (e) {
    print('Error making the HTTP request: $e');
    return "not-ok";
  }
}

///////////////////////////////////////////////              Live  /////////////////////////////////////////////////////////

  
userAllLive({ uri}) async {


  try {
    

    final response = await dio.get(uri);

    if (response.statusCode == 200) {
      final responseData = json.decode(response.data);
     if (responseData['status'] == true && responseData['data'] != null) {
      
        if (responseData['data'] is List) {
          List<LiveMatch> matches = (responseData['data'] as List)
              .map((json) => LiveMatch.fromJson(json))  
              .toList();

          
          return {"data": matches, "status": "200"};
        } else if (responseData['data'] is Map) {
          // Handle the case when data is a single match object
          LiveMatch match = LiveMatch.fromJson(responseData['data']);
          
          return {"data": [match], "status": "200"};
        } else {
          return {"data": "Invalid data format: Unexpected data type", "status": "400"};
        }



      } else {
        return {"data": "Invalid data format: Missing required fields", "status": "400"};
      }
    } else {
      return {"data": "Failed to fetch live match", "status": response.statusCode.toString()};
    }
  } catch (e) {
    return {"data": "$e"};
  }
}


}


