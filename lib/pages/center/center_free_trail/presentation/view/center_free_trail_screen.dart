import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../consts/colors.dart';
import '../../../../../consts/text_styles.dart';
import '../../../../../resources/assets_generated.dart';
import '../../../../../resources/strings_generated.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../../widgets/custom_text.dart';
import '../../../../../widgets/gaps.dart';
import '../controller/center_free_trail_controller.dart';

class CenterFreeTrailScreen extends GetView<CenterFreeTrailController> {
  const CenterFreeTrailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent, // <-- important
          statusBarIconBrightness: Brightness.light,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
                colors: [
                  Color(0xFF7A8CFD),
                  Color(0xFF404FB1),
                  Color(0xFF2B3990),
                ],
                stops: [0.1117, 0.6374, 0.9471],
                transform: GradientRotation(98.52 * (3.14159265359 / 180)),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.r),
              color: Colors.transparent,
            ),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Gaps.vGap32,
                  Center(
                    child: CustomText(
                      AppStrings.forOneMonthFree,
                      textStyle: GoogleFonts.tillana(
                        textStyle: TextStyles.title24Bold.copyWith(
                          fontSize: 36.sp,
                          height: 1,
                          fontWeight: FontWeight.w800,
                          color: ColorCode.warning600,
                        ),
                      ),
                    ),
                  ),
                  Gaps.vGap32,
                  Center(
                    child: CustomText(
                      AppStrings.enjoyAllTheFeaturesOfFirstStepFor,
                      textStyle: TextStyles.title24Bold.copyWith(height: 1, color: ColorCode.white),
                    ),
                  ),
                  Gaps.vGap32,
                  CustomText(
                    AppStrings.limitedTimeOffer,
                    textStyle: GoogleFonts.tillana(
                      textStyle: TextStyles.title24Bold.copyWith(
                        fontSize: 16.sp,
                        height: 1,
                        fontWeight: FontWeight.w800,
                        color: ColorCode.warning600,
                      ),
                    ),
                  ),
                  Gaps.vGap32,
                  const Center(
                    child: Image(
                      image: AppAssets.gift,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Gaps.vGap32,
                  InkWell(
                    onTap: () {
                      Get.toNamed(Routes.SIGNUP);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      margin: const EdgeInsetsDirectional.symmetric(horizontal: 50),
                      decoration: BoxDecoration(
                        color: ColorCode.white,
                        border: Border.all(color: ColorCode.primary600),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Center(
                        child: CustomText(
                          AppStrings.subscribeNowForFree,
                          textStyle: TextStyles.body16Medium.copyWith(fontWeight: FontWeight.w700, color: ColorCode.primary600),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          PositionedDirectional(
            top: 80,
            end: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: CustomText(
                    AppStrings.back,
                    textStyle: TextStyles.body16Medium.copyWith(color: ColorCode.white, fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
