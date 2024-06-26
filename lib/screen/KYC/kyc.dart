import 'dart:io';

import 'package:winner11/screen/component/custom_toaster.dart';
import 'package:winner11/screen/component/darkmode.dart';

import 'package:winner11/screen/header/appbar.dart';

import 'package:winner11/utilis/AllColor.dart';
import 'package:winner11/utilis/borderbox.dart';
import 'package:winner11/utilis/boxSpace.dart';
import 'package:winner11/utilis/fontstyle.dart';
import 'package:winner11/utilis/globlemargin.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../component/imageComponet.dart';
import '../header/headerTop.dart';

// other imports...
final ThemeController themeController = Get.put(ThemeController());

class KYCController extends GetxController {

  final formKey = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  final RxBool isLoading = true.obs;
  final Rx<File?> adharImage = Rx<File?>(null);
  final Rx<File?> panImage = Rx<File?>(null);
  var myid;
  var dataStatusCheck;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    storeId();
    demoStatusCheck();
  }

  storeId() async {
    final store = await SharedPreferences.getInstance();
    myid = store.getString('userId');
  }

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
   

  }

Future<void> submitForm2() async {
 
}

  Future demoStatusCheck() async {

  }
}

class KYC extends StatefulWidget {
  @override
  State<KYC> createState() => _KYCState();
}

class _KYCState extends State<KYC> {
  final KYCController kycController = Get.put(KYCController());

  

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
       

        setState(() {});
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

 Builder(
      builder: (BuildContext context) {
        switch (kycController.dataStatusCheck) {
          case "approved":
            return  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: myColorgreen,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.5),
                    width: double.infinity,
                    child: Icon(
              Icons.check,
              color: Colors.black,
            )
                  );
          case "waiting":
            return         Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: myColorgreen,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.5),
                    width: double.infinity,
                    child:    const Icon(
                  Icons.access_time,
                  color: Colors.orange,
                ),
                  );
         
          default:
            return _buildSubmitButton();
        }
      },
    ),
 

                        
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
    Builder(
      builder: (BuildContext context) {
        switch (kycController.dataStatusCheck) {
          case "approved":
            return  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: myColorgreen,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.5),
                    width: double.infinity,
                    child: Icon(
              Icons.check,
              color: Colors.black,
            )
                  );
          case "waiting":
            return         Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: myColorgreen,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.5),
                    width: double.infinity,
                    child:    const Icon(
                  Icons.access_time,
                  color: Colors.orange,
                ),
                  );
         
          default:
            return _buildSubmitButton2();
        }
      },
    ),
  ],
),
                  ),
                ),
                Divider(),
                Column(
                  children: [
                    size10h,
                    Obx(
                      () => Container(
                        decoration: BoxDecoration(
                          border: border,
                          borderRadius: boRadiusAll,
                          color: themeController.isLightMode.value
                              ? myColorWhite
                              : myColor,
                          boxShadow: [
                            themeController.isLightMode.value
                                ? boxdark
                                : boxshadow2
                          ],
                        ),
                        child:             Container(
                                        margin: GlobleglobleMargin.Margin10V,
                                        width: double.infinity,
                                        height: 100,
                                        padding: EdgeInsets.all(10),
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                "https://winners11.in/"),
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      )
                           
                      ),
                    ),
                    size10h,
                    Obx(
                      () => Container(
                        decoration: BoxDecoration(
                          border: border,
                          borderRadius: boRadiusAll,
                          color: themeController.isLightMode.value
                              ? myColorWhite
                              : myColor,
                          boxShadow: [
                            themeController.isLightMode.value
                                ? boxdark
                                : boxshadow2
                          ],
                        ),
                        child:   Container(
                                        margin: GlobleglobleMargin.Margin10V,
                                        width: double.infinity,
                                        height: 100,
                                        padding: EdgeInsets.all(10),
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                "https://winners11.in"),
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      )
                                
                      ),
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
        return Obx(
          () => Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: border,
              borderRadius: boRadiusAll,
              color: themeController.isLightMode.value ? myColorWhite : myColor,
              boxShadow: [
                themeController.isLightMode.value ? boxdark : boxshadow2
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  // Wrap the content in a Stack
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
          ),
        );
      },
    );
  }

  Widget _buildAdharImageField() {
    return GetBuilder<KYCController>(
      builder: (controller) {
        return Obx(
          () => Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: border,
              borderRadius: boRadiusAll,
              color: themeController.isLightMode.value ? myColorWhite : myColor,
              boxShadow: [
                themeController.isLightMode.value ? boxdark : boxshadow2
              ],
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
