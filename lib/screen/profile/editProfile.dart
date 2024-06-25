import 'package:winner11/screen/component/coundown.dart';
import 'package:winner11/screen/component/darkmode.dart';
import 'package:winner11/screen/profile/profile.dart';
import 'package:winner11/screen/profile/profile_model.dart';
import 'package:get/get.dart';

import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:winner11/screen/component/custom_toaster.dart';
import 'package:winner11/screen/header/appbar.dart';
import 'package:winner11/screen/header/headerTop.dart';
import 'package:winner11/service/authapi.dart';
import 'package:winner11/utilis/AllColor.dart';
import 'package:winner11/utilis/boxSpace.dart';
import 'package:winner11/utilis/fontstyle.dart';
import 'package:winner11/utilis/globlemargin.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../component/profileContainer.dart';
  var dataProfile;
class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final dynamic data = Get.arguments as dynamic;


  final formKey = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  // bank deatail
  TextEditingController bankNameController = TextEditingController();
  TextEditingController bankAccountController = TextEditingController();

  TextEditingController ifscCodeController = TextEditingController();

  void dispose() {
    nameController.dispose();
    emailController.dispose();
    // Dispose other controllers

//bank

    bankNameController.dispose();
    bankAccountController.dispose();
    ifscCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mQ = MediaQuery.of(context).size;
    if (data != null) {
      UserDetails userDetails = UserDetails.fromJson(data);

      return Scaffold(
        appBar: CustomAppBar(title: "Edit Profile "),
        body: SingleChildScrollView(
          child: Container(
            margin: GlobleglobleMargin.globleMargin,
            child: Column(
              children: [
                Form(
                  key: formKey,
                  child: Container(
                    height: 600,
                    child: Column(
                      children: [
                        size20h,
                        size20h,
                        Simpletitlebtn(
                          HeadName: "Edit Profile",
                        ),

                        size20h,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              color: myColorRed,
                              child: Text(
                                "User Details",
                                style: CustomStyleswhite.header2TextStyle,
                              ),
                            )
                          ],
                        ),

                        MyFunctionInput(
                          controller: nameController,
                          fieldName: userDetails.name == "No Name"
                              ? "Name"
                              : userDetails.name,
                          hintText: "Your Name",
                          inputType: TextInputType.text,
                          errorMessage: "Please enter your Name",
                          usernameRegex:
                              r"^[A-Za-z\s]{1,}$", // Adjust the regex for name validation
                        ),

                      
                        size20h,
                        MyFunctionInput(
                          controller: emailController,
                          fieldName: userDetails.email == "No Email"
                              ? "Email"
                              : userDetails.email,
                          hintText: "example@example.com",
                          inputType: TextInputType.emailAddress,
                          errorMessage: "Please enter a valid email",
                          usernameRegex:
                              r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$',
                        ),

                        //Bnak Deatial
                        size20h,

                        ElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              callApi(
                                context: context,
                                nameController: nameController,
                                emailController: emailController,
                            
                              );

                              
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                myColorgreen, // Set the button background color to green
                          ),
                          child: Text(
                            ' User Details Save',
                            style: CustomStyleswhite.headerTextStyle,
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
    } else {
      return Text("data");
    }
  }


callApi({
  context,
TextEditingController?  nameController,
  TextEditingController? emailController,
 
}) async {
  ApiService apiService = ApiService();
  final store = await SharedPreferences.getInstance();
  var id = store.getString("userId");

  var editData = {
    "id": id.toString(),
    "name": nameController!.text,
    "email": emailController!.text,
  };


   var result = await apiService.userallType(
    uri: "/user_update_profile",
    data: editData,
  );

  // Update the widget state inside setState
  setState(() {
    dataProfile = result;
  });

 
  //    setState(()  async {
  //                dataProfile = await  apiService.userallType(
  //   uri: "/user_update_profile",
  //   data: editData,
  // );
  //      });
 
  
if(!nameController.text.isEmpty && !emailController.text.isEmpty){

    if (dataProfile != "nodata") {
    CustomToaster.showSuccess(context, dataProfile["data"]["message"]);


  } else {
    CustomToaster.showWarning(context, dataProfile["data"]["message"]);
  }
}else{
    CustomToaster.showWarning(context, dataProfile["data"]["message"]);

}


}


}
