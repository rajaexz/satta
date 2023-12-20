import 'package:winner11/banner/banner_Model.dart';
import 'package:winner11/screen/component/darkmode.dart';
import 'package:winner11/utilis/AllColor.dart';
import 'package:winner11/utilis/borderbox.dart';
import 'package:winner11/utilis/boxSpace.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:url_launcher/url_launcher.dart';

import '../service/authapi.dart';


class BannerAdd extends StatefulWidget {
  final List<Banners> banners;
  late  int? currentSlide;

  BannerAdd({required this.banners, this.currentSlide});

  @override
  _BannerAddState createState() => _BannerAddState();
}

class _BannerAddState extends State<BannerAdd> {
  @override
  Widget build(BuildContext context) {
    List<Widget> bannerWidgets = widget.banners.map<Widget>((banner) {
      return BannerWidget(imageUrl: banner.image, uri: banner.url);
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 80.0,
            aspectRatio: 15 / 9,
            viewportFraction: 1,
            autoPlay: true,
            pageSnapping: true,
            initialPage: widget.currentSlide ?? 0,
            pauseAutoPlayInFiniteScroll: true,
            autoPlayCurve: Curves.easeInExpo,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            disableCenter: false,
            onPageChanged: (index, reason) {
              setState(() {
                if (widget.currentSlide != null) {
                  widget.currentSlide = index;
                }
              });
            },
          ),
          items: bannerWidgets,
        ),
      SizedBox(height: 10), // Use SizedBox for spacing
        bannerWidgets.length != 1
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List<Widget>.generate(
                  bannerWidgets.length,
                  (index) {
                    return Container(
                      width: 6,
                      height: 6,
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      decoration: BoxDecoration(
                        border: border,
                        shape: BoxShape.circle,
                        color: widget.currentSlide == index
                            ? myColorRed // Change to your color
                            : myColorWhite, // Change to your color
                      ),
                    );
                  },
                ),
              )
            : SizedBox(), // Use SizedBox for spacing
    
      ],
    );
  }
}

class BannerWidget extends StatelessWidget {
  final String? imageUrl;
  final String? uri;

  BannerWidget({required this.imageUrl, required this.uri});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
                launchUrl(Uri.parse(this.uri!));
      },
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 7, vertical: 7),
        decoration: BoxDecoration(
          // Add your decoration
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(
            "https://winners11.in/images/$imageUrl",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
