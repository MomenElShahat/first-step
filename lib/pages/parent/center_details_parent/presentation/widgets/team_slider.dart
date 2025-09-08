import 'package:first_step/consts/colors.dart';
import 'package:first_step/pages/parent/center_details_parent/models/center_portfolio_model.dart';
import 'package:first_step/widgets/cached_image.dart';
import 'package:first_step/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../consts/text_styles.dart';
import '../../../../../resources/assets_generated.dart';
import '../../../../../widgets/gaps.dart';

class TeamSlider extends StatelessWidget {
  final List<Teams> team;

  const TeamSlider({super.key, required this.team});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(height: 200.h, enlargeCenterPage: false, autoPlay: false, viewportFraction: .4, enableInfiniteScroll: false),
          items: team.map((item) {
            return Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: CachedImage(
                    width: 113.w,
                    url: item.image ?? "",
                    placeHolder: const Image(
                      image: AppAssets.teamPerson,
                      fit: BoxFit.fill,
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
                Gaps.vGap16,
                CustomText(
                  item.name ?? "",
                  textStyle: TextStyles.button12.copyWith(color: ColorCode.primary600, fontWeight: FontWeight.w700),
                ),
                Gaps.vGap16,
                CustomText(
                  item.mission ?? "",
                  textStyle: TextStyles.button12.copyWith(color: ColorCode.neutral500, fontWeight: FontWeight.w500),
                ),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}
