import 'package:first_step/consts/colors.dart';
import 'package:first_step/consts/text_styles.dart';
import 'package:first_step/pages/center/control_panel/presentation/widgets/reports_table_center.dart';
import 'package:first_step/pages/center/control_panel/presentation/widgets/reports_table_two.dart';
import 'package:first_step/pages/parent/control_panel_parent/presentation/controllers/control_panel_parent_controller.dart';
import 'package:first_step/pages/parent/control_panel_parent/presentation/widgets/reports_table.dart';
import 'package:first_step/resources/strings_generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../routes/app_pages.dart';
import '../../../../../widgets/custom_text.dart';
import '../../../../../widgets/gaps.dart';
import '../controllers/control_panel_controller.dart';

class DailyReportCenter extends GetView<ControlPanelController> {
  const DailyReportCenter({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ControlPanelController>(builder: (controller) {
      return ListView(
        shrinkWrap: true,
        children: [
          CustomText(
            AppStrings.reports,
            textAlign: TextAlign.start,
            textStyle:
                TextStyles.title24Bold.copyWith(color: ColorCode.primary600),
          ),
          Gaps.vGap8,
          ReportsTableTwo(
            dailyReports: controller.dailyReports ?? [],
          ),
          Gaps.vGap24,
          InkWell(
            onTap: (){
              Get.toNamed(Routes.CHOOSE_PARENTS_SCREEN,arguments: controller.parents);
            },
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment(-0.15, -1.0),
                  // Approximate direction for 98.52 degrees
                  end: Alignment(1.0, 0.15),
                  colors: [
                    Color(0xFF7A8CFD),
                    Color(0xFF404FB1),
                    Color(0xFF2B3990),
                  ],
                  stops: [0.1117, 0.6374, 0.9471],
                ),
                borderRadius: BorderRadius.circular(16.r),
              ),
              padding: const EdgeInsets.symmetric(vertical: 10.5),
              margin: const EdgeInsets.symmetric(horizontal: 50),
              child: Center(
                child: CustomText(
                  AppStrings.writeAReport,
                  textStyle:
                      TextStyles.body16Medium.copyWith(color: ColorCode.white),
                ),
              ),
            ),
          ),
          Gaps.vGap24,
        ],
      );
    });
  }
}
