import 'package:winner11/screen/component/darkmode.dart';
import 'package:winner11/screen/header/appbar.dart';
import 'package:winner11/screen/header/headerTop.dart';
import 'package:winner11/screen/tap3/blogList.dart';
import 'package:winner11/service/authapi.dart';
import 'package:winner11/utilis/AllColor.dart';
import 'package:winner11/utilis/borderbox.dart';
import 'package:winner11/utilis/boxSpace.dart';
import 'package:winner11/utilis/fontstyle.dart';
import 'package:winner11/utilis/globlemargin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'blog.dart';

class MyFullBlog extends StatefulWidget {
  const MyFullBlog({super.key});

  @override
  State<MyFullBlog> createState() => _MyFullBlogState();
}

class _MyFullBlogState extends State<MyFullBlog> {
  final ApiService apiService = ApiService();

  final ThemeController themeController = Get.put(ThemeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "ALL News"),
      body: Container(
        margin: GlobleglobleMargin.globleMargin,
        child: Column(
          children: [

            size20h,
            FutureBuilder(
              future: apiService.userAllblog(),
              builder: (context, snapshot) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: apiService.liveBolg.length,
                    itemBuilder: (context, index) {
                      final blog = apiService.liveBolg[index];
                      bool isEvenIndex = index % 4 == 0;
                          if (index == apiService.liveBolg.length - 1) {
              return Column(
                children: [
                
                  Text('Back to home page '),
                  ElevatedButton(
                    onPressed: () {
                  Navigator.pop(context);
                    },
                    child: Text('Home'),
                  ),
                ],
              );
            } else{
                 if (isEvenIndex) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    NewsLayout(newsData: blog),
                              ),
                            );
                          },
                          child:Obx(() =>  Container(
                              height: 280,
                              margin:
                                  EdgeInsets.only(left: 5, right: 5, top: 20),
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: themeController.isLightMode.value
                                      ? myColorWhite
                                      : myColor,
                                  boxShadow: [
                                    themeController.isLightMode.value
                                        ? boxshadow2
                                        : boxdark
                                  ],
                                  border: border,
                                  borderRadius: boRadiusAll),
                              child: Container(
                                padding: EdgeInsets.all(4.0),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.network(
                                        blog.image,
                                        width: double.infinity,
                                        height: 150,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    SizedBox(
                                        height:
                                            8.0), // Add some space between the image and text
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(blog.title,
                                              style: TextStyle(
                                                height: 1.5,
                                                fontWeight: FontWeight.bold,
                                              )),
                                          Text(
                                              "By ${blog.newsId} - ${blog.pubDate}",
                                              style:
                                                 TextStyle(fontSize: 10)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                       ) );
                      } else {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    NewsLayout(newsData: blog),
                              ),
                            );
                          },
                          child:Obx(() =>  Container(
                              height: 150,
                              margin:
                                  EdgeInsets.only(left: 5, right: 5, top: 20),
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: themeController.isLightMode.value
                                      ? myColorWhite
                                      : myColor,
                                  boxShadow: [
                                    themeController.isLightMode.value
                                        ? boxshadow2
                                        : boxdark
                                  ],
                                  border: border,
                                  borderRadius: boRadiusAll),
                              child: Container(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.network(
                                        blog.image,
                                        width: 100,
                                        height: 150,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(
                                        width:
                                            8.0), // Add some space between the image and text
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(blog.title,
                                              style: TextStyle(
                                                height: 1.5,
                                            
                                              )),
                                          Text(
                                              "By ${blog.newsId} - ${blog.pubDate}",
                                              style:
                                                  TextStyle(fontSize: 10)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                       ) );
                      }
            }
                   
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
