
import 'dart:math';

import 'package:get/get.dart';

String generateOTP() {
  // Define the length of the OTP
  int otpLength = 4;

  // Generate a random number with the specified length
  String otp = '';
  for (int i = 0; i < otpLength; i++) {
    otp += Random().nextInt(10).toString();
  }

  return otp;
}