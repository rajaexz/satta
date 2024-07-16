import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:Billa/screen/profile/controller/editcontroller.dart';
import 'package:Billa/utilis/AllColor.dart';

class EditProfilePage extends StatelessWidget {
  final ProfileController _controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Edit Profile")),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Form(
                key: _controller.formKey,
                child: Container(
                  height: 600,
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      const SizedBox(height: 20),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _controller.nameController,
                        decoration: const InputDecoration(
                          labelText: "Name",
                          hintText: "Your Name",
                        ),
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your Name";
                          }
                          if (!RegExp(r"^[A-Za-z\s]{1,}$").hasMatch(value)) {
                            return "Please enter a valid name";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _controller.emailController,
                        decoration: const InputDecoration(
                          labelText: "Email",
                          hintText: "example@example.com",
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter a valid email";
                          }
                          if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
                              .hasMatch(value)) {
                            return "Please enter a valid email";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _controller.updateProfile,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        child: const Text(
                          'Save User Details',
                          style: TextStyle(color: Colors.white),
                        ),
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
