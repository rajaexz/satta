import 'package:winner11/screen/profile/controller/profile_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winner11/screen/header/appbar.dart';
import 'package:winner11/screen/profile/editProfile.dart';
import 'package:winner11/utilis/AllColor.dart';

import '../../main.dart';
import '../../utilis/borderbox.dart';
import '../../utilis/boxSpace.dart';
import '../../utilis/fontstyle.dart';

//   final ThemeController themeController = Get.put(ThemeController());
// class ShowProfile extends StatefulWidget {
//   static const routeName = "showProfile";

//   const ShowProfile({Key? key}) : super(key: key);

//   @override
//   State<ShowProfile> createState() => _ShowProfileState();
// }

// class _ShowProfileState extends State<ShowProfile> {
//   File? pickedFile;
//   bool _isLoading = true;

// Future<void> handlePickedImage() async {
//   final pickedFile1 =
//       await ImagePicker().pickImage(source: ImageSource.gallery);
//   final store = await SharedPreferences.getInstance();
//   var id = store.getString('userId');

//   if (pickedFile1 != null) {
//     if (_isLoading) {
//       // ignore: use_build_context_synchronously
//       CustomToaster.showLoding(context, "Processing....");
//     }

//     const url = "/user_img_upload";
//     pickedFile = File(pickedFile1.path);

//     var result = "";

//     _isLoading = false; // Move this line outside of the if (_isLoading) check

//     if (result == "not-ok") {

//       // ignore: use_build_context_synchronously
//       CustomToaster.showWarning(context, "Image upload $result");
//       Get.offAllNamed("/home", arguments:id);
//     } else {
//       // ignore: use_build_context_synchronously
//       CustomToaster.showSuccess(context, "Image successfully uploaded: $result");
//       // No need to call _isLoading = false; here, as it is already done outside the if (_isLoading) check
//       Get.offAllNamed("/home", arguments:id);
//     }
//   }
// }

//   Future<void> _refreshProfile() async {
//     setState(() {/* update state */});
//   }

