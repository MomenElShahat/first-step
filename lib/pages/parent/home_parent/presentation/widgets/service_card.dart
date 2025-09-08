import 'package:first_step/pages/parent/home_parent/models/services_model.dart';
import 'package:first_step/widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../consts/colors.dart';
import '../../../../../consts/text_styles.dart';
import '../../../../../resources/assets_svg_generated.dart';
import '../../../../../resources/strings_generated.dart';
import '../../../../../widgets/custom_text.dart';
import '../../../../../widgets/gaps.dart';

class ServiceCard extends StatelessWidget {
  final Service service;

  const ServiceCard({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.h,
      width: 120.w,
      margin: const EdgeInsetsDirectional.only(end: 5),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedImage(
                  url: service.image ?? "",
                  width: 60.w,
                  height: 45.h,
                  fit: BoxFit.fill,
                ),
              ),
              Gaps.vGap8,
              CustomText(
                service.title ?? "",
                maxLines: 3,
                textStyle: TextStyles.body14Medium
                    .copyWith(fontSize: 8.sp, color: ColorCode.primary600),
              )
            ],
          ),
        ),
      ),
    );
  }
}
