import 'package:Billa/screen/component/darkmode.dart';
import 'package:flutter/material.dart';
import 'package:Billa/utilis/borderbox.dart';
import 'package:get/get.dart';

import '../../utilis/AllColor.dart';
import '../../utilis/fontstyle.dart';

myFunction({myColor, text, textColor}) {
  return Container(
    padding: EdgeInsets.all(5),
    width: double.infinity,
    height: 60,
    decoration: BoxDecoration(
      borderRadius: boRadius5,
      boxShadow: [boxshadow],
      color: myColorWhite,
      border: Border.all(color: myColorRed),
    ),
    alignment: Alignment.center,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        DefaultTextStyle(
            style: textColor,
            child: Text(
              text,
            )),
      ],
    ),
  );
}

final ThemeController themeController = Get.put(ThemeController());

class MyFunctionInput extends StatefulWidget {
  final TextEditingController controller;
  final String fieldName;
  final String hintText;
  final TextInputType inputType;
  final String errorMessage;
  final String usernameRegex; // New parameter for username validation
  final bool? obscureText;

  MyFunctionInput({
    required this.controller,
    required this.fieldName,
    required this.hintText,
    required this.inputType,
    required this.errorMessage,
    required this.usernameRegex, // Pass the regex as a parameter
    this.obscureText,
  });

  @override
  _MyFunctionInputState createState() => _MyFunctionInputState();
}

class _MyFunctionInputState extends State<MyFunctionInput> {
  bool isAUser = false;
  int valueCount = 0;
  void setValidator(String inputValue) {
    setState(() {
      valueCount = inputValue.length;
      isAUser = RegExp(widget.usernameRegex).hasMatch(inputValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: themeController.isLightMode.value ? myColorWhite : myColor,
          border:
              Border.all(color: myColorRed), // Replace with your border style
          borderRadius:
              BorderRadius.circular(10), // Replace with your border radius
        ),
        child: TextFormField(
          decoration: InputDecoration(
            errorText:
                isAUser == true || valueCount <= 0 ? null : widget.errorMessage,
            hintText: widget.hintText,
          ),
          controller: widget.controller,
          onChanged: (inputValue) {
            setValidator(inputValue);
          },

          textAlign: TextAlign.start,
          keyboardType: widget.inputType,
          style: TextStyle(fontSize: 16), // Replace with your text style
          autofocus: true,
          cursorColor: Colors.black, // Replace with your cursor color
        ),
      ),
    );
  }
}

Widget myFunctionInput2(
  TextEditingController controller,
  String fieldName,
  String hintText,
  TextInputType inputType,
  String errorMessage,
) {
  return Obx(() => Container(
        width: 400,
        height: 70,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: themeController.isLightMode.value ? myColorWhite : myColor,
          border: borderRed,
          borderRadius: boRadiusAll,
          boxShadow: [boxshadow],
        ),
        child: TextFormField(
          decoration: InputDecoration(
            hintText: hintText,
          ),
          controller: controller,
          onChanged: (newValue) {},
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter $fieldName';
            }

            // Add additional validation for bank account number
            if (isValidBankAccount(value)) {
              return 'Please enter a valid $fieldName';
            }

            return null;
          },
          keyboardType: inputType,
          style: CustomStyles.smallTextStyle,
          autofocus: true,
          cursorColor: myColor,
        ),
      ));
}

bool isValidBankAccount(String value) {
  // Implement your custom validation logic for the bank account number
  // Return true if the bank account number is considered valid, otherwise false
  // Example: Check for a specific length, format, or any other criteria
  return value.length == 12; // Modify this according to your requirements
}
