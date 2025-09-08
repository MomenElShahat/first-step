import 'package:cached_network_image/cached_network_image.dart';
import 'package:first_step/consts/colors.dart';
import 'package:first_step/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../consts/text_styles.dart';
import '../../../../../resources/assets_generated.dart';
import '../../../../../widgets/gaps.dart';
import '../../models/center_portfolio_model.dart';

class ServicesSlider extends StatelessWidget {
  final List<Services> services;

  const ServicesSlider({super.key, required this.services});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
              height: 300.h,
              enlargeCenterPage: false,
              autoPlay: false,
              enableInfiniteScroll: false,
              viewportFraction: .9),
          items: services.map((item) {
            return Padding(
              padding: const EdgeInsetsDirectional.only(end: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child: CachedNetworkImage(
                      height: 200.h,
                      width: double.infinity,
                      imageUrl: item.imageService ?? "",
                      fit: BoxFit.fill,
                      placeholder: (context, url) => AspectRatio(
                        aspectRatio: 1,
                        child: Container(color: Colors.grey.shade200),
                      ),
                      errorWidget: (context, url, error) => AspectRatio(
                        aspectRatio: 1,
                        child: Container(
                          color: Colors.grey.shade300,
                          child: const Icon(Icons.error),
                        ),
                      ),
                    ),
                  ),
                  Gaps.vGap16,
                  CustomText(
                    item.title ?? "",
                    textStyle: TextStyles.body16Medium.copyWith(
                        fontWeight: FontWeight.w700, color: ColorCode.primary600),
                  ),
                  Gaps.vGap16,
                  CustomText(
                    item.description ?? "",
                    textStyle: TextStyles.button12.copyWith(
                        fontWeight: FontWeight.w400, color: ColorCode.neutral600),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
