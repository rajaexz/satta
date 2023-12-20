import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;


class SmsController extends GetxController {
 
final String apiUrl = 'https://www.fast2sms.com/dev/bulk';



Future<String> sendSMS(String phoneNumber, otp) async {
  try {
    final apiUrl = Uri.parse(
        "https://www.fast2sms.com/dev/bulkV2?authorization=fBmaE3rpMRN8juPqQwThCsSL2GtdvxVl17Dey0bJkAOU9I5gWFF3webRNGOc9IgZfVXBhCvjr2EP6JAx&variables_values=$otp&numbers=$phoneNumber&route=otp");

    final response = await http.get(apiUrl);

    if (response.statusCode == 200) {
      final responseBody = response.body;
      return responseBody;
    } else {
      return "not-ok";
    }
  } catch (e) {
    print(e);
    print('Error sending SMS: $e');
    return "error";
  }
}

  }


//globle date end time 

Future<String> getGlobalTime() async {
  final response = await http.get(Uri.parse('http://worldtimeapi.org/api/ip'));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final globalTime = data['utc_datetime'];
    return globalTime;
  } else {
    throw Exception('Failed to fetch global time');
  }
}
