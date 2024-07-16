import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:uuid/data.dart';

import 'package:get/get.dart';
import 'package:Billa/utilis/app_constant.dart';

import '../../../model/usedetail.dart';
import '../../../network/api_path.dart';
import '../../../network/storage_repository.dart';

class UserDetailsController extends GetxController {
  var userDetails = UserDetails(
    message: '',
    code: '',
    status: '',
    data: UserData(
      username: '',
      mobile: '',
      email: '',
      bankName: '',
      accountHolderName: '',
      ifscCode: '',
      branchAddress: '',
      bankAccountNo: '',
      paytmMobileNo: '',
      phonepeMobileNo: '',
      gpayMobileNo: '',
      pendingNoti: '',
    ),
  ).obs;

  var isLoading = false.obs;
  final Dio _dio = Dio();

  void fetchUserDetails() async {
    isLoading(true);
    try {
      final token = await StorageRepository.getToken();

      print(token);
      final response = await _dio.get(
        '${ApiPath.baseUrl}get_user_details', // Replace with your actual API URL
        options: Options(headers: {'Token': token}),
      );
      print(response.data);
      if (response.statusCode == 200) {
        var jsonResponse =
            jsonDecode(response.data!); // Decode the JSON response
        userDetails(UserDetails.fromJson(jsonResponse));
      } else {
        // Handle error
      }
    } catch (e) {
      // Handle error
      print(e);
    } finally {
      isLoading(false);
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchUserDetails();
  }
}
