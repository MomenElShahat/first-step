import 'package:first_step/consts/colors.dart';
import 'package:first_step/pages/center/control_panel/presentation/controllers/control_panel_controller.dart';
import 'package:first_step/pages/center/control_panel/presentation/widgets/booking_row.dart';
import 'package:first_step/pages/center/control_panel/presentation/widgets/info_card.dart';
import 'package:first_step/pages/center/control_panel/presentation/widgets/table.dart';
import 'package:first_step/resources/assets_svg_generated.dart';
import 'package:first_step/resources/strings_generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../../../../consts/text_styles.dart';
import '../../../../../widgets/custom_text.dart';
import '../../../../../widgets/gaps.dart';
import '../controllers/control_panel_parent_controller.dart';

class DashboardHomeParent extends GetView<ControlPanelParentController> {
  const DashboardHomeParent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Gaps.vGap40,
        InfoCard(
          icon: AppSVGAssets.childrenFiles,
          title: AppStrings.numberOfChildren,
          value: (controller.children?.length ?? 0).toString(),
          width: Get.width / 3,
        ),
        Gaps.vGap8,
        InfoCard(
          icon: AppSVGAssets.booking,
          title: AppStrings.numberOfReservations,
          value: "25",
          width: Get.width / 3,
        ),
        Gaps.vGap40,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient: const LinearGradient(
                    begin: AlignmentDirectional(-0.26, -1.0),
                    // Approximate 105deg
                    end: AlignmentDirectional(1.0, 0.3),
                    colors: [
                      Color.fromRGBO(180, 41, 41, 0.6),
                      Color.fromRGBO(197, 0, 0, 0.6),
                    ],
                    stops: [0.048, 0.9708], // 4.8% and 97.08%
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      AppStrings.rejected,
                      textStyle: TextStyles.body16Medium.copyWith(fontWeight: FontWeight.w700, color: ColorCode.primary600),
                    ),
                    Gaps.vGap8,
                    CustomText(
                      "10",
                      textStyle: TextStyles.body16Medium.copyWith(fontWeight: FontWeight.w700, fontSize: 36.sp, color: ColorCode.primary600),
                    ),
                  ],
                ),
              ),
            ),
            Gaps.hGap16,
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient: const LinearGradient(
                    begin: AlignmentDirectional(-0.26, -1.0),
                    // Approximation of 105deg
                    end: AlignmentDirectional(1.0, 0.3),
                    colors: [
                      Color.fromRGBO(226, 128, 0, 0.48),
                      Color.fromRGBO(250, 235, 137, 0.48),
                    ],
                    stops: [0.0288, 0.947], // From 2.88% to 94.7%
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      AppStrings.pendingConfirmation,
                      textStyle: TextStyles.body16Medium.copyWith(fontWeight: FontWeight.w700, color: ColorCode.primary600),
                    ),
                    Gaps.vGap8,
                    CustomText(
                      "10",
                      textStyle: TextStyles.body16Medium.copyWith(fontWeight: FontWeight.w700, fontSize: 36.sp, color: ColorCode.primary600),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Gaps.vGap16,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient: const LinearGradient(
                    begin: AlignmentDirectional(-0.28, -1.0),
                    // Approximation of 104°
                    end: AlignmentDirectional(1.0, 0.36),
                    colors: [
                      Color.fromRGBO(6, 78, 195, 0.48),
                      Color.fromRGBO(106, 149, 221, 0.48),
                    ],
                    stops: [0.0, 0.9646], // 0% to 96.46%
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      AppStrings.pendingPayment,
                      textStyle: TextStyles.body16Medium.copyWith(fontWeight: FontWeight.w700, color: ColorCode.primary600),
                    ),
                    Gaps.vGap8,
                    CustomText(
                      "10",
                      textStyle: TextStyles.body16Medium.copyWith(fontWeight: FontWeight.w700, fontSize: 36.sp, color: ColorCode.primary600),
                    ),
                  ],
                ),
              ),
            ),
            Gaps.hGap16,
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient: const LinearGradient(
                    begin: AlignmentDirectional(-0.26, -1.0), // ~105 degrees
                    end: AlignmentDirectional(1.0, 0.3),
                    colors: [
                      Color.fromRGBO(19, 205, 120, 0.6),
                      Color.fromRGBO(116, 229, 177, 0.6),
                    ],
                    stops: [0.018, 0.9664], // 1.8% and 96.64%
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      AppStrings.paymentMade,
                      textStyle: TextStyles.body16Medium.copyWith(fontWeight: FontWeight.w700, color: ColorCode.primary600),
                    ),
                    Gaps.vGap8,
                    CustomText(
                      "10",
                      textStyle: TextStyles.body16Medium.copyWith(fontWeight: FontWeight.w700, fontSize: 36.sp, color: ColorCode.primary600),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
