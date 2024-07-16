import 'package:flutter/material.dart';
import 'package:Billa/utilis/AllColor.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController controller;

  PasswordField({Key? key, required this.controller}) : super(key: key);

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;
  bool isANumber = true; // Assuming this is a placeholder for your actual logic
  Color myColor = myColorRed; // Replace with your actual color

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.text,
      style: TextStyle(
        color: myColor,
        fontFamily: 'OpenSans',
      ),
      decoration: InputDecoration(
        errorText: isANumber ? null : "Please enter a Password",
        contentPadding: EdgeInsets.only(top: 14.0),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
            color: myColor,
          ),
          onPressed: _togglePasswordVisibility,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: myColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: myColor),
        ),
        hintText: 'Enter your Password',
      ),
      controller: widget.controller,
      obscureText: _obscureText,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a Password';
        }

        // If none of the conditions are met, return null (no error)
        return null;
      },
    );
  }
}
