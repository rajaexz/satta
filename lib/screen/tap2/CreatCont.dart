import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:winner11/screen/component/custom_toaster.dart';
import 'package:winner11/screen/component/darkmode.dart';
import 'package:winner11/screen/component/imageComponet.dart';
import 'package:winner11/screen/component/pop.dart';

import 'package:winner11/screen/header/appbar.dart';
import 'package:winner11/screen/header/headerTop.dart';

import 'package:winner11/screen/tap/topIndigetor.dart';
import 'package:winner11/service/authapi.dart';

import 'package:winner11/utilis/alinement.dart';
import 'package:winner11/utilis/borderbox.dart';
import 'package:winner11/utilis/boxSpace.dart';
import 'package:winner11/utilis/fontstyle.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utilis/AllColor.dart';
import '../../utilis/globlemargin.dart';

class CreateCont extends StatefulWidget {
  const CreateCont({super.key});

  @override
  State<CreateCont> createState() => _CreateContState();
}

enum CheckboxValue { checkbox1, checkbox2 }

class _CreateContState extends State<CreateCont> {
  CheckboxValue? selectedCheckbox = null;

  @override
  void initState() {
    super.initState();

  }

  //api argument
  final dynamic data_of_id = Get.arguments as dynamic;
  @override
  Widget build(BuildContext context) {
    final ApiService apiService = ApiService();

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Contest',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Indigator
            Container(
               height: 50,
                    color: myColorRed,
              child: Indigator(currentPage: 2)),
            Container(
              margin: GlobleglobleMargin.globleMargin,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: AlignmentStartCross,
                children: [
                  const Divider(),
                  Simpletitlebtn(HeadName: "Create Matches"),
                  size20h,
                  
                                     SizedBox(
                                height: 180,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Stack(
                                      children: [
                                        Positioned(
                                          child: Container(
                                            padding: const EdgeInsets.all(20),
                                            decoration: BoxDecoration(
                                                border: border,
                                                borderRadius: boRadius5),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Row(
                                                  children: [
                                                    ImageComponentNet(
                                                      myWidth: 100.0,
                                                      myheight: 100.0,
                                                      myImage: data_of_id["data"]["team_a_img"],
                                                    ),
                                                  ],
                                                ),
                                                size10h,
                                                Text(
                                                  data_of_id["data"]["team_a"],
                                                  style: CustomStyles
                                                      .smallTextStyle,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                            top: 0,
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  selectedCheckbox =
                                                      CheckboxValue.checkbox1;
                                                });
                                              },
                                              child: Container(
                                                height: 180.0,
                                                width: 141,
                                                decoration: BoxDecoration(
                                                  color: selectedCheckbox ==
                                                          CheckboxValue
                                                              .checkbox1
                                                      ? myColorGray
                                                          .withOpacity(0.5)
                                                      : Colors.transparent,
                                                  border: Border.all(
                                                    width: 2.0,
                                                    color: Colors.green,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                ),
                                                child: selectedCheckbox ==
                                                        CheckboxValue.checkbox1
                                                    ? const Icon(
                                                        Icons.check,
                                                        size: 100.0,
                                                        color: Colors.green,
                                                      )
                                                    : null,
                                              ),
                                            )),
                                      ],
                                    ),

                                    /////////////////////////////////////////////

                                    Stack(
                                      children: [
                                        Positioned(
                                          child: Container(
                                            padding: const EdgeInsets.all(20),
                                            decoration: BoxDecoration(
                                                border: border,
                                                borderRadius: boRadius5),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Row(
                                                  children: [
                                                    ImageComponentNet(
                                                      myWidth: 100.0,
                                                      myheight: 100.0,
                                                      myImage: data_of_id["data"]["team_b_img"],
                                                    ),
                                                  ],
                                                ),
                                                size10h,
                                                Text(
                                                   data_of_id["data"]["team_b"],
                                                  style: CustomStyles
                                                      .smallTextStyle,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                            top: 0,
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  selectedCheckbox =
                                                      CheckboxValue.checkbox2;
                                                });
                                              },
                                              child: Container(
                                                height: 180.0,
                                                width: 141,
                                                decoration: BoxDecoration(
                                                  color: selectedCheckbox ==
                                                          CheckboxValue
                                                              .checkbox2
                                                      ? myColorGray
                                                          .withOpacity(0.5)
                                                      : Colors.transparent,
                                                  border: Border.all(
                                                    width: 2.0,
                                                    color: Colors.green,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                ),
                                                child: selectedCheckbox ==
                                                        CheckboxValue.checkbox2
                                                    ? const Icon(
                                                        Icons.check,
                                                        size: 100.0,
                                                        color: Colors.green,
                                                      )
                                                    : null,
                                              ),
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                              )
           
                  
                    ],
              ),
            ),
            size20h,
            ElevatedButton(
              onPressed: () async {
                final store = await SharedPreferences.getInstance();
                var id = store.getString("userId");
                // Add your button action here
                if (selectedCheckbox == CheckboxValue.checkbox1) {
                  // ignore: use_build_context_synchronously
                  await showInputDialog(context :context, textValue: "teams1",data: data_of_id );
               
                } else if (selectedCheckbox == CheckboxValue.checkbox2) {
                  // ignore: use_build_context_synchronously
                  await showInputDialog(context :context, textValue: "teams2",data: data_of_id );

              
                } else {
                  // ignore: use_build_context_synchronously
                  CustomToaster.showWarning(context, "Please select Teams ");
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    myColorgreen, // Set the button background color to green
              ),
              child: Text(
                '    Save Contest    ',
                style: CustomStyleswhite.headerTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
