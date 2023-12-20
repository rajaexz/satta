
import 'dart:io';

import 'package:winner11/screen/component/custom_toaster.dart';
import 'package:winner11/screen/component/darkmode.dart';
import 'package:winner11/screen/component/shimmer.dart';
import 'package:winner11/screen/header/appbar.dart';
import 'package:winner11/service/authapi.dart';
import 'package:winner11/utilis/AllColor.dart';
import 'package:winner11/utilis/borderbox.dart';
import 'package:winner11/utilis/boxSpace.dart';
import 'package:winner11/utilis/fontstyle.dart';
import 'package:winner11/utilis/globlemargin.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../component/imageComponet.dart';
import '../header/headerTop.dart';
// other imports...
   final ThemeController themeController = Get.put(ThemeController());
class KYCController extends GetxController {
  final ApiService apiService = ApiService();
  final formKey = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  final RxBool isLoading = true.obs;
  final Rx<File?> adharImage = Rx<File?>(null);
  final Rx<File?> panImage = Rx<File?>(null);

  void pickPanImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    panImage.value = pickedFile == null ? null : File(pickedFile.path);
  }

  void pickAdharImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    adharImage.value = pickedFile == null ? null : File(pickedFile.path);
  }

  Future<void> submitForm() async {
   
    if (formKey.currentState!.validate()) {
      if (panImage.value == null) {
        isLoading.value = false;
        CustomToaster.showWarning(
            Get.context!, "Please provide the Pan Card image");
      } else {
        final store = await SharedPreferences.getInstance();
        var id = store.getString('userId');

        var dataPan = await apiService.userImageUpload(
          panImage: panImage.value!,
          id: id!,
          url: "/kyc_pan_user",
        );

        if (dataPan == "not-ok") {
          isLoading.value = false;
          CustomToaster.showWarning(Get.context!, "Invalid Pan Document");
        } else {
          isLoading.value = false;
          Get.snackbar("$dataPan", "",
              snackPosition: SnackPosition.TOP, backgroundColor: themeController.isLightMode.value ? myColorWhite : myColor);
        }
      }
    }
  }

  Future<void> submitForm2() async {
    // if (isLoading.value) {
    //   CustomToaster.showWarning(Get.context!, 'Processing...');
    //   return;
    // }

    if (formKey2.currentState!.validate()) {
      if (adharImage.value == null) {
        isLoading.value = false;
        CustomToaster.showWarning(
            Get.context!, "Please provide the Aadhar Card image");
      } else {
        final store = await SharedPreferences.getInstance();
        var id = store.getString('userId');

        final dataAadhar = await apiService.userImageUpload(
          panImage: adharImage.value!,
          id: id!,
          url: "/kyc_addhar_user",
        );

        if (dataAadhar == "not-ok") {
          isLoading.value = false;
          CustomToaster.showWarning(Get.context!, "Invalid Aadhar Document");
        } else {
          isLoading.value = false;
          Get.snackbar("", "$dataAadhar",
              snackPosition: SnackPosition.TOP, backgroundColor:  themeController.isLightMode.value ? myColorWhite : myColor);
        }
      }
    }
  }
}

class KYC extends StatefulWidget {
  @override
  State<KYC> createState() => _KYCState();
}

