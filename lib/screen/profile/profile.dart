import 'dart:io';

import 'package:winner11/screen/component/coundown.dart';
import 'package:winner11/screen/component/custom_toaster.dart';

import 'package:winner11/screen/profile/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winner11/screen/component/imageComponet.dart';
import 'package:winner11/screen/header/appbar.dart';
import 'package:winner11/service/authapi.dart';
import 'package:winner11/utilis/AllColor.dart';
import 'package:winner11/utilis/borderbox.dart';
import 'package:winner11/utilis/boxSpace.dart';

import 'package:winner11/utilis/fontstyle.dart';
import 'package:winner11/utilis/globlemargin.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowProfile extends StatefulWidget {
  static const routeName = "showProfile";

  const ShowProfile({Key? key}) : super(key: key);

  @override
  State<ShowProfile> createState() => _ShowProfileState();
}

class _ShowProfileState extends State<ShowProfile> {
  File? pickedFile;
  bool _isLoading = true;

  ApiService apiService = ApiService();
Future<void> handlePickedImage() async {
  final pickedFile1 =
      await ImagePicker().pickImage(source: ImageSource.gallery);
  final store = await SharedPreferences.getInstance();
  var id = store.getString('userId');
    
  if (pickedFile1 != null) {
    if (_isLoading) {
      // ignore: use_build_context_synchronously
      CustomToaster.showLoding(context, "Processing....");
    }

    const url = "/user_img_upload";
    pickedFile = File(pickedFile1.path);

    var result = await apiService.userImageUpload(
      panImage: pickedFile!,
      id: id!,
      url: url,
    );

    _isLoading = false; // Move this line outside of the if (_isLoading) check

    if (result == "not-ok") {

      // ignore: use_build_context_synchronously
      CustomToaster.showWarning(context, "Image upload $result");
      Get.offAllNamed("/home", arguments:id);
    } else {
      CustomToaster.showSuccess(context, "Image successfully uploaded: $result");
      // No need to call _isLoading = false; here, as it is already done outside the if (_isLoading) check
      Get.offAllNamed("/home", arguments:id);
    }
  }
}

  Future<void> _refreshProfile() async {
    setState(() {/* update state */});
  }

