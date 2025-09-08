import 'package:first_step/consts/colors.dart';
import 'package:first_step/consts/text_styles.dart';
import 'package:first_step/resources/assets_svg_generated.dart';
import 'package:first_step/resources/strings_generated.dart';
import 'package:first_step/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../widgets/gaps.dart';
import '../../../../../resources/assets_generated.dart';
import '../../../../parent/home_parent/presentation/widgets/center_card.dart';
import '../controllers/notifications_controller.dart';

class NotificationsScreen extends GetView<NotificationsScreenController> {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorCode.white,
      extendBodyBehindAppBar: true,
      body: AnnotatedRegion(
        value: const SystemUiOverlayStyle(statusBarColor: ColorCode.secondary600),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                // height: 200.h,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: ColorCode.secondary600,
                ),
                child: Stack(
                  children: [
                    const Positioned.fill(
                      child: Image(
                        image: AppAssets.clouds,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SafeArea(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
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
                                    AppSVGAssets.getWidget(AppSVGAssets.signupLogo),
                                    Gaps.hGap4,
                                    AppSVGAssets.getWidget(AppSVGAssets.slogan),
                                  ],
                                ),
                                CustomText(
                                  "${AppStrings.welcome} زياد",
                                  textStyle: TextStyles.button12.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: ColorCode.neutral600,
                                  ),
                                ),
                              ],
                            ),
                            Gaps.vGap30,

                            // 🔍 Notifications bar
                            // Card(
                            //   shape: RoundedRectangleBorder(
                            //     borderRadius: BorderRadius.circular(16),
                            //   ),
                            //   child: Padding(
                            //     padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
                            //     child: Row(
                            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //       children: [
                            //         Row(
                            //           children: [
                            //             AppSVGAssets.getWidget(AppSVGAssets.NotificationsUnselected),
                            //             Gaps.hGap8,
                            //             CustomText(
                            //               AppStrings.findACenterOrNursery,
                            //               textStyle: TextStyles.button12.copyWith(
                            //                 color: ColorCode.neutral500,
                            //               ),
                            //             ),
                            //           ],
                            //         ),
                            //         AppSVGAssets.getWidget(AppSVGAssets.filter),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // 📜 Scrollable content (list only)
              // Expanded(
              //   child: Padding(
              //     padding: const EdgeInsets.symmetric(horizontal: 16),
              //     child: ListView.builder(
              //       padding: const EdgeInsets.only(top: 16, bottom: 32),
              //       itemCount: controller.isFav.length + 1,
              //       itemBuilder: (context, index) {
              //         if (index == 0) {
              //           return Column(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               CustomText(
              //                 AppStrings.recentSearches,
              //                 textStyle: TextStyles.title32Bold.copyWith(
              //                   fontSize: 8.sp,
              //                   color: ColorCode.neutral500,
              //                 ),
              //               ),
              //               Gaps.vGap8,
              //             ],
              //           );
              //         } else {
              //           return CenterCard(isFav: controller.isFav[index - 1]);
              //         }
              //       },
              //     ),
              //   ),
              // ),
              // Gaps.vGap(100),
            ],
          ),
        ),
      ),
    );
  }
}