class _KYCState extends State<KYC> {
  final KYCController kycController = Get.put(KYCController());

  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
         onRefresh: () async {
await  apiService.userAllDoc(uri: '/kyc_pan_user_get');

            setState(() {
              
            });
          },
      child: Scaffold(
        appBar: CustomAppBar(title: "KYC"),
        body: SingleChildScrollView(
          child: Container(
            margin: GlobleglobleMargin.globleMargin,
            child: Column(
              children: [
                // your existing UI code...
          
                Form(
                  key: kycController.formKey,
                  child: Container(
                    margin: GlobleglobleMargin.globleMargin,
                    child: Column(
                      children: [
                        size20h,
                        Simpletitlebtn(HeadName: "Edit Your KYC"),
                        size20h,
                        _buildPanImageField(),
                        size20h,
                        _buildSubmitButton(),
                      ],
                    ),
                  ),
                ),
                Form(
                  key: kycController.formKey2,
                  child: Container(
                    margin: GlobleglobleMargin.globleMargin,
                    child: Column(
                      children: [
                        size20h,
                        _buildAdharImageField(),
                        size20h,
                        _buildSubmitButton2(),
                      ],
                    ),
                  ),
                ),
          Divider(),
                Column(
                  children: [
                    size10h,
                    FutureBuilder(
                      future: apiService.userAllDoc(uri: '/kyc_pan_user_get'),
                      builder: (context, snapshot) {
                          try {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          }
          
                          final data = (snapshot.data
                              as Map<String, dynamic>)["data"]?["result"]?[0];
                          final panImg = data?["pan_img"];
          
                          return Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: borderRed,
                            ),
                            child:  panImg != null ?Container(
                              margin: GlobleglobleMargin.Margin10V,
                              width: double.infinity,
                              height: 100,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                      "https://winners11.in/images/$panImg"),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ) :   Center(child: ImageComponent(
                                  myImage: 'assets/pancard.png',
                                  myheight: 100.0,
                                  myWidth: 100.0,
                                ),) 
                          );
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator(); // Display a loading indicator
                        } else {
                          return Text('Data retrieval is not in progress');
                        }
                          } catch (e) {
              return summer2; // Handle errors within the try-catch block
            }
                      },
                    ),
                    size10h,
                    FutureBuilder(
                      future: apiService.userAllDoc(uri: '/kyc_addhar_user_get'),
                      builder: (context, snapshot) {
                        try {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          }
          
                          final data = (snapshot.data
                              as Map<String, dynamic>)["data"]?["result"]?[0];
                          final panImg = data?["pan_img"];
                          final addharImg = data["addhar_img"];
                          return Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: borderRed,
                            ),
                            child: addharImg != null ? Container(
                              margin: GlobleglobleMargin.Margin10V,
                              width: double.infinity,
                              height: 100,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                      "https://winners11.in/images/$addharImg"),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ):   Center(child:  ImageComponent(
                              
                                  myImage: 'assets/adhar.png',
                                  myheight: 100.0,
                                  myWidth: 100.0,
                                ),)
                          );
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator(); // Display a loading indicator
                        } else {
                          return Text('Data retrieval is not in progress');
                        }
                          } catch (e) {
              return summer2; // Handle errors within the try-catch block
            }
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
Widget _buildPanImageField() {
  return GetBuilder<KYCController>(
    builder: (controller) {
      return Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: borderRed,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack( // Wrap the content in a Stack
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(
                      () {
                        final panImage = controller.panImage.value;
                        return panImage != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: panImage == null
                                      ? Container(
                                          width: 300,
                                          height: 15,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  "https://winners11.in/images/$panImage"),
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        )
                                      : Image.file(
                                          panImage,
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              )
                            : ImageComponent(
                                myImage: 'assets/pancard.png',
                                myheight: 40.0,
                                myWidth: 40.0,
                              );
                      },
                    ),
                    Row(
                      children: [
                        // Move Positioned widget inside the Stack
                      ],
                    ),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: controller.pickPanImage,
                  ),
                ),
              ],
            ),
            Text("Pan card Update"),
          ],
        ),
      );
    },
  );
}
Widget _buildAdharImageField() {
  return GetBuilder<KYCController>(
    builder: (controller) {
      return Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: borderRed,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(
                      () {
                        final adharImage = controller.adharImage.value;
                        return adharImage != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: adharImage == null
                                      ? Container(
                                          width: 300,
                                          height: 15,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                "https://winners11.in/images/$adharImage",
                                              ),
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        )
                                      : Image.file(
                                          adharImage,
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              )
                            : ImageComponent(
                                myImage: 'assets/adhar.png',
                                myheight: 40.0,
                                myWidth: 40.0,
                              );
                      },
                    ),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: controller.pickAdharImage,
                  ),
                ),
              ],
            ),
            Text("Aadhar card Update"),
          ],
        ),
      );
    },
  );
}

  Widget _buildSubmitButton() {
    return InkWell(
      onTap: kycController.submitForm,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: myColorgreen,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.5),
        width: double.infinity,
        child: Text('Pan Submit', style: CustomStyleswhite.header2TextStyle),
      ),
    );
  }

  Widget _buildSubmitButton2() {
    return InkWell(
      onTap: kycController.submitForm2,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: myColorgreen,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.5),
        width: double.infinity,
        child: Text('Aadhar Submit', style: CustomStyleswhite.header2TextStyle),
      ),
    );
  }
}
