import 'package:flutter/material.dart';
import 'package:winner11/screen/component/headNavi.dart';
import 'package:winner11/screen/component/treamsHeading.dart';
import 'package:winner11/screen/header/appbar.dart';
import 'package:winner11/screen/header/headerTop.dart';
import 'package:winner11/service/authapi.dart';
import 'package:winner11/utilis/AllColor.dart';
import 'package:winner11/utilis/boxSpace.dart';
import 'package:winner11/utilis/globlemargin.dart';

class Step {
  Step(this.title, this.body, [this.isExpanded = false]);
  String title;
  String body;
  bool isExpanded;
}

Future<List<Step>> getSteps() async {
  var _items = [
    Step('Step 0: Install Flutter',
        'Install Flutter development tools according to the official documentation.'),
    Step('Step 1: Create a project',
        'Open your terminal, run `flutter create <project_name>` to create a new project.'),
    Step('Step 2: Run the app',
        'Change your terminal directory to the project directory, enter `flutter run`.'),
  ];
  return Future<List<Step>>.delayed(const Duration(seconds: 2), () => _items);
}

final ApiService apiService = ApiService();

class Steps extends StatelessWidget {
  const Steps({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'FAQ',
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: GlobleglobleMargin.globleMargin,
          child: Column(
            children: [
              Simpletitlebtn(HeadName: "FAQ :-"),
              size20h,
              size20h,
              FutureBuilder(
                future: apiService.userAllDoc(uri: '/user_faq'),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    final data =
                        (snapshot.data as Map<String, dynamic>)['data'];
                        print(data);
                    if (data != null) {
                      final result = data["result"];
                    return Container(
          margin: GlobleglobleMargin.globleMargin,
          child: Container(
            height: 600,
            child: ListView.builder(
              itemCount: result.length,
              itemBuilder: (context, index) {
                var faqItem = result[index];
                return Column(
                  children: [
                    SectionTitle(title: faqItem["question"]),
                     SectionContent(content: faqItem["answer"]),
                  
                    
                  ],
                );
              },
            ),
          ),
        );

                    } else {
                      return Text('No data available');
                    }
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return CircularProgressIndicator(); // Display a loading indicator
                  } else {
                    return Text('Data retrieval is not in progress');
                  }
                },
              ),
                ],
          ),
        ),
      ),
    );
  }
}
