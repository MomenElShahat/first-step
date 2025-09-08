import 'package:first_step/consts/colors.dart';
import 'package:first_step/resources/assets_svg_generated.dart';
import 'package:first_step/routes/app_pages.dart';
import 'package:first_step/widgets/cached_image.dart';
import 'package:first_step/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../consts/text_styles.dart';
import '../../../../../resources/assets_generated.dart';
import '../../../../../resources/strings_generated.dart';
import '../../../../../widgets/gaps.dart';
import '../../../../center/control_panel/models/portfolio_prices_model.dart';
import '../../../home_parent/models/centers_model.dart';

class AdsSlider extends StatefulWidget {
  final List<String> ads;

  const AdsSlider({super.key, required this.ads});

  @override
  State<AdsSlider> createState() => _AdsSliderState();
}

class _AdsSliderState extends State<AdsSlider> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CarouselSlider(
          options: CarouselOptions(
            clipBehavior: Clip.none,
            enlargeCenterPage: false,
            autoPlay: true,
            enableInfiniteScroll: false,
            viewportFraction: 1,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          items: widget.ads.map((item) {
            return CachedImage(
              url: item,
              fit: BoxFit.fill,
              width: double.infinity,
            );
          }).toList(),
        ),
        Positioned(
          bottom: 12.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(widget.ads.length, (index) {
              bool isActive = index == _currentIndex;
              return Container(
                width: isActive ? 10.w : 8.w,
                height: isActive ? 10.w : 8.w,
                margin: EdgeInsets.symmetric(horizontal: 4.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isActive ? ColorCode.primary600 : Colors.white.withOpacity(0.5),
                ),
              );
            }),
          ),
        )
      ],
    );
  }
}
