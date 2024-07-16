import 'package:flutter/material.dart';
import 'package:Billa/screen/component/treamsHeading.dart';
import 'package:Billa/screen/header/appbar.dart';
import 'package:Billa/screen/header/headerTop.dart';

import 'package:Billa/utilis/boxSpace.dart';
import 'package:Billa/utilis/globlemargin.dart';

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
              Container(
                margin: GlobleglobleMargin.globleMargin,
                child: SizedBox(
                  height: 600,
                  child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      var faqItem = {
                        "question": " satta game Khelo",
                        "answer": "khelo sub"
                      };
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SectionTitle(title: faqItem["question"] ?? ""),
                          SectionContent(content: faqItem["answer"] ?? ""),
                        ],
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
