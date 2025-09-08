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

class PlansSlider extends StatelessWidget {
  final List<PortfolioPrice> portfolioPricesModel;
  final String centerName;
  final String branchName;

  const PlansSlider(
      {super.key,
      required this.portfolioPricesModel,
      required this.centerName,
      required this.branchName});

  @override
  Widget build(BuildContext context) {
    return portfolioPricesModel.isEmpty ? Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomText(AppStrings.noPlansFound,textStyle: TextStyles.body16Medium,),
        ],
      ),
    ) : CarouselSlider(
      options: CarouselOptions(
          clipBehavior: Clip.none,
          height: Get.height / 3.2,
          enlargeCenterPage: false,
          autoPlay: true,
          viewportFraction: .8,
          enableInfiniteScroll: false),
      items: portfolioPricesModel.map((item) {
        String? type = item.enrollmentType == "day"
            ? AppStrings.day
            : item.enrollmentType == "hour"
                ? AppStrings.hour
                : item.enrollmentType == "week"
                    ? AppStrings.week
                    : item.enrollmentType == "month"
                        ? AppStrings.month
                        : item.enrollmentType == "year"
                            ? AppStrings.year
                            : "";
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Color(0x22222214), // Or calculate with full ARGB
                offset: Offset(2, 2),
                blurRadius: 10,
                spreadRadius: 0,
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomText(
                item.title ?? "",
                textStyle: TextStyles.title24Bold.copyWith(
                    fontSize: 28.sp,
                    color: ColorCode.primary600,
                    fontWeight: FontWeight.w700),
              ),
              Gaps.vGap16,
              CustomText(
                "${item.count} $type" ?? "",
                textStyle: TextStyles.body16Medium.copyWith(
                    color: ColorCode.neutral600, fontWeight: FontWeight.w500),
              ),
              Gaps.vGap16,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: CustomText(
                      item.priceAmount ?? "",
                      textStyle: TextStyles.body16Medium.copyWith(
                          color: ColorCode.primary600,
                          fontWeight: FontWeight.w700,
                          fontSize: 40.sp,
                          height: 1),
                    ),
                  ),
                  Gaps.hGap4,
                  const Image(image: AppAssets.riyal)
                ],
              ),
              Gaps.vGap24,
              InkWell(
                onTap: () {
                  Get.toNamed(Routes.BOOKING_SCREEN, arguments: {
                    "branchName": branchName,
                    "selectedPricing": item,
                    "centerName": centerName,
                    "pricingList": portfolioPricesModel
                  });
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.symmetric(vertical: 10.5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    gradient: const LinearGradient(
                      begin: AlignmentDirectional.centerEnd,
                      end: AlignmentDirectional.centerStart,
                      colors: [
                        Color(0xFF7A8CFD), // Light Blue
                        Color(0xFF404FB1), // Mid Blue
                        Color(0xFF2B3990), // Dark Blue
                      ],
                      stops: [0.1117, 0.6374, 0.9471],
                    ),
                  ),
                  child: Center(
                    child: CustomText(
                      AppStrings.bookNow,
                      textStyle: TextStyles.body16Medium.copyWith(
                          fontWeight: FontWeight.w700, color: ColorCode.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class BranchModel {
  final int id;
  final String name;

  BranchModel({required this.id, required this.name});
}

class PlanModel {
  final String title;
  final int price;
  final List<String> features;

  PlanModel({required this.title, required this.price, required this.features});
}