//   Widget buildUserDetails(UserDetails userDetails) {
//     return Column(
//       children: [
//         Container(
//           padding: EdgeInsets.only(top: 90),
//           color: myColorRed,
//           child: Row(
//             children: <Widget>[
//               Column(
//                 children: [
//                   Container(
//                     margin: const EdgeInsets.all(20.0),
//                     child: const CircleAvatar(f
//                       radius: 30.0,
//                       backgroundImage: AssetImage(
//                           "assets/logo.jpeg"),
//                     ),
//                   ),
//                 ],
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(userDetails.name,
//                       style: CustomStyleswhite.headerTextStyle),
//                   Text(userDetails.phone.toString(),
//                       softWrap: true,
//                       overflow: TextOverflow.ellipsis,
//                       style: CustomStyleswhite.header2TextStyle),
//                 ],
//               )
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {

//     double fem = MediaQuery.of(context).size.width / 390;
//     final dynamic data = Get.arguments as dynamic;

//       return RefreshIndicator(
//         onRefresh: _refreshProfile,
//         child: Scaffold(
//           appBar: CustomAppBar(title: "Profile"),
//           body: SingleChildScrollView(
//             child: Container(
//               margin: GlobleglobleMargin.globleMargin,
//               width: double.infinity,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Container(
//                         child: Text(' Profile Details  ',
//                             textAlign: TextAlign.center,
//                             style: CustomStyles.header2TextStyle),
//                       ),
//                     ],
//                   ),
//                   size20h,
//                    Obx(
//                     ()=>
//                   Container(

//                           decoration: BoxDecoration(
//                      border:border,
//                      borderRadius:boRadiusAll ,
//                              color: themeController.isLightMode.value
//                                   ? myColorWhite
//                                   : myColor,
//                       boxShadow: [  themeController.isLightMode.value
//                                           ? boxdark
//                                           : boxshadow2 ],
//                     ),
//                       padding: EdgeInsets.only(left: 20, right: 20, bottom: 10,top: 10),
//                       child: Column(
//                         children: [
//                           Align(
//                             child: Stack(
//                               children: [
//                                 SizedBox(
//                                   width: 120 * fem,
//                                   height: 120 * fem,
//                                   child: Container(
//                                     decoration: const BoxDecoration(
//                                       shape: BoxShape.circle,
//                                     ),
//                                     child: ClipOval(
//                                       child: pickedFile == null
//                                           ? Image.asset(
//                                               "assets/logo.jpeg",
//                                               fit: BoxFit.cover,
//                                             )
//                                           : Image.file(
//                                               pickedFile!,
//                                               fit: BoxFit.cover,
//                                             ),
//                                     ),
//                                   ),
//                                 ),
//                                 Positioned(
//                                   bottom: 0,
//                                   right: 0,
//                                   child: IconButton(
//                                     icon: Icon(Icons.edit),
//                                     onPressed: () async {
//                                       await handlePickedImage();
//                                     },
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           size20w,
//                           Container(
//                             child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Text(
//                                     "Raja ",
//                                     style: CustomStyles.textExternel,
//                                   ),
//                                 ]),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   size20h,

//                   Obx(
//                     ()=> Container(
//                       margin: GlobleglobleMargin.Margin10V,
//                       width: double.infinity,
//                       height: 180,
//                       padding: EdgeInsets.all(10),

//                           decoration: BoxDecoration(
//                     border: border,
//                        borderRadius:boRadiusAll ,
//                              color: themeController.isLightMode.value
//                                   ? myColorWhite
//                                   : myColor,
//                       boxShadow: [  themeController.isLightMode.value
//                                           ? boxdark
//                                           : boxshadow2 ],
//                     ),
//                       child: Column(

//                           children: [
//                             Container(
//                               width: double.infinity,
//                               child: Stack(
//                                 children: [
//                                   Center(
//                                     child: Column(
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       children: [
//                                         Container(
//                                           padding: EdgeInsets.all(10),
//                                           color: myColorRed,
//                                           child: Text(
//                                             "User Details",
//                                             style:
//                                                 CustomStyleswhite.header2TextStyle,
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                   Positioned(

//                                     right: 0,
//                                     child: GestureDetector(
//                                       onTap: () {
//                                         Get.toNamed("/editProfile",
//                                             arguments: data);
//                                       },
//                                       child: SizedBox(
//                                         width: 39,
//                                         height: 39,
//                                         child: Container(
//                                           decoration: BoxDecoration(
//                                             borderRadius: boRadius5,
//                                             color: myColorRed,
//                                           ),
//                                           child: Icon(
//                                             Icons.edit,
//                                             color: myColorWhite,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),

//                             size20h,
//                                  Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   "Name",
//                                   style: CustomStyles.header2TextStyle,
//                                 ),
//                                 Text("Raja",
//                                     style: CustomStyles.textExternel)
//                               ],
//                             ),

//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   "Phone",
//                                   style: CustomStyles.header2TextStyle,
//                                 ),
//                                 Text("7011448878",
//                                     style: CustomStyles.textExternel)
//                               ],
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text("Email",
//                                     style: CustomStyles.header2TextStyle),
//                                 Text("Rajahalder@gmail.com",
//                                     style: CustomStyles.textExternel)
//                               ],
//                             )
//                           ]),
//                     ),
//                   ),
//                   size10h,

//                   Obx(
//                     ()=> Container(
//                       margin: GlobleglobleMargin.Margin10V,
//                       width: double.infinity,
//                       height: 150,
//                       padding: EdgeInsets.all(10),

//                             decoration: BoxDecoration(
//                       border: border,
//                          borderRadius:boRadiusAll ,
//                                color: themeController.isLightMode.value
//                                     ? myColorWhite
//                                     : myColor,
//                         boxShadow: [  themeController.isLightMode.value
//                                             ? boxdark
//                                             : boxshadow2 ],
//                       ),
//                       child: Column(children: [
//                      Container(
//                               width: double.infinity,
//                               child: Stack(
//                                 children: [
//                                   Center(
//                                     child: Column(
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       children: [
//                                         Container(
//                                           padding: EdgeInsets.all(10),
//                                           color: myColorRed,
//                                           child: Text(
//                                             "Bank Details",
//                                             style:
//                                                 CustomStyleswhite.header2TextStyle,
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                   Positioned(

//                                     right: 0,
//                                     child: GestureDetector(
//                                       onTap: () {
//                                         Get.toNamed("/bank",
//                                             arguments: data);
//                                       },
//                                       child: SizedBox(
//                                         width: 39,
//                                         height: 39,
//                                         child: Container(
//                                           decoration: BoxDecoration(
//                                             borderRadius: boRadius5,
//                                             color: myColorRed,
//                                           ),
//                                           child: Icon(
//                                             Icons.edit,
//                                             color: myColorWhite,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                               size20h,
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               "Bank Name",
//                               style: CustomStyles.header2TextStyle,
//                             ),
//                             Text("SBI",
//                                 style: CustomStyles.textExternel)
//                           ],
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text("Bank Account Number",
//                                 style: CustomStyles.header2TextStyle),
//                             Text("94202345020495",
//                                 style: CustomStyles.textExternel)
//                           ],
//                         )
//                       ]),
//                     ),
//                   ),
//                   size10h,

//                        Center(
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Container(
//                                         padding: EdgeInsets.all(10),
//                                         color: myColorRed,
//                                         child: Text(
//                                           textAlign:TextAlign.center,
//                                           "Update your KYC document with amount details",
//                                           style:
//                                               CustomStyleswhite.smallTextStyle,
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                   InkWell(
//                     onTap: () {
//                       Get.toNamed("/kyc");
//                     },
//                     child: ListView.builder(
//                       shrinkWrap: true,
//                       itemCount: kycItems.length,
//                       itemBuilder: (context, index) {
//                         return Obx(
//                           ()=> Container(
//                             padding: EdgeInsets.all(5),
//                             margin: GlobleglobleMargin.Margin10V,
//                             width: double.infinity,
//                             height: 70,
//                               decoration: BoxDecoration(
//                                                border:border,
//                                                borderRadius:boRadiusAll ,
//                                color: themeController.isLightMode.value
//                                     ? myColorWhite
//                                     : myColor,
//                                                 boxShadow: [  themeController.isLightMode.value
//                                             ? boxdark
//                                             : boxshadow2 ],
//                                               ),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: [
//                                 ImageComponent(
//                                   myImage: kycItems[index].imagePath,
//                                   myheight: 40.0,
//                                   myWidth: 40.0,
//                                 ),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Text(kycItems[index].title),
//                                     Text(kycItems[index].subtitle),
//                                   ],
//                                 ),
//                                const Row(
//                                                 children: [
//                                                   Icon(
//                                                     Icons.check,
//                                                     color: Colors.green,
//                                                   ),
//                                                 ],
//                                               )  ],
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       );

//   }
// }

// class CircleIcon extends StatelessWidget {
//   var myIcon;

//   CircleIcon(this.myIcon);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 50,
//       height: 50,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         color: Color.fromARGB(255, 255, 203, 59),
//       ),
//       child: Icon(myIcon, color: Colors.white),
//     );
//   }
// }

// //objcet
// class KYCItem {
//   final String imagePath;
//   final String title;
//   final String subtitle;
//   final bool isVerified;

//   KYCItem({
//     required this.imagePath,
//     required this.title,
//     required this.subtitle,
//     required this.isVerified,
//   });
// }
// // list kyc

// List<KYCItem> kycItems = [
//   KYCItem(
//     imagePath: 'assets/adhar.png',
//     title: 'Aadhar Verification',
//     subtitle: 'Verify your Aadhar card',
//     isVerified: true, // Change to false if not verified
//   ),
//   KYCItem(
//     imagePath: 'assets/pancard.png',
//     title: 'PAN Verification',
//     subtitle: 'Verify your PAN card',
//     isVerified: true, // Change to false if not verified
//   ),
// ];

class ShowProfile extends GetView<UserDetailsController> {
  const ShowProfile({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    Get.put(UserDetailsController());

    return Scaffold(
      appBar: CustomAppBar(title: "Profile"),
      body: GetBuilder<UserDetailsController>(
        init: controller,
        builder: (controller) => UserDetailsScreen(
          controller: controller,
        ),
      ),
    );
  }
}

class UserDetailsScreen extends StatelessWidget {
  UserDetailsController? controller;
  UserDetailsScreen({this.controller});
  @override
  Widget build(BuildContext context) {
    double fem = MediaQuery.of(context).size.width / 390;
    return Obx(() {
      if (controller!.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      } else {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                decoration: BoxDecoration(
                  border: border,
                  borderRadius: boRadiusAll,
                  color: themeController.isLightMode.value
                      ? myColorWhite
                      : myColor,
                  boxShadow: [
                    themeController.isLightMode.value ? boxdark : boxshadow2
                  ],
                ),
                padding:
                    EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
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
                                  child: Image.asset(
                                "assets/logo.jpeg",
                                fit: BoxFit.cover,
                              )),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () async {
                                Get.to(EditProfile());
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
                              controller!.userDetails.value.data!.username,
                              style: CustomStyles.textExternel,
                            ),
                          ]),
                    ),
                  ],
                ),
              ),

              // _buildProfileItem(
              //   icon: Icons.person,
              //   label: 'Username',
              //   value:,
              // ),
              // _buildProfileItem(
              //   icon: Icons.phone,
              //   label: 'Mobile',
              //   value:,
              // ),
              _buildProfileItem(
                icon: Icons.email,
                label: 'Email',
                value: controller!.userDetails.value.data!.email.toString(),
              ),
              _buildProfileItem(
                icon: Icons.account_balance,
                label: 'Bank Name',
                value: controller!.userDetails.value.data!.bankName.toString(),
              ),
              _buildProfileItem(
                icon: Icons.account_circle,
                label: 'Account Holder Name',
                value: controller!.userDetails.value.data!.accountHolderName
                    .toString(),
              ),
              _buildProfileItem(
                icon: Icons.account_balance_wallet,
                label: 'IFSC Code',
                value: controller!.userDetails.value.data!.ifscCode.toString(),
              ),
              _buildProfileItem(
                icon: Icons.location_city,
                label: 'Branch Address',
                value: controller!.userDetails.value.data!.branchAddress
                    .toString(),
              ),
              _buildProfileItem(
                icon: Icons.account_balance_wallet,
                label: 'Bank Account No',
                value: controller!.userDetails.value.data!.bankAccountNo
                    .toString(),
              ),
              _buildProfileItem(
                icon: Icons.payment,
                label: 'Paytm Mobile No',
                value: controller!.userDetails.value.data!.paytmMobileNo
                    .toString(),
              ),
              _buildProfileItem(
                icon: Icons.phone_android,
                label: 'PhonePe Mobile No',
                value: controller!.userDetails.value.data!.phonepeMobileNo
                    .toString(),
              ),
              _buildProfileItem(
                icon: Icons.phone_android,
                label: 'GPay Mobile No',
                value:
                    controller!.userDetails.value.data!.gpayMobileNo.toString(),
              ),
              _buildProfileItem(
                icon: Icons.notifications,
                label: 'Pending Notification',
                value:
                    controller!.userDetails.value.data!.pendingNoti.toString(),
              ),
            ]),
          ),
        );
      }
    });
  }
}

Widget _buildProfileItem(
    {required IconData icon, required String label, required String value}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 5,
          offset: Offset(0, 3), // changes position of shadow
        ),
      ],
    ),
    child: Row(
      children: [
        Icon(icon, color: myColor),
        SizedBox(width: 16.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
