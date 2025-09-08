import 'package:first_step/consts/colors.dart';
import 'package:first_step/consts/text_styles.dart';
import 'package:first_step/pages/center/home/presentation/views/widgets/feature_row.dart';
import 'package:first_step/pages/center/home/presentation/views/widgets/plan_card.dart';
import 'package:first_step/pages/parent/home_parent/models/services_model.dart';
import 'package:first_step/resources/assets_svg_generated.dart';
import 'package:first_step/resources/strings_generated.dart';
import 'package:first_step/services/auth_service.dart';
import 'package:first_step/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../widgets/gaps.dart';
import '../../../../../resources/assets_generated.dart';
import '../../../../../widgets/video_player.dart';
import '../../../../parent/home_parent/presentation/widgets/center_card.dart';
import '../../../../parent/home_parent/presentation/widgets/service_card.dart';
import '../../model/plans_model.dart';
import '../controllers/home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorCode.white,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: ColorCode.white, statusBarIconBrightness: Brightness.dark),
        toolbarHeight: 0,
      ),
      body: controller.obx(
          (state) => SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Gaps.vGap16,
                                CustomText(
                                  "${AppStrings.welcome} ${AuthService.to.userInfo?.user?.name ?? ""}",
                                  textStyle: TextStyles.button12.copyWith(fontWeight: FontWeight.w700, color: ColorCode.neutral600),
                                ),
                              ],
                            )
                          ],
                        ),
                        Gaps.vGap16,
                        Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color(0xFFFFFFFF),
                                      Color(0xFFD5F3E5),
                                      Color(0xFFD5F5E6),
                                      Color(0xFFC4E7D7),
                                      Color(0xFFD5F5E6),
                                      Color(0xFFD5F3E5),
                                      Color(0xFFFFFFFF),
                                    ],
                                    stops: [
                                      0.0,
                                      0.2163,
                                      0.3808,
                                      0.5227,
                                      0.6587,
                                      0.8317,
                                      1.0,
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(16.r)),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsetsDirectional.only(top: 50, start: 16, end: 60),
                                    child: CustomText(
                                      maxLines: 3,
                                      textAlign: TextAlign.start,
                                      AppStrings.TheFirstStepPlatformProvidesYouWithIntegratedToolsToManageYourCenterEfficientlyAndProfessionally,
                                      textStyle: TextStyles.title24Bold.copyWith(fontSize: 20.sp, color: ColorCode.primary600),
                                    ),
                                  ),
                                  const Stack(
                                    alignment: AlignmentDirectional.bottomEnd,
                                    children: [
                                      PositionedDirectional(
                                        end: 115,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Image(image: AppAssets.iphone),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Image(image: AppAssets.webCenter),
                                        ],
                                      ),
                                      PositionedDirectional(
                                        end: 75,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Image(image: AppAssets.woman),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                AppSVGAssets.getWidget(AppSVGAssets.sketshes),
                              ],
                            ),
                          ],
                        ),
                        Gaps.vGap26,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppSVGAssets.getWidget(AppSVGAssets.logoLeft),
                            Gaps.hGap4,
                            Expanded(
                              child: Column(
                                children: [
                                  CustomText(
                                    "\"${AppStrings.yourDigitalPresenceIsImportant}",
                                    textStyle: TextStyles.title24Bold
                                        .copyWith(fontSize: 16.sp, color: ColorCode.secondaryOrange600, fontWeight: FontWeight.w800),
                                  ),
                                  Gaps.vGap5,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomText(
                                        AppStrings.willHelpYou,
                                        textStyle: TextStyles.body16Medium
                                            .copyWith(color: ColorCode.secondaryOrange600, fontSize: 16.sp, fontWeight: FontWeight.w800),
                                      ),
                                      CustomText(
                                        " First Step",
                                        textStyle: TextStyles.title24Bold.copyWith(color: ColorCode.secondaryOrange600, fontWeight: FontWeight.w800),
                                      ),
                                      Expanded(
                                        child: CustomText(
                                          " ${AppStrings.toBoostIt}\"",
                                          textStyle: TextStyles.body16Medium
                                              .copyWith(color: ColorCode.secondaryOrange600, fontSize: 16.sp, fontWeight: FontWeight.w800),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Gaps.hGap4,
                            AppSVGAssets.getWidget(AppSVGAssets.logoRight),
                          ],
                        ),
                        Gaps.vGap16,
                        const MuxVideoPlayer(
                          playbackId: 'T8It02oFFSo401wcc00tTcn4WCbRW3CjO1qE0202ZyuBexLk',
                        ),
                        // const Image(image: AppAssets.video),
                        Gaps.vGap24,
                        Center(
                          child: CustomText(
                            AppStrings.firstStepFeatures,
                            textStyle: TextStyles.title24Bold.copyWith(fontWeight: FontWeight.w700, color: ColorCode.primary600),
                          ),
                        ),
                        Gaps.vGap8,
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              FeatureRow(
                                title: AppStrings.firstStepFeaturesOneTitle,
                                subtitle: AppStrings.firstStepFeaturesOneSubtitle,
                              ),
                              Gaps.hGap8,
                              FeatureRow(
                                title: AppStrings.firstStepFeaturesTwoTitle,
                                subtitle: AppStrings.firstStepFeaturesTwoSubtitle,
                              ),
                              Gaps.hGap8,
                              FeatureRow(
                                title: AppStrings.firstStepFeaturesThreeTitle,
                                subtitle: AppStrings.firstStepFeaturesThreeSubtitle,
                              ),
                              Gaps.hGap8,
                              FeatureRow(
                                title: AppStrings.firstStepFeaturesFourTitle,
                                subtitle: AppStrings.firstStepFeaturesFourSubtitle,
                              ),
                              Gaps.hGap8,
                              FeatureRow(
                                title: AppStrings.firstStepFeaturesFiveTitle,
                                subtitle: AppStrings.firstStepFeaturesFiveSubtitle,
                              ),
                              Gaps.hGap8,
                              FeatureRow(
                                title: AppStrings.firstStepFeaturesSixTitle,
                                subtitle: AppStrings.firstStepFeaturesSixSubtitle,
                              ),
                              Gaps.hGap8,
                              FeatureRow(
                                title: AppStrings.firstStepFeaturesSevenTitle,
                                subtitle: AppStrings.firstStepFeaturesSevenSubtitle,
                              ),
                            ],
                          ),
                        ),
                        Gaps.vGap16,
                        Center(
                          child: CustomText(
                            AppStrings.plansAndSubscriptions,
                            textStyle: TextStyles.title24Bold.copyWith(fontWeight: FontWeight.w700, fontSize: 16.sp, color: ColorCode.primary600),
                          ),
                        ),
                        Gaps.vGap16,
                        ...List.generate(
                          controller.plansModel?.data?.length ?? 0,
                          (index) => Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: PlanCard(
                              plan: controller.plansModel?.data?[index] ?? Plan(),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
          onLoading: const Center(
            child: SpinKitCircle(
              color: ColorCode.primary600,
            ),
          )),
    );
  }
}
