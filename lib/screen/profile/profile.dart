import 'dart:io';

import 'package:winner11/screen/component/custom_toaster.dart';
import 'package:winner11/screen/component/darkmode.dart';
import 'package:winner11/screen/profile/controller/profile_controller.dart';

import 'package:winner11/screen/profile/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winner11/screen/component/imageComponet.dart';
import 'package:winner11/screen/header/appbar.dart';
import 'package:winner11/utilis/AllColor.dart';
import 'package:winner11/utilis/borderbox.dart';
import 'package:winner11/utilis/boxSpace.dart';

import 'package:winner11/utilis/fontstyle.dart';
import 'package:winner11/utilis/globlemargin.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';


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
      
        appBar:
        
   CustomAppBar(title: "Profile"),
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
    UserDetailsController? controller ;
UserDetailsScreen({this.controller});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
      ),
      body: Obx(() {
        if (controller!.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Username: ${controller!.userDetails.value.data!.username}'),
                Text('Mobile: ${controller!.userDetails.value.data!.mobile}'),
                Text('Email: ${controller!.userDetails.value.data!.email}'),
                Text('Bank Name: ${controller!.userDetails.value.data!.bankName}'),
                Text('Account Holder Name: ${controller!.userDetails.value.data!.accountHolderName}'),
                Text('IFSC Code: ${controller!.userDetails.value.data!.ifscCode}'),
                Text('Branch Address: ${controller!.userDetails.value.data!.branchAddress}'),
                Text('Bank Account No: ${controller!.userDetails.value.data!.bankAccountNo}'),
                Text('Paytm Mobile No: ${controller!.userDetails.value.data!.paytmMobileNo}'),
                Text('PhonePe Mobile No: ${controller!.userDetails.value.data!.phonepeMobileNo}'),
                Text('GPay Mobile No: ${controller!.userDetails.value.data!.gpayMobileNo}'),
                Text('Pending Notification: ${controller!.userDetails.value.data!.pendingNoti}'),
              ],
            ),
          );
        }
      }),
    );
  }
}
