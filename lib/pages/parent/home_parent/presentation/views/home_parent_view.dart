import 'package:first_step/consts/colors.dart';
import 'package:first_step/consts/text_styles.dart';
import 'package:first_step/pages/parent/home_parent/models/services_model.dart';
import 'package:first_step/resources/assets_generated.dart';
import 'package:first_step/resources/assets_svg_generated.dart';
import 'package:first_step/services/auth_service.dart';
import 'package:first_step/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../../../../../resources/strings_generated.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../../widgets/gaps.dart';
import '../../../../../widgets/video_player.dart';
import '../../models/centers_model.dart';
import '../controllers/home_parent_controller.dart';
import '../widgets/center_card.dart';
import '../widgets/service_card.dart';

class HomeParentScreen extends GetView<HomeParentController> {
  const HomeParentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorCode.white,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: ColorCode.white, statusBarIconBrightness: Brightness.dark),
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: controller.onRefresh,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
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
                  Gaps.vGap26,
                  // Stack(
                  //   children: [
                  //     Container(
                  //       decoration: BoxDecoration(
                  //           gradient: const LinearGradient(
                  //             begin: Alignment.topCenter,
                  //             end: Alignment.bottomCenter,
                  //             colors: [
                  //               Color(0xFFFFFFFF),
                  //               Color(0xFFD5F3E5),
                  //               Color(0xFFD5F5E6),
                  //               Color(0xFFC4E7D7),
                  //               Color(0xFFD5F5E6),
                  //               Color(0xFFD5F3E5),
                  //               Color(0xFFFFFFFF),
                  //             ],
                  //             stops: [
                  //               0.0,
                  //               0.2163,
                  //               0.3808,
                  //               0.5227,
                  //               0.6587,
                  //               0.8317,
                  //               1.0,
                  //             ],
                  //           ),
                  //           borderRadius: BorderRadius.circular(16.r)),
                  //       child: Column(
                  //         children: [
                  //           Padding(
                  //             padding: const EdgeInsetsDirectional.only(
                  //                 top: 50, start: 16, end: 60),
                  //             child: CustomText(
                  //               maxLines: 3,
                  //               textAlign: TextAlign.start,
                  //               AppStrings
                  //                   .browseAndCompareTheBestNurseriesAndRehabilitationCentersInSaudiArabia,
                  //               textStyle: TextStyles.title24Bold.copyWith(
                  //                   fontSize: 20.sp,
                  //                   color: ColorCode.primary600),
                  //             ),
                  //           ),
                  //           const Stack(
                  //             alignment: AlignmentDirectional.bottomEnd,
                  //             children: [
                  //               PositionedDirectional(
                  //                 end: 90,
                  //                 child: Row(
                  //                   mainAxisAlignment: MainAxisAlignment.end,
                  //                   children: [
                  //                     Image(image: AppAssets.web),
                  //                   ],
                  //                 ),
                  //               ),
                  //               Row(
                  //                 mainAxisAlignment: MainAxisAlignment.end,
                  //                 children: [
                  //                   Image(image: AppAssets.phone),
                  //                 ],
                  //               ),
                  //               PositionedDirectional(
                  //                 end: 20,
                  //                 child: Row(
                  //                   mainAxisAlignment: MainAxisAlignment.end,
                  //                   children: [
                  //                     Image(image: AppAssets.family),
                  //                   ],
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //     Row(
                  //       mainAxisAlignment: MainAxisAlignment.end,
                  //       children: [
                  //         AppSVGAssets.getWidget(AppSVGAssets.sketshes),
                  //       ],
                  //     ),
                  //   ],
                  // ),
                  // Gaps.vGap24,
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
                                AppStrings.browseAndCompareTheBestNurseriesAndRehabilitationCentersInSaudiArabia,
                                textStyle: TextStyles.title24Bold.copyWith(fontSize: 20.sp, color: ColorCode.primary600),
                              ),
                            ),
                            const Stack(
                              alignment: AlignmentDirectional.bottomEnd,
                              children: [
                                PositionedDirectional(
                                  end: 90,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Image(image: AppAssets.web),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Image(image: AppAssets.phone),
                                  ],
                                ),
                                PositionedDirectional(
                                  end: 20,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Image(image: AppAssets.family),
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
                  Gaps.vGap16,
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
                              AppStrings.becauseYourChildFirstStep,
                              textStyle:
                                  TextStyles.title24Bold.copyWith(fontSize: 16.sp, color: ColorCode.secondaryOrange600, fontWeight: FontWeight.w800),
                            ),
                            Gaps.vGap5,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomText(
                                  AppStrings.weChose,
                                  textStyle: TextStyles.body16Medium
                                      .copyWith(color: ColorCode.secondaryOrange600, fontSize: 16.sp, fontWeight: FontWeight.w800),
                                ),
                                CustomText(
                                  " First Step",
                                  textStyle: TextStyles.title24Bold.copyWith(color: ColorCode.secondaryOrange600, fontWeight: FontWeight.w800),
                                ),
                                CustomText(
                                  " ${AppStrings.aNameForUs}",
                                  textStyle: TextStyles.body16Medium
                                      .copyWith(color: ColorCode.secondaryOrange600, fontSize: 16.sp, fontWeight: FontWeight.w800),
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
                  // const MuxVideoPlayer(playbackId: '01J3iEgcr7zrxGh1uQt6Wagp6M0286YVenlg8NgKKUMZQ',),
                  // const Image(image: AppAssets.video),
                  Gaps.vGap24,
                  CustomText(
                    AppStrings.firstStepServicesForParents,
                    textStyle: TextStyles.button12.copyWith(fontWeight: FontWeight.w700, color: ColorCode.neutral600),
                  ),
                  Gaps.vGap5,
                  Obx(() {
                    return controller.isServicesLoading.value
                        ? Center(
                            child: Column(
                              children: [
                                Gaps.vGap30,
                                const SpinKitCircle(
                                  color: ColorCode.primary600,
                                ),
                              ],
                            ),
                          )
                        : (controller.servicesParentResponseModel?.data?.isNotEmpty ?? false) && controller.servicesParentResponseModel != null
                            ? SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    ...List.generate(
                                      controller.servicesParentResponseModel?.data?.length ?? 0,
                                      (index) => ServiceCard(service: controller.servicesParentResponseModel?.data?[index] ?? Service()),
                                    ),
                                  ],
                                ),
                              )
                            : Center(
                                child: Column(
                                  children: [
                                    Gaps.vGap30,
                                    CustomText(AppStrings.noServicesFound),
                                  ],
                                ),
                              );
                  }),
                  Gaps.vGap24,
                  InkWell(
                    onTap: () {
                      Get.toNamed(Routes.SEARCH_PARENT);
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                AppSVGAssets.getWidget(AppSVGAssets.searchUnselected),
                                Gaps.hGap4,
                                CustomText(
                                  AppStrings.findACenterOrNursery,
                                  textStyle: TextStyles.button12.copyWith(color: ColorCode.neutral500),
                                ),
                              ],
                            ),
                            InkWell(
                                onTap: () {
                                  controller.openCitiesDialog(context);
                                },
                                child: AppSVGAssets.getWidget(AppSVGAssets.filter))
                          ],
                        ),
                      ),
                    ),
                  ),
                  Gaps.vGap8,
                  Obx(() {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ...List.generate(
                            controller.filters.length,
                            (index) => InkWell(
                              onTap: () async {
                                controller.selectedFilter.value = controller.filters[index];
                                await controller.getCentersWithFilter(filter: controller.selectedFilter.value);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                                margin: EdgeInsetsDirectional.only(end: 8.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(36.r),
                                  color: controller.selectedFilter.value == controller.filters[index] ? ColorCode.primary600 : ColorCode.white,
                                  border: Border.all(
                                      color:
                                          controller.selectedFilter.value == controller.filters[index] ? ColorCode.primary600 : ColorCode.neutral400),
                                ),
                                child: Center(
                                  child: CustomText(
                                    controller.filters[index],
                                    textStyle: TextStyles.body14Regular.copyWith(
                                        fontSize: 8.sp,
                                        color: controller.selectedFilter.value == controller.filters[index] ? ColorCode.white : ColorCode.neutral500),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  Gaps.vGap8,
                  Obx(() {
                    return controller.isCentersLoading.value
                        ? Center(
                            child: Column(
                              children: [
                                Gaps.vGap50,
                                const SpinKitCircle(
                                  color: ColorCode.primary600,
                                ),
                              ],
                            ),
                          )
                        : (controller.centersModel?.data?.isNotEmpty ?? false) && controller.centersModel != null
                            ? LayoutBuilder(
                                builder: (context, constraints) {
                                  // Calculate width for exactly 2 cards per row
                                  double screenWidth = constraints.maxWidth;
                                  double spacing = 16;
                                  double totalSpacing = spacing; // one spacing between two items
                                  double itemWidth = (screenWidth - totalSpacing) / 2;
                                  return Wrap(
                                    direction: Axis.horizontal,
                                    crossAxisAlignment: WrapCrossAlignment.start,
                                    runAlignment: WrapAlignment.start,
                                    verticalDirection: VerticalDirection.down,
                                    clipBehavior: Clip.none,
                                    runSpacing: 16,
                                    spacing: spacing,
                                    alignment: WrapAlignment.start,
                                    children: List.generate(
                                      controller.centersModel?.data?.length ?? 0,
                                      (index) {
                                        final center = controller.centersModel?.data?[index];
                                        return SizedBox(
                                          width: itemWidth,
                                          child: InkWell(
                                            onTap: () {
                                              Get.toNamed(Routes.CENTER_DETAILS_PARENT, arguments: {"center": center ?? NurseryModel()});
                                            },
                                            child: CenterCard(
                                              center: center ?? NurseryModel(),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                },
                              )

                            // LayoutBuilder(
                            //             builder: (context, constraints) {
                            //               return GridView.builder(
                            //                 shrinkWrap: true,
                            //                 physics:
                            //                     const NeverScrollableScrollPhysics(),
                            //                 itemCount:
                            //                     controller.centersModel?.data?.length ??
                            //                         0,
                            //                 gridDelegate:
                            //                     SliverGridDelegateWithMaxCrossAxisExtent(
                            //                         maxCrossAxisExtent:
                            //                             constraints.maxWidth / 2,
                            //                         crossAxisSpacing: 16,
                            //                         mainAxisSpacing: 16,
                            //                         childAspectRatio: .8),
                            //                 itemBuilder: (context, index) {
                            //                   final center =
                            //                       controller.centersModel?.data?[index];
                            //                   return InkWell(
                            //                     onTap: () {
                            //                       Get.toNamed(
                            //                           Routes.CENTER_DETAILS_PARENT,
                            //                           arguments: {
                            //                             "center":
                            //                                 center ?? NurseryModel()
                            //                           });
                            //                     },
                            //                     child: CenterCard(
                            //                       center: center ?? NurseryModel(),
                            //                     ),
                            //                   );
                            //                 },
                            //               );
                            //             },
                            //           )
                            : Center(
                                child: Column(
                                  children: [Gaps.vGap50, CustomText(AppStrings.noNurseriesFound), Gaps.vGap(100)],
                                ),
                              );
                  }),
                  Gaps.vGap(100),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
