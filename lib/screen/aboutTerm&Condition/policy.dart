
import 'package:flutter/material.dart';
import 'package:winner11/screen/component/headNavi.dart';
import 'package:winner11/screen/component/treamsHeading.dart';
import 'package:winner11/service/authapi.dart';
import 'package:winner11/utilis/AllColor.dart';
import 'package:winner11/utilis/globlemargin.dart';
class Privacy extends StatefulWidget {
  const Privacy({super.key});

  @override
  State<Privacy> createState() => _TarmAndState();
}

class _TarmAndState extends State<Privacy> {
    final ApiService apiService = ApiService();
  @override
  Widget build(BuildContext context) {
    final mQ = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child:    FutureBuilder(
          future:
              apiService.userAllDoc( uri: '/user_privacy_policy'),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              final data = (snapshot.data as Map<String, dynamic>)['data'];
              if (data != null) {
                final result = data["result"][0];
                return Column(
              children: [
                   Stack(
            children: [
                
                Container(
                  width: MediaQuery.of(context).size.width * 1,
                padding: GlobleglobleMargin.Margin10L,
                  decoration:  BoxDecoration(color: myColorRed),
                
                  child: Image.asset(
                    'assets/banner1.png',
                    width: 200,
                    height: 100,
                  ),
                ),
                      createPositioned(context),
            ],
                   ),
                Container(
                  margin: GlobleglobleMargin.globleMargin,
                  child: Column(children: [
                      
                    SectionTitle(title: '1. Legal Consultation'),
                            SectionContent(
                  content: result["privacy_policy"]?? "",
                            ),
                            SectionTitle(title: '2. User Agreement'),
                            SubSectionTitle(title: '2.1 User Eligibility'),
                            SectionContent(
                  content: 'Your terms and conditions should include a user agreement that outlines the terms under which users can access and use your app. This agreement should cover topics such as user eligibility, account registration, and user responsibilities.',
                            ),
                            SubSectionTitle(title: '2.2 Account Registration'),
                            SectionContent(
                  content: 'Explain the process of account registration for users and any requirements or restrictions.',
                            ),
                            // Add more sections and subsections here...
                            SectionTitle(title: '3. Privacy Policy'),
                            SubSectionTitle(title: '3.1 Data Collection'),
                            SectionContent(
                  content: 'Include a clear and comprehensive privacy policy that explains how you collect, use, and protect user data. Ensure that your data handling practices comply with relevant data protection laws like GDPR, CCPA, etc.',
                            ),
                            SubSectionTitle(title: '3.2 Data Sharing'),
                            SectionContent(
                  content: 'Explain how user data may be shared with third parties, if applicable.',
                            ),
                            // ... Existing code ...
                
                SectionTitle(title: '4. Payment Terms'),
                SubSectionTitle(title: '4.1 Pricing'),
                SectionContent(
                  content: 'Explain the pricing structure for your taxi services, including base fares, per-mile charges, and any additional fees.',
                ),
                SubSectionTitle(title: '4.2 Payment Methods'),
                SectionContent(
                  content: 'Specify the payment methods available for users to pay for taxi services through your app.',
                ),
                
                SectionTitle(title: '5. Service Terms'),
                SubSectionTitle(title: '5.1 Requesting Rides'),
                SectionContent(
                  content: 'Details how users can request rides through your app, including the process and any requirements.',
                ),
                SubSectionTitle(title: '5.2 Driver Responsibilities'),
                SectionContent(
                  content: 'Explain the responsibilities of drivers when providing taxi services through your app.',
                ),
                
                SectionTitle(title: '6. Intellectual Property'),
                SubSectionTitle(title: '6.1 Ownership'),
                SectionContent(
                  content: 'Clarify ownership of app content and intellectual property rights. Specify how users can use your app\'s content and whether they can reproduce or distribute it.',
                ),
                
                SectionTitle(title: '7. Dispute Resolution'),
                SubSectionTitle(title: '7.1 Arbitration'),
                SectionContent(
                  content: 'Explain the process of arbitration for resolving disputes between users, drivers, and your company.',
                ),
                SubSectionTitle(title: '7.2 Jurisdiction'),
                SectionContent(
                  content: 'Specify the jurisdiction where legal disputes related to your app will be settled.',
                ),
                
                SectionTitle(title: '8. Termination'),
                SubSectionTitle(title: '8.1 User Termination'),
                SectionContent(
                  content: 'Outline the conditions under which you can terminate a user\'s access to your app and the consequences of such termination.',
                ),
                SubSectionTitle(title: '8.2 Driver Termination'),
                SectionContent(
                  content: 'Explain the conditions and consequences of terminating a driver\'s access to your app.',
                ),
                
                SectionTitle(title: '9. Liability and Disclaimer'),
                SubSectionTitle(title: '9.1 Limitations of Liability'),
                SectionContent(
                  content: 'Clearly state the limitations of your liability in various situations.',
                ),
                SubSectionTitle(title: '9.2 Warranties'),
                SectionContent(
                  content: 'Include a disclaimer of warranties to protect your company from legal claims.',
                ),
                
                SectionTitle(title: '10. Updates to Terms and Conditions'),
                SectionContent(
                  content: 'Specify how you will communicate updates to your terms and conditions and how users will be notified of changes.',
                ),
                
                
                
                  ],),
                )
              
                 ],
            );
  
             
              } else {
                return Text('No data available');
              }
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(); // Display a loading indicator
            } else {
              return Text('Data retrieval is not in progress');
            }
      
             
              },
                )
              ),
        ),
      );
    
  }
}