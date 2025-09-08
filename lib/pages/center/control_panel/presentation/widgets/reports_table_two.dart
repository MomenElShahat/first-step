import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:first_step/consts/colors.dart';
import 'package:first_step/consts/text_styles.dart';
import 'package:first_step/resources/strings_generated.dart';
import 'package:first_step/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../resources/assets_svg_generated.dart';
import '../../../../../services/auth_service.dart';
import '../../../../../widgets/custom_text.dart';
import '../../../../../widgets/gaps.dart';
import '../../../../parent/control_panel_parent/models/daily_reports_model.dart';
import '../controllers/control_panel_controller.dart';

class ReportsTableTwo extends GetView<ControlPanelController> {
  final List<DailyReport> dailyReports;

  const ReportsTableTwo({super.key, required this.dailyReports});

  @override
  Widget build(BuildContext context) {
    final paginatedDailyReports = dailyReports
        .skip((controller.currentPage - 1) * controller.rowsPerPage)
        .take(controller.rowsPerPage)
        .toList();

    final start = dailyReports.isNotEmpty
        ? ((controller.currentPage - 1) * controller.rowsPerPage + 1)
        : 0;

    final end = dailyReports.isNotEmpty
        ? (controller.currentPage * controller.rowsPerPage).clamp(1, dailyReports.length)
        : 0;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Table Header
        Container(
          color: ColorCode.primary600,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Row(
            children: [
              Expanded(flex: 1,
                  child: CustomText('------------',
                    textStyle: TextStyles.body14Regular.copyWith(
                        fontSize: 8.sp, color: ColorCode.white),)),
              Expanded(
                  flex: 3,
                  child: CustomText(
                    AppStrings.childName,
                    textStyle: TextStyles.body16Medium
                        .copyWith(color: ColorCode.white),
                  )),
              Expanded(
                  flex: 3,
                  child: CustomText(
                    AppStrings.nursery,
                    textStyle:
                    TextStyles.button12.copyWith(color: ColorCode.white),
                  )),
              Expanded(
                  flex: 3,
                  child: CustomText(
                    AppStrings.reportDate,
                    textStyle:
                    TextStyles.button12.copyWith(color: ColorCode.white),
                  )),
            ],
          ),
        ),

        // Table Rows
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: paginatedDailyReports.length,
          itemBuilder: (context, index) {
            final report = paginatedDailyReports[index];
            final childName = report.child?.name ?? AppStrings.notFound;
            final nursery = report.center?.branch?.name ?? AppStrings.notFound;
            final date = report.createdAt ?? '${DateTime.now()}';
            return InkWell(
              onTap: (){
                Get.toNamed(Routes.DAILY_REPORT_DETAILS_SCREEN,arguments: report.id.toString());
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    Expanded(flex: 1,
                        child: CustomText(
                          "${index + 1}", textStyle: TextStyles.body16Medium
                            .copyWith(color: ColorCode.neutral600),)),
                    Expanded(flex: 3,
                        child: CustomText(
                            childName, textStyle: TextStyles.body16Medium
                            .copyWith(color: ColorCode.neutral600))),
                    Expanded(flex: 3, child: CustomText(nursery, textStyle:
                    TextStyles.button12.copyWith(color: ColorCode.neutral600),)),
                    Expanded(flex: 3, child: CustomText(controller.formatDate(date), textStyle:
                    TextStyles.button12.copyWith(color: ColorCode.neutral600),)),
                  ],
                ),
              ),
            );
          },
        ),
        GetBuilder<ControlPanelController>(builder: (controller) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton2<int>(
                  underline: Container(),
                  customButton: Container(
                    padding:
                    const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                    // width: 44.w,
                    // height: 21.h,
                    decoration: BoxDecoration(
                      color: ColorCode.tableBg.withOpacity(.1),
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    child: Row(
                      children: [
                        AppSVGAssets.getWidget(AppSVGAssets.down,
                            color: ColorCode.primary600),
                        Gaps.hGap4,
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: CustomText(
                            controller.rowsPerPage.toString(),
                            textStyle: TextStyles.body14Regular.copyWith(
                                fontSize: 12.sp, color: ColorCode.primary600),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // buttonStyleData: ButtonStyleData(
                  //   padding:
                  //       const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                  //   width: 44.w,
                  //   height: 21.h,
                  //   decoration: BoxDecoration(
                  //     color: ColorCode.tableBg.withOpacity(.1),
                  //     borderRadius: BorderRadius.circular(5.r),
                  //   ),
                  // ),
                  menuItemStyleData: MenuItemStyleData(
                      height: 30.h,
                      padding: const EdgeInsetsDirectional.symmetric(
                          horizontal: 10)),
                  dropdownStyleData: DropdownStyleData(
                    decoration: BoxDecoration(
                      // color: ColorCode.tableBg.withOpacity(.1),
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                  ),
                  value: controller.rowsPerPage,
                  items: [10, 20, 30]
                      .map((e) => DropdownMenuItem(
                    value: e,
                    child: CustomText(
                      "$e",
                      textStyle: TextStyles.body14Regular.copyWith(
                          fontSize: 12.sp, color: ColorCode.primary600),
                    ),
                  ))
                      .toList(),
                  onChanged: (value) {
                    controller.rowsPerPage = value!;
                    controller.currentPage = 1;
                    controller.update();
                  },
                ),
                Gaps.hGap10,
                IconButton(
                  onPressed: controller.currentPage > 1
                      ? () {
                    controller.currentPage = 1;
                    controller.update();
                  }
                      : null,
                  icon: Icon(
                    AuthService.to.language == "ar"
                        ? Icons.first_page
                        : Icons.last_page,
                    color: ColorCode.primary600,
                  ),
                ),
                IconButton(
                  onPressed: controller.currentPage > 1
                      ? () {
                    controller.currentPage--;
                    controller.update();
                  }
                      : null,
                  icon: Icon(
                    AuthService.to.language == "ar"
                        ? Icons.chevron_left
                        : Icons.chevron_right,
                    color: ColorCode.primary600,
                  ),
                ),
                IconButton(
                  onPressed: controller.currentPage <
                      (dailyReports.length / controller.rowsPerPage).ceil()
                      ? () {
                    controller.currentPage++;
                    controller.update();
                  }
                      : null,
                  icon: Icon(
                    AuthService.to.language == "ar"
                        ? Icons.chevron_right
                        : Icons.chevron_left,
                    color: ColorCode.primary600,
                  ),
                ),
                IconButton(
                  onPressed: controller.currentPage <
                      (dailyReports.length / controller.rowsPerPage).ceil()
                      ? () {
                    controller.currentPage =
                        (dailyReports.length / controller.rowsPerPage).ceil();
                    controller.update();
                  }
                      : null,
                  icon: Icon(
                    AuthService.to.language == "ar"
                        ? Icons.last_page
                        : Icons.first_page,
                    color: ColorCode.primary600,
                  ),
                ),
                Gaps.hGap16,
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: CustomText(
                    '$start-$end ${AppStrings.from} ${dailyReports.length}',
                    textStyle: TextStyles.body14Regular.copyWith(color: ColorCode.primary600),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}
