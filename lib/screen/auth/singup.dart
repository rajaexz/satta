import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:winner11/screen/auth/controller/authController.dart';
import 'package:winner11/screen/auth/login.dart';
import 'package:winner11/utilis/fontstyle.dart';
import 'package:winner11/utilis/globlemargin.dart';
import '../../utilis/AllColor.dart';
import '../../utilis/alinement.dart';
import '../../utilis/boxSpace.dart';

class SignupPage extends StatelessWidget {
  final SignupController signupController = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: 900,
          margin: GlobleglobleMargin.globleMargin,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              size20h,
              size20h,
              size20h,
              size20h,
              size20h,
              Column(
                crossAxisAlignment: AlignmentStartCross,
                children: [
                  Text("Sign up on SATTA App",
                      style: CustomStyles.headerTextStyle),
                  size10h,
                  Text("Get 50 Coins on  Sign up",
                      style: CustomStyles.smallTextStyle),
                ],
              ),
              Form(
                key: signupController.formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: signupController.fullNameController,
                        decoration: InputDecoration(labelText: 'Full Name'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your full name';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: signupController.mobileController,
                        decoration: InputDecoration(labelText: 'Mobile'),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your mobile number';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: signupController.passwordController,
                        decoration: InputDecoration(labelText: 'Password'),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          if (signupController.formKey.currentState!
                              .validate()) {
                            signupController.signup();
                          } else {}
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: myColorRed,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20))),
                          padding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 20.5),
                          width: double.infinity,
                          child: Text(
                            'Signup',
                            style: CustomStyleswhite.headerTextStyle,
                          ),
                        ),
                      ),
                      Obx(() {
                        if (signupController.isLoading.value) {
                          return CircularProgressIndicator();
                        } else {
                          return Container();
                        }
                      }),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Already have an account? '),
                          TextButton(
                            onPressed: () {
                              Get.to(() => Loginpage());
                            },
                            child: Text('Login'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
