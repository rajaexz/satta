import 'package:Billa/routes/Api.dart';
import 'package:Billa/screen/auth/forget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Billa/screen/auth/controller/authController.dart';
import 'package:Billa/screen/auth/singup.dart';
import 'package:Billa/utilis/alinement.dart';
import 'package:Billa/utilis/boxSpace.dart';
import 'package:Billa/utilis/fontstyle.dart';
import 'package:Billa/utilis/globlemargin.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../utilis/AllColor.dart';
import '../component/custom_toaster.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final SignupController loginController = Get.put(SignupController());

  var code = "";
  final themeSMS = Get.put(SmsController());
  TextEditingController phoneController = TextEditingController();

  TextEditingController pass = TextEditingController();
  final formKey = GlobalKey<FormState>();
  RegExp digitValidator = RegExp("[0-9]+");
  bool isANumber = true;

  void setValidator(String inputValue) {
    setState(() {
      isANumber = RegExp(r'^(\+91[\s-]?)?[789]\d{9}$').hasMatch(inputValue);
    });
  }

  void validateIndianPhoneNumber(String fullNumber) {
    // Regular expression to validate an Indian phone number
    RegExp regex = RegExp(r'^\+91[6-9]\d{9}$');

    if (regex.hasMatch(fullNumber)) {
      print('Valid Indian phone number');
    } else {
      print('Invalid Indian phone number');
    }
  }

  @override
  Widget build(BuildContext context) {
    FocusNode focusNode = FocusNode();

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: GlobleglobleMargin.globleMargin,
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: AlignmentStartCross,
              children: [
                // TopHeaderPopup(),
                size20h,
                size20h,
                size20h,
                size20h,
                size20h,
                size20h,
                size20h,
                Column(
                  crossAxisAlignment: AlignmentStartCross,
                  children: [
                    Text("Login up on Winer Satta App",
                        style: CustomStyles.headerTextStyle),
                    size10h,
                  ],
                ),
                Column(
                  crossAxisAlignment: AlignmentStartCross,
                  children: [
                    size10h,
                    size10h,
                    size20h,
                    size20h,
                    Text("Login using Mobile Number",
                        style: CustomStyles.header2TextStyle),
                    size10h,
                    size10h,
                    IntlPhoneField(
                      focusNode: focusNode,
                      controller: phoneController,
                      decoration: const InputDecoration(
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                      ),
                      initialCountryCode:
                          'IN', // Set the initial country code to India
                      onChanged: (phone) {
                        // This callback gives you an object with number and country code
                        validateIndianPhoneNumber(phone.completeNumber);
                      },
                      onCountryChanged: (country) {
                        // Optional: Handle logic when a user changes the country
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      style: TextStyle(
                        color: myColor,
                        fontFamily: 'OpenSans',
                      ),
                      decoration: InputDecoration(
                        errorText: isANumber ? null : "Please enter a Password",
                        contentPadding: EdgeInsets.only(top: 14.0),
                        prefixIcon: Icon(
                          Icons.remove_red_eye,
                          color: myColor,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: myColor!),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: myColor!),
                        ),
                        hintText: 'Enter your Password ',
                      ),
                      controller: pass,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a Password ';
                        }

                        // If none of the conditions are met, return null (no error)
                        return null;
                      },
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(ForgotPasswordScreen());
                      },
                      child: const Center(
                        child: Text("Forget pin "),
                      ),
                    ),
                    size10h,
                    size10h,
                    loginController.isLoading.value
                        ? const CircularProgressIndicator(
                            color: Colors.red,
                          )
                        : _buildLoginBtn(
                            context: context,
                            phController: phoneController,
                            pass: pass,
                            colors: myColorRed),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('You Do not  have account?  '),
                    TextButton(
                      onPressed: () {
                        Get.to(() => SignupPage());
                      },
                      child: const Text('Signup'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginBtn({
    required BuildContext context,
    required TextEditingController phController,
    required TextEditingController pass,
    required Color colors,
  }) {
    return GestureDetector(
      onTap: () async {
        if (formKey.currentState!.validate()) {
          loginController.login(mobile: phController.text, password: pass.text);
        } else {
          CustomToaster.showWarning(
              context, "Something went wrong. All fields are required.");
        }
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: colors,
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.5),
        width: double.infinity,
        child: Text(
          "Login",
          style: CustomStyleswhite.headerTextStyle,
        ),
      ),
    );
  }
}
