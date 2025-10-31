import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../consts/colors.dart';
import '../../../../../consts/text_styles.dart';
import '../../../../../resources/assets_generated.dart';
import '../../../../../resources/assets_svg_generated.dart';
import '../../../../../resources/strings_generated.dart';
import '../../../../../services/auth_service.dart';
import '../../../../../widgets/cached_image.dart';
import '../../../../../widgets/custom_text.dart';
import '../../../../../widgets/gaps.dart';
import '../../models/centers_model.dart';

class CenterCard extends StatelessWidget {
  NurseryModel center;

  CenterCard({super.key, required this.center});

  @override
  Widget build(BuildContext context) {
    String getAllCities() {
      // Get list of cities, ignoring null or empty values
      List<String> cities = center.branches
              ?.map((branch) => AuthService.to.language == "ar"
                  ? branch.city?.name?.ar ?? ""
                  : branch.city?.name?.en ?? "")
              .where((city) => city.isNotEmpty && city != "undefined")
              .toList() ??
          [];

      // Combine with " - " separator
      return cities.join(" - ");
    }

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            center.logo != null && (center.logo?.isNotEmpty ?? false)
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: CachedImage(
                      width: Get.width / 4,
                      url: center.logo ?? "",
                      fit: BoxFit.fill,
                      placeHolder: const Image(
                        image: AppAssets.centerImage,
                      ),
                    ),
                  )
                : center.logo != null && (center.logo?.isEmpty ?? false)
                    ? const Image(
                        image: AppAssets.centerImage,
                      )
                    : const Image(
                        image: AppAssets.centerImage,
                      ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gaps.vGap8,
                Center(
                  child: CustomText(
                    center.nurseryName ?? "",
                    textStyle: TextStyles.title32Bold.copyWith(
                        fontSize: 16.sp,
                        color: ColorCode.primary600,
                        fontWeight: FontWeight.w700,
                        overflow: TextOverflow.ellipsis),
                    maxLines: 1,
                  ),
                ),
                Gaps.vGap4,
                CustomText(
                  getAllCities(),
                  textAlign: TextAlign.start,
                  textStyle: TextStyles.body14Regular
                      .copyWith(fontSize: 8.sp, color: ColorCode.neutral500),
                ),
                Gaps.vGap4,
                Row(
                  children: [
                    AppSVGAssets.getWidget(AppSVGAssets.location),
                    Gaps.hGap4,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            "${AppStrings.mainBranch}: ${AuthService.to.language == "ar" ? center.city?.name?.ar ?? "" : center.city?.name?.en ?? ""} - ${center.neighborhood ?? ""}",
                            textStyle: TextStyles.body14Regular.copyWith(
                              fontSize: 6.sp,
                              color: ColorCode.neutral500,
                            ),
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Gaps.vGap8,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppSVGAssets.getWidget(AppSVGAssets.childrenFiles,
                        color: ColorCode.secondary600),
                    Gaps.hGap4,
                    ...List.generate(
                      center.acceptedAges?.length ?? 0,
                      (index) => CustomText(
                        "${center.acceptedAges?[index]}  ",
                        textStyle: TextStyles.body14Regular.copyWith(
                            fontSize: 6.sp, color: ColorCode.neutral500),
                      ),
                    )
                  ],
                ),
                Gaps.vGap8,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppSVGAssets.getWidget(
                      AppSVGAssets.rateFilled,
                    ),
                    Gaps.hGap4,
                    AppSVGAssets.getWidget(
                      AppSVGAssets.rateFilled,
                    ),
                    Gaps.hGap4,
                    AppSVGAssets.getWidget(
                      AppSVGAssets.rateFilled,
                    ),
                    Gaps.hGap4,
                    AppSVGAssets.getWidget(
                      AppSVGAssets.rateFilled,
                    ),
                    Gaps.hGap4,
                    AppSVGAssets.getWidget(
                      AppSVGAssets.star,
                    ),
                  ],
                ),
                Gaps.vGap8,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: center.services?.take(2).map((item) {
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AppSVGAssets.getWidget(AppSVGAssets.handshake),
                            Gaps.hGap4,
                            CustomText(
                              item,
                              textStyle: TextStyles.body14Regular.copyWith(
                                  fontSize: 6.sp, color: ColorCode.neutral500),
                            ),
                          ],
                        );
                      }).toList() ??
                      [],
                ),
                Gaps.vGap8,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
