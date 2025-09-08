import 'package:first_step/pages/parent/blog_parent/presentation/widgets/blog_card.dart';
import 'package:first_step/widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:first_step/pages/blog_details/presentation/controller/blog_details_controller.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../consts/colors.dart';
import '../../../../consts/text_styles.dart';
import '../../../../resources/assets_generated.dart';
import '../../../../resources/assets_svg_generated.dart';
import '../../../../resources/strings_generated.dart';
import '../../../../routes/app_pages.dart';
import '../../../../services/auth_service.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/gaps.dart';

class BlogDetailsScreen extends GetView<BlogDetailsController> {
  const BlogDetailsScreen({super.key});

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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: AppSVGAssets.getWidget(AppSVGAssets.slogan),
                        ),
                        Gaps.hGap4,
                        AppSVGAssets.getWidget(AppSVGAssets.signupLogo, fit: BoxFit.fill),
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
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                CachedImage(
                                  url: controller.blog?.file ?? "",
                                  width: Get.width,
                                  height: 200.h,
                                  placeHolder: Image(
                                    image: AppAssets.blogPage,
                                    fit: BoxFit.fill,
                                    width: Get.width,
                                  ),
                                ),
                                PositionedDirectional(
                                  bottom: -150,
                                  start: 0,
                                  end: 0,
                                  child: AppSVGAssets.getWidget(AppSVGAssets.curve, fit: BoxFit.contain),
                                ),
                              ],
                            ),
                            Gaps.vGap16,
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: CustomText(
                                (controller.blog?.title is String
                                        ? controller.blog?.title.toString()
                                        : AuthService.to.language == "ar"
                                            ? controller.blog?.title?.ar ?? ""
                                            : controller.blog?.title?.en ?? "") ??
                                    "",
                                textAlign: TextAlign.start,
                                textStyle: TextStyles.title32Bold.copyWith(fontSize: 12.sp, color: ColorCode.primary600),
                              ),
                            ),
                            Gaps.vGap16,
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: CustomText(
                                (controller.blog?.description is String
                                        ? controller.blog?.description.toString()
                                        : AuthService.to.language == "ar"
                                            ? controller.blog?.description?.ar ?? ""
                                            : controller.blog?.description?.en ?? "") ??
                                    "",
                                maxLines: 10,
                                textAlign: TextAlign.start,
                                textStyle: TextStyles.body14Regular.copyWith(fontSize: 8.sp, color: ColorCode.neutral600),
                              ),
                            ),
                            Gaps.vGap16,
                            Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: HtmlWidget(
                                  (controller.blog?.content is String
                                          ? controller.blog?.content.toString()
                                          : AuthService.to.language == "ar"
                                              ? controller.blog?.content?.ar ?? ""
                                              : controller.blog?.content?.en ?? "") ??
                                      "",
                                )),
                            Gaps.vGap16,
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 16),
                              padding: const EdgeInsets.all(16),
                              width: Get.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24.r),
                                gradient: const LinearGradient(
                                  begin: Alignment(-0.17, -1), // Approximation based on 98.5deg
                                  end: Alignment(1, 0.17),
                                  colors: [
                                    Color(0xFF7A8CFD),
                                    Color(0xFF404FB1),
                                    Color(0xFF2B3990),
                                  ],
                                  stops: [0.1117, 0.6374, 0.9471],
                                ),
                              ),
                              child: Column(
                                children: [
                                  Transform.rotate(
                                    angle: 3.73 * 3.1415926535 / 180,
                                    child: Image(
                                      image: AppAssets.searchingFavorites,
                                      fit: BoxFit.fill,
                                      width: 136.08.w,
                                      height: 120.h,
                                    ),
                                  ),
                                  Gaps.vGap16,
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomText(
                                        AppStrings.weShowYou,
                                        textStyle: TextStyles.title24Bold
                                            .copyWith(height: 1, fontSize: 8.sp, color: ColorCode.white, fontWeight: FontWeight.w700),
                                      ),
                                      Gaps.hGap8,
                                      CustomText(
                                        AppStrings.nurseriesKindergartensAndTreatmentCenters,
                                        textStyle: GoogleFonts.tillana(
                                          textStyle: TextStyles.title24Bold.copyWith(
                                            fontSize: 12.sp,
                                            height: 1,
                                            fontWeight: FontWeight.w800,
                                            color: ColorCode.warning600,
                                          ),
                                        ),
                                      ),
                                      Gaps.hGap4,
                                      CustomText(
                                        AppStrings.trustedForChildren,
                                        textStyle: TextStyles.title24Bold
                                            .copyWith(height: 1, fontSize: 8.sp, color: ColorCode.white, fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                  Gaps.vGap16,
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomText(
                                        AppStrings.inDifferentCitiesWithClearDetailsEducationalProgramsAndRealExperiencesFromParents,
                                        textStyle: TextStyles.title24Bold
                                            .copyWith(height: 1, fontSize: 8.sp, color: ColorCode.white, fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                  Gaps.vGap16,
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomText(
                                        AppStrings.soYouCanMakeYourDecisionWithConfidenceAndPeaceOfMind,
                                        textStyle: GoogleFonts.tillana(
                                          textStyle: TextStyles.title24Bold.copyWith(
                                            fontSize: 12.sp,
                                            height: 1,
                                            fontWeight: FontWeight.w800,
                                            color: ColorCode.warning600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Gaps.vGap16,
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomText(
                                        AppStrings.dontLeaveIt,
                                        textStyle: TextStyles.title24Bold
                                            .copyWith(height: 1, fontSize: 8.sp, color: ColorCode.white, fontWeight: FontWeight.w700),
                                      ),
                                      Gaps.hGap8,
                                      CustomText(
                                        AppStrings.byChance,
                                        textStyle: GoogleFonts.tillana(
                                          textStyle: TextStyles.title24Bold.copyWith(
                                            fontSize: 12.sp,
                                            height: 1,
                                            fontWeight: FontWeight.w800,
                                            color: ColorCode.warning600,
                                          ),
                                        ),
                                      ),
                                      Gaps.hGap4,
                                      CustomText(
                                        AppStrings.startNowAndSaveForYourChild,
                                        textStyle: TextStyles.title24Bold
                                            .copyWith(height: 1, fontSize: 8.sp, color: ColorCode.white, fontWeight: FontWeight.w700),
                                      ),
                                      Gaps.hGap4,
                                      CustomText(
                                        AppStrings.theAppropriateEnvironmentForHim,
                                        textStyle: GoogleFonts.tillana(
                                          textStyle: TextStyles.title24Bold.copyWith(
                                            fontSize: 12.sp,
                                            height: 1,
                                            fontWeight: FontWeight.w800,
                                            color: ColorCode.warning600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Gaps.vGap16,
                                  InkWell(
                                    onTap: () {
                                      Get.toNamed(Routes.SEARCH_PARENT);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8.r),
                                        border: Border.all(color: ColorCode.primary600),
                                        color: ColorCode.white,
                                      ),
                                      padding: const EdgeInsets.symmetric(vertical: 10.5),
                                      margin: const EdgeInsets.symmetric(horizontal: 16),
                                      child: Center(
                                        child: CustomText(
                                          AppStrings.exploreTheNurseryNow,
                                          textStyle: TextStyles.body16Medium.copyWith(fontWeight: FontWeight.w700, color: ColorCode.primary600),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Gaps.vGap16,
                            Center(
                              child: CustomText(
                                AppStrings.relatedBlog,
                                textStyle: TextStyles.title24Bold.copyWith(color: ColorCode.primary600),
                              ),
                            ),
                            Gaps.vGap16,
                            SizedBox(
                              height: 180.h,
                              child: ListView.builder(
                                clipBehavior: Clip.none,
                                itemBuilder: (context, index) => SizedBox(
                                  width: 180.w,
                                  height: 180.h,
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.only(end: 8),
                                    child: BlogCard(blog: controller.blogs![index], blogs: controller.blogs!),
                                  ),
                                ),
                                itemCount: controller.blogs?.length ?? 0,
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                              ),
                            ),
                            Gaps.vGap16,
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
