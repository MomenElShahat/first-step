import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../consts/colors.dart';
import '../../../../../consts/text_styles.dart';
import '../../../../../resources/strings_generated.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../../widgets/custom_text.dart';
import '../../../../../widgets/gaps.dart';
import '../../../control_panel/presentation/widgets/reports_table_center.dart';
import '../controller/choose_parents_controller.dart';

class ChooseParentsScreen extends GetView<ChooseParentsController> {
  const ChooseParentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorCode.white,
      extendBodyBehindAppBar: true,
      body: AnnotatedRegion(
        value: const SystemUiOverlayStyle(
            statusBarColor: ColorCode.white, statusBarBrightness: Brightness.dark, statusBarIconBrightness: Brightness.dark),
        child: SafeArea(
          child: Column(
            children: [
              Gaps.vGap16,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Row(
                    //   children: [
                    //     Padding(
                    //       padding: const EdgeInsets.only(top: 10),
                    //       child: AppSVGAssets.getWidget(AppSVGAssets.slogan),
                    //     ),
                    //     Gaps.hGap4,
                    //     AppSVGAssets.getWidget(AppSVGAssets.signupLogo,
                    //         fit: BoxFit.fill),
                    //   ],
                    // ),
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(Icons.arrow_forward_ios_outlined),
                    ),
                  ],
                ),
              ),

              // 📜 Scrollable content (list only)
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Gaps.vGap(14),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomText(
                                  AppStrings.reports,
                                  textStyle: TextStyles.title24Bold.copyWith(color: ColorCode.primary600),
                                ),
                              ],
                            ),
                            Gaps.vGap8,
                            ReportsTableCenter(
                              parents: controller.parents ?? [],
                            ),
                            Gaps.vGap24,
                            InkWell(
                              onTap: () {
                                Get.toNamed(Routes.SEND_DAILY_REPORT_SCREEN, arguments: controller.getSelectedChildIdsForApi());
                                debugPrint("getSelectedChildIdsForApi ${controller.getSelectedChildIdsForApi()}");
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
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 10.5),
                                margin: const EdgeInsets.symmetric(horizontal: 50),
                                child: Center(
                                  child: CustomText(
                                    AppStrings.writeAReport,
                                    textStyle: TextStyles.body16Medium.copyWith(color: ColorCode.white),
                                  ),
                                ),
                              ),
                            ),
                            Gaps.vGap24,
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Gaps.vGap(100),
            ],
          ),
        ),
      ),
    );
  }
}