  Widget buildUserDetails(UserDetails userDetails) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 90),
          color: myColorRed,
          child: Row(
            children: <Widget>[
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(20.0),
                    child: CircleAvatar(
                      radius: 30.0,
                      backgroundImage: NetworkImage(
                          "https://winners11.in/images/${userDetails.image}"),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(userDetails.name,
                      style: CustomStyleswhite.headerTextStyle),
                  Text(userDetails.phone.toString(),
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: CustomStyleswhite.header2TextStyle),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final ApiService apiService = ApiService();
    double fem = MediaQuery.of(context).size.width / 390;
    final dynamic data = Get.arguments as dynamic;

    if (data != null) {
      UserDetails userDetails = UserDetails.fromJson(data);

      return RefreshIndicator(
        onRefresh: _refreshProfile,
        child: Scaffold(
          appBar: CustomAppBar(title: "Profile"),
          body: SingleChildScrollView(
            child: Container(
              margin: GlobleglobleMargin.globleMargin,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(' Profile Details  ',
                            textAlign: TextAlign.center,
                            style: CustomStyles.header2TextStyle),
                      ),
                    ],
                  ),
                  size20h,
                  Container(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      children: [
                        Align(
                          child: Stack(
                            children: [
                              SizedBox(
                                width: 120 * fem,
                                height: 120 * fem,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: ClipOval(
                                    child: pickedFile == null
                                        ? Image.network(
                                            "https://winners11.in/images/${userDetails.image}",
                                            fit: BoxFit.cover,
                                          )
                                        : Image.file(
                                            pickedFile!,
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () async {
                                    await handlePickedImage();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        size20w,
                        Container(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  userDetails.name,
                                  style: CustomStyles.textExternel,
                                ),
                              ]),
                        ),
                      ],
                    ),
                  ),
                  size20h,
               
                  Container(
                    margin: GlobleglobleMargin.Margin10V,
                    width: double.infinity,
                    height: 180,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: boRadius5,
                      border: Border.all(color: myColorRed),
                    ),
                    child: Column(
                       
                        children: [
                          Container(
                            width: double.infinity,
                            child: Stack(
                              children: [
                                Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        color: myColorRed,
                                        child: Text(
                                          "User Details",
                                          style:
                                              CustomStyleswhite.header2TextStyle,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Positioned(
                               
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.toNamed("/editProfile",
                                          arguments: data);
                                    },
                                    child: SizedBox(
                                      width: 39,
                                      height: 39,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: boRadius5,
                                          color: myColorRed,
                                        ),
                                        child: Icon(
                                          Icons.edit,
                                          color: myColorWhite,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          size20h,
                               Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Name",
                                style: CustomStyles.header2TextStyle,
                              ),
                              Text(userDetails.name.toString(),
                                  style: CustomStyles.textExternel)
                            ],
                          ),
                        
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Phone",
                                style: CustomStyles.header2TextStyle,
                              ),
                              Text(userDetails.phone.toString(),
                                  style: CustomStyles.textExternel)
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Email",
                                  style: CustomStyles.header2TextStyle),
                              Text(userDetails.email,
                                  style: CustomStyles.textExternel)
                            ],
                          )
                        ]),
                  ),
                  size10h,
                  Divider(),
                  size10h,
                  Container(
                    margin: GlobleglobleMargin.Margin10V,
                    width: double.infinity,
                    height: 150,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: boRadius5,
                      border: Border.all(color: myColorRed),
                    ),
                    child: Column(children: [
                   Container(
                            width: double.infinity,
                            child: Stack(
                              children: [
                                Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        color: myColorRed,
                                        child: Text(
                                          "Bank Details",
                                          style:
                                              CustomStyleswhite.header2TextStyle,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Positioned(
                               
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.toNamed("/bank",
                                          arguments: data);
                                    },
                                    child: SizedBox(
                                      width: 39,
                                      height: 39,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: boRadius5,
                                          color: myColorRed,
                                        ),
                                        child: Icon(
                                          Icons.edit,
                                          color: myColorWhite,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                            size20h,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Bank Name",
                            style: CustomStyles.header2TextStyle,
                          ),
                          Text(userDetails.bankName,
                              style: CustomStyles.textExternel)
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Bank Account Number",
                              style: CustomStyles.header2TextStyle),
                          Text(userDetails.accountNo,
                              style: CustomStyles.textExternel)
                        ],
                      )
                    ]),
                  ),
                  size10h,
                  Divider(),
                
                       Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        color: myColorRed,
                                        child: Text(
                                          textAlign:TextAlign.center,
                                          "Update your KYC document with amount details",
                                          style:
                                              CustomStyleswhite.smallTextStyle,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                  InkWell(
                    onTap: () {
                      Get.toNamed("/kyc");
                    },
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: kycItems.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.all(5),
                          margin: GlobleglobleMargin.Margin10V,
                          width: double.infinity,
                          height: 70,
                          decoration: BoxDecoration(
                            borderRadius: boRadius5,
                            border: Border.all(color: myColorRed),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ImageComponent(
                                myImage: kycItems[index].imagePath,
                                myheight: 40.0,
                                myWidth: 40.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(kycItems[index].title),
                                  Text(kycItems[index].subtitle),
                                ],
                              ),
                              Container(
                                child: FutureBuilder(
                                  future: apiService.userAllDoc(
                                    data: {},
                                    uri: "/kyc_user_status_check",
                                  ),
                                  builder: (context, snapshort) {
                                    if (snapshort.connectionState ==
                                        ConnectionState.done) {
                                      if (snapshort.hasError) {
                                        return Text(
                                            'Error: ${snapshort.error}');
                                      }

                                      final data = (snapshort.data
                                          as Map<String, dynamic>);

                                      if (data != null) {
                                        final result = data['data']['result'];
                                        final panApproval =
                                            result['pan_approval'].toString();

                                        switch (panApproval) {
                                          case "approved":
                                            return Row(
                                              children: [
                                                Icon(
                                                  Icons.check,
                                                  color: Colors.green,
                                                ),
                                              ],
                                            );
                                          case "waiting":
                                            return Row(
                                              children: [
                                                Icon(
                                                  Icons.access_time,
                                                  color: Colors.orange,
                                                ),
                                              ],
                                            );
                                          default:
                                            return Row(
                                              children: [
                                                Icon(
                                                  Icons.cancel,
                                                  color: Colors.red,
                                                ),
                                              ],
                                            );
                                        }
                                      } else {
                                        return Text('No match data available');
                                      }
                                    } else if (snapshort.connectionState ==
                                        ConnectionState.waiting) {
                                      return CircularProgressIndicator();
                                    } else {
                                      return Text(
                                          'Data retrieval is not in progress');
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }
  }
}

class CircleIcon extends StatelessWidget {
  var myIcon;

  CircleIcon(this.myIcon);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color.fromARGB(255, 255, 203, 59),
      ),
      child: Icon(myIcon, color: Colors.white),
    );
  }
}

//objcet
class KYCItem {
  final String imagePath;
  final String title;
  final String subtitle;
  final bool isVerified;

  KYCItem({
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.isVerified,
  });
}
// list kyc

List<KYCItem> kycItems = [
  KYCItem(
    imagePath: 'assets/adhar.png',
    title: 'Aadhar Verification',
    subtitle: 'Verify your Aadhar card',
    isVerified: true, // Change to false if not verified
  ),
  KYCItem(
    imagePath: 'assets/pancard.png',
    title: 'PAN Verification',
    subtitle: 'Verify your PAN card',
    isVerified: true, // Change to false if not verified
  ),
];
