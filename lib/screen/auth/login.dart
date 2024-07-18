import 'package:Billa/routes/Api.dart';
import 'package:Billa/screen/auth/forget.dart';
import 'package:Billa/screen/tap1/upcomming.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:Billa/screen/auth/controller/authController.dart';
import 'package:Billa/screen/auth/singup.dart';
import 'package:Billa/utilis/alinement.dart';
import 'package:Billa/utilis/boxSpace.dart';
import 'package:Billa/utilis/fontstyle.dart';
import 'package:Billa/utilis/globlemargin.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../utilis/AllColor.dart';
import '../component/custom_toaster.dart';
import '../controller/MyHomePage_controller.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final SignupController loginController = Get.put(SignupController());
  final MyHomePageController controller = Get.put(MyHomePageController());

  var code = "";
  final themeSMS = Get.put(SmsController());
  TextEditingController phoneController = TextEditingController();

  TextEditingController pass = TextEditingController();
  final formKey = GlobalKey<FormState>();
  RegExp digitValidator = RegExp("[0-9]+");
  bool isANumber = true;
  bool isPasswordVisible = false; // Move this variable to the class level

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
          margin: EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // TopHeaderPopup(),
                SizedBox(height: 20),
                SizedBox(height: 20),
                SizedBox(height: 20),
                SizedBox(height: 20),
                SizedBox(height: 20),
                SizedBox(height: 20),
                SizedBox(height: 20),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Login up on Billa App",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        )),
                    SizedBox(height: 10),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: phoneController,
                      decoration: InputDecoration(labelText: 'Mobile'),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(
                            10), // Limits the length to 10 digits
                        FilteringTextInputFormatter
                            .digitsOnly, // Allows only digits
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your mobile number';
                        }
                        // Regex pattern for 10-digit mobile number
                        String pattern = r'^[0-9]{10}$';
                        RegExp regex = RegExp(pattern);
                        if (!regex.hasMatch(value)) {
                          return 'Please enter a valid 10-digit mobile number';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'OpenSans',
                      ),
                      decoration: InputDecoration(
                        errorText: 'Please enter a Password',
                        contentPadding: EdgeInsets.only(top: 14.0),
                        suffix: IconButton(
                          icon: Icon(
                            isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        hintText: 'Enter your Password',
                      ),
                      controller: pass,
                      obscureText: !isPasswordVisible,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a Password';
                        }
                        return null;
                      },
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(ForgotPasswordScreen());
                      },
                      child: const Center(
                        child: Text("Forget pin"),
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(height: 10),
                    loginController.isLoading.value
                        ? const CircularProgressIndicator(
                            color: Colors.red,
                          )
                        : _buildLoginBtn(
                            context: context,
                            phController: phoneController,
                            pass: pass,
                            colors: Colors.red,
                          ),
                    SizedBox(height: 10),
                    Center(
                      child: customImageContainer(
                        context: context,
                        imageUrl: 'assets/wh.jpg',
                        onTap: openWhatsApp,
                        name: "Whatsapp",
                        imageSize: 50,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('You do not have an account?'),
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

  Future<void> openWhatsApp() async {

    print("--------------------${controller?.dataModel!.contactDetails.whatsappNo}");
   
    final whatsappUrl = 'https://wa.me/${controller?.dataModel!.contactDetails.mobileNo1}';
;

    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      throw 'Could not launch $whatsappUrl';
    }
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
