import 'package:first_step/consts/colors.dart';
import 'package:first_step/consts/text_styles.dart';
import 'package:first_step/pages/parent/control_panel_parent/presentation/controllers/control_panel_parent_controller.dart';
import 'package:first_step/pages/parent/control_panel_parent/presentation/widgets/reports_table.dart';
import 'package:first_step/resources/assets_generated.dart';
import 'package:first_step/resources/strings_generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../../../../../widgets/custom_text.dart';
import '../../../../../widgets/gaps.dart';

class DailyReports extends GetView<ControlPanelParentController> {
  const DailyReports({super.key});

  @override
  Widget build(BuildContext context) {
    return controller.obx(
        (state) =>
            GetBuilder<ControlPanelParentController>(builder: (controller) {
              return ListView(
                padding: const EdgeInsets.only(bottom: 16),
                children: [
                  SizedBox(
                    height: 230.h,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.children?.length ?? 0,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          if (controller.children?[index].reportsCount != 0) {
                            controller.toggleChildFilter(
                                controller.children?[index].id ?? 0);
                          }
                        },
                        child: Container(
                          margin: const EdgeInsetsDirectional.only(end: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(
                                color: controller.isChildSelected(
                                        controller.children?[index].id ?? 0)
                                    ? (controller.children?[index].gender ==
                                            "boy"
                                        ? ColorCode.secondary600
                                        : ColorCode.secondaryBurgundy600)
                                    : ColorCode.neutral400),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              CustomText(
                                "${controller.children?[index].reportsCount.toString()}",
                                textStyle: TextStyles.body16Medium.copyWith(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w500,
                                    color: controller.isChildSelected(
                                            controller.children?[index].id ?? 0)
                                        ? ColorCode.primary600
                                        : ColorCode.neutral500),
                              ),
                              Gaps.vGap8,
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Image(
                                    image: controller.isChildSelected(
                                            controller.children?[index].id ?? 0)
                                        ? (controller.children?[index].gender ==
                                                "boy"
                                            ? AppAssets.boyFill
                                            : AppAssets.girlFill)
                                        : controller.children?[index].gender ==
                                                "boy"
                                            ? AppAssets.boy
                                            : AppAssets.girl),
                              ),
                              Gaps.vGap8,
                              CustomText(
                                controller.children?[index].childName ?? "",
                                textStyle: TextStyles.body16Medium.copyWith(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w500,
                                    color: controller.isChildSelected(
                                            controller.children?[index].id ?? 0)
                                        ? ColorCode.primary600
                                        : ColorCode.neutral500),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Gaps.vGap16,
                  CustomText(
                    AppStrings.reports,
                    textAlign: TextAlign.start,
                    textStyle: TextStyles.title24Bold
                        .copyWith(color: ColorCode.primary600),
                  ),
                  Gaps.vGap8,
                  ReportsTable(
                    dailyReports: controller.dailyReports ?? [],
                  ),
                ],
              );
            }),
        onLoading: Column(
          children: [
            SizedBox(
              height: Get.height / 3,
            ),
            const Center(
              child: SpinKitCircle(
                color: ColorCode.primary600,
              ),
            ),
          ],
        ));
  }
}
