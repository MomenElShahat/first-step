import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:first_step/pages/terms/presentation/controller/terms_controller.dart';
import '../../../../consts/colors.dart';
import '../../../../resources/assets_svg_generated.dart';
import '../../../../widgets/gaps.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class TermsScreen extends GetView<TermsController> {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorCode.white,
      extendBodyBehindAppBar: true,
      body: AnnotatedRegion(
        value: SystemUiOverlayStyle(),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                // height: 200.h,
                width: double.infinity,
                decoration: const BoxDecoration(
                  // gradient: LinearGradient(
                  //   begin: Alignment(-0.15, -1.0),
                  //   // Approximate direction for 98.52 degrees
                  //   end: Alignment(1.0, 0.15),
                  //   colors: [
                  //     Color(0xFF7A8CFD),
                  //     Color(0xFF404FB1),
                  //     Color(0xFF2B3990),
                  //   ],
                  //   stops: [0.1117, 0.6374, 0.9471],
                  // ),
                ),
                child: Stack(
                  children: [
                    // const Positioned.fill(
                    //   child: Image(
                    //     image: AppAssets.clouds,
                    //     fit: BoxFit.cover,
                    //   ),
                    // ),
                    SafeArea(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 16.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 👋 Greeting & logo
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: AppSVGAssets.getWidget(
                                          AppSVGAssets.slogan),
                                    ),
                                    Gaps.hGap4,
                                    AppSVGAssets.getWidget(
                                        AppSVGAssets.signupLogo,
                                        fit: BoxFit.fill),
                                  ],
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: const Icon(Icons.arrow_forward_ios_outlined),
                                ),
                              ],
                            ),
                            // Gaps.vGap20,
                          ],
                        ),
                      ),
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
                          children: [
                            // Gaps.vGap(14),
                            Obx(() {
                              return Padding(
                                padding: const EdgeInsets.all(16),
                                child: Visibility(
                                    visible:
                                    controller.isTermsLoading.value == false,
                                    replacement: const Center(
                                        child: SpinKitCircle(
                                          color: ColorCode.primary600,
                                        )),
                                    child: HtmlWidget(controller.terms ?? "")),
                              );
                            })
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
