
import 'dart:math';


String generateOrderId() {
  // Generate 3 random alphabetic characters
  String alphaPart = String.fromCharCodes(List.generate(3, (index) =>
      'A'.codeUnitAt(0) + Random().nextInt(26))); // ASCII value of 'A' is 65

  // Generate 16 random numeric characters
  String numericPart = List.generate(16, (index) => Random().nextInt(10).toString()).join();

  // Concatenate alpha and numeric parts to create the final order ID
  String orderId = '$alphaPart$numericPart';

  return orderId;
}
