
import 'package:winner11/model/AppDataModel.dart';
import 'package:winner11/utilis/AllColor.dart';
import 'package:winner11/utilis/borderbox.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../service/authapi.dart';

class BannerAdd extends StatefulWidget {
  final List<Bannered> banners;
  late int? currentSlide;

  BannerAdd({required this.banners, this.currentSlide});

  @override
  _BannerAddState createState() => _BannerAddState();
}

class _BannerAddState extends State<BannerAdd> {
  @override
  Widget build(BuildContext context) {
    List<Widget> bannerWidgets = widget.banners.map<Widget>((banner) {
      return BannerWidget(
        imageUrl: banner,
      );
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 140.0,
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
  final Bannered? imageUrl;

  BannerWidget({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        launchUrl(Uri.parse(imageUrl!.image));
      },
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 7, vertical: 7),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(
            "${imageUrl!.image}",
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
