import 'package:cached_network_image/cached_network_image.dart';
import 'package:first_step/consts/colors.dart';
import 'package:first_step/consts/text_styles.dart';
import 'package:first_step/resources/assets_generated.dart';
import 'package:first_step/resources/assets_svg_generated.dart';
import 'package:first_step/routes/app_pages.dart';
import 'package:first_step/widgets/cached_image.dart';
import 'package:first_step/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import '../../../../../resources/strings_generated.dart';
import '../../../../../widgets/gaps.dart';
import '../../../home_parent/models/centers_model.dart';
import '../../../home_parent/presentation/widgets/branches_dropdown.dart';
import '../controllers/center_details_parent_controller.dart';
import '../widgets/ads_slider.dart';
import '../widgets/ages_dropdown.dart';
import '../widgets/locations_stepper.dart';
import '../widgets/plans_slider.dart';
import '../widgets/portfolio_progress_bar.dart';
import '../widgets/services_slider.dart';
import '../widgets/team_slider.dart';
import '../widgets/types_dropdown.dart';

class CenterDetailsParentScreen extends GetView<CenterDetailsParentController> {
  const CenterDetailsParentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorCode.white,
      appBar: AppBar(
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: ColorCode.white),
        toolbarHeight: 0,
      ),
      body: controller.obx((state) {
        if (controller.percentage == 100) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 7),
                              child:
                                  AppSVGAssets.getWidget(AppSVGAssets.slogan),
                            ),
                            Gaps.hGap4,
                            AppSVGAssets.getWidget(AppSVGAssets.signupLogo),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Gaps.vGap16,
                          InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: const Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: ColorCode.primary600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Gaps.vGap26,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Stack(
                    children: [
                      controller.centerPortfolioModel?.data?.heroSection
                                      ?.backgroundImage !=
                                  null &&
                              (controller
                                      .centerPortfolioModel
                                      ?.data
                                      ?.heroSection
                                      ?.backgroundImage
                                      ?.isNotEmpty ??
                                  false)
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(16.r),
                              child: CachedNetworkImage(
                                height: 200.h,
                                width: double.infinity,
                                imageUrl: controller.centerPortfolioModel?.data
                                        ?.heroSection?.backgroundImage ??
                                    "",
                                fit: BoxFit.fill,
                                placeholder: (context, url) => AspectRatio(
                                  aspectRatio: 1,
                                  child: Container(color: Colors.grey.shade200),
                                ),
                                errorWidget: (context, url, error) =>
                                    AspectRatio(
                                  aspectRatio: 1,
                                  child: Container(
                                    color: Colors.grey.shade300,
                                    child: const Icon(Icons.error),
                                  ),
                                ),
                              ),
                            )
                          : const Image(
                              image: AppAssets.centerImage,
                              width: double.infinity,
                              fit: BoxFit.fill,
                            ),
                      PositionedDirectional(
                        bottom: 10,
                        start: 66,
                        end: 66,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(36),
                            color: ColorCode.white,
                          ),
                          child: Column(
                            children: [
                              Gaps.vGap8,
                              CustomText(
                                controller.centerPortfolioModel?.data
                                        ?.heroSection?.titleOfHero ??
                                    "",
                                textStyle: TextStyles.button12.copyWith(
                                    color: ColorCode.primary600,
                                    fontWeight: FontWeight.w700),
                              ),
                              Gaps.vGap8,
                              CustomText(
                                controller.centerPortfolioModel?.data
                                        ?.heroSection?.subtitleOfHero ??
                                    "",
                                textStyle: TextStyles.button14.copyWith(
                                    color: ColorCode.secondary600,
                                    fontSize: 8.sp),
                              ),
                              Gaps.vGap8,
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: CustomText(
                                  controller.centerPortfolioModel?.data
                                          ?.heroSection?.description ??
                                      "",
                                  maxLines: 3,
                                  textStyle: TextStyles.button14.copyWith(
                                      color: ColorCode.neutral500,
                                      fontSize: 8.sp),
                                ),
                              ),
                              Gaps.vGap8,
                              // InkWell(
                              //   onTap: () {
                              //     Get.toNamed(Routes.BOOKING_SCREEN);
                              //   },
                              //   child: Container(
                              //     decoration: BoxDecoration(
                              //       borderRadius: BorderRadius.circular(36),
                              //       color: ColorCode.primary600,
                              //     ),
                              //     width: 90.w,
                              //     height: 20.h,
                              //     child: Center(
                              //       child: CustomText(
                              //         AppStrings.bookForYourChildNow,
                              //         textStyle: TextStyles.button14.copyWith(
                              //             color: ColorCode.white, fontSize: 8.sp),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              // Gaps.vGap8,
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Gaps.vGap24,
                if (controller
                        .centerPortfolioModel?.data?.branches?.isNotEmpty ??
                    false) ...[
                  Center(
                    child: CustomText(
                      AppStrings.nurseryBranches,
                      textStyle: TextStyles.body16Medium.copyWith(
                          fontWeight: FontWeight.w700,
                          color: ColorCode.secondaryBurgundy600),
                    ),
                  ),
                  Gaps.vGap24,
                  TimelineScreen(
                    locationNames:
                        controller.centerPortfolioModel?.data?.branches ?? [],
                    colors: controller.colors,
                  ),
                  Gaps.vGap24,
                ],
                if (controller
                        .centerPortfolioModel?.data?.adsImages?.isNotEmpty ??
                    false) ...[
                  AdsSlider(
                    ads: controller.centerPortfolioModel?.data?.adsImages ?? [],
                  ),
                  Gaps.vGap24,
                ],
                if (controller.centerPortfolioModel?.data
                            ?.philosophyMethodologyGoal?.philosophy?.content !=
                        null &&
                    controller.centerPortfolioModel?.data
                            ?.philosophyMethodologyGoal?.methodology?.content !=
                        null &&
                    controller.centerPortfolioModel?.data
                            ?.philosophyMethodologyGoal?.goals?.content !=
                        null) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Card(
                      elevation: 5,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadiusDirectional.only(
                          topStart: Radius.circular(36),
                          bottomEnd: Radius.circular(36),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  CustomText(
                                    AppStrings.ourPhilosophy,
                                    textStyle: TextStyles.body16Medium.copyWith(
                                        fontWeight: FontWeight.w700,
                                        color: ColorCode.secondaryBurgundy600),
                                  ),
                                  Gaps.vGap4,
                                  const Image(image: AppAssets.philosophy),
                                  CustomText(
                                    controller
                                            .centerPortfolioModel
                                            ?.data
                                            ?.philosophyMethodologyGoal
                                            ?.philosophy
                                            ?.content ??
                                        "",
                                    maxLines: 10,
                                    textStyle: TextStyles.button14.copyWith(
                                        fontSize: 4.sp,
                                        color: ColorCode.neutral600),
                                  ),
                                ],
                              ),
                            ),
                            Gaps.hGap(24),
                            Expanded(
                              child: Column(
                                children: [
                                  CustomText(
                                    AppStrings.ourMethodology,
                                    textStyle: TextStyles.body16Medium.copyWith(
                                        fontWeight: FontWeight.w700,
                                        color: ColorCode.secondaryBurgundy600),
                                  ),
                                  Gaps.vGap4,
                                  const Image(image: AppAssets.methodology),
                                  CustomText(
                                    controller
                                            .centerPortfolioModel
                                            ?.data
                                            ?.philosophyMethodologyGoal
                                            ?.methodology
                                            ?.content ??
                                        "",
                                    maxLines: 10,
                                    textStyle: TextStyles.button14.copyWith(
                                        fontSize: 4.sp,
                                        color: ColorCode.neutral600),
                                  ),
                                ],
                              ),
                            ),
                            Gaps.hGap(24),
                            Expanded(
                              child: Column(
                                children: [
                                  CustomText(
                                    AppStrings.ourGoal,
                                    textStyle: TextStyles.body16Medium.copyWith(
                                        fontWeight: FontWeight.w700,
                                        color: ColorCode.secondaryBurgundy600),
                                  ),
                                  Gaps.vGap8,
                                  const Image(image: AppAssets.goal),
                                  CustomText(
                                    controller
                                            .centerPortfolioModel
                                            ?.data
                                            ?.philosophyMethodologyGoal
                                            ?.goals
                                            ?.content ??
                                        "",
                                    maxLines: 10,
                                    textStyle: TextStyles.button14.copyWith(
                                        fontSize: 8.sp,
                                        color: ColorCode.neutral600),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Gaps.vGap24,
                ],
                if (controller
                        .centerPortfolioModel?.data?.services?.isNotEmpty ??
                    false) ...[
                  Center(
                    child: CustomText(
                      AppStrings.nurseryServices,
                      textStyle: TextStyles.body16Medium.copyWith(
                          fontWeight: FontWeight.w700,
                          color: ColorCode.secondaryBurgundy600),
                    ),
                  ),
                  Gaps.vGap24,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ServicesSlider(
                      services:
                          controller.centerPortfolioModel?.data?.services ?? [],
                    ),
                  ),
                  Gaps.vGap24,
                ],
                if (controller
                            .centerPortfolioModel?.data?.nurseryState?.area !=
                        null &&
                    controller.centerPortfolioModel?.data?.nurseryState
                            ?.classRooms !=
                        null &&
                    controller.centerPortfolioModel?.data?.nurseryState
                            ?.teamMembers !=
                        null) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          AppSVGAssets.getWidget(AppSVGAssets.building),
                          Gaps.vGap12,
                          CustomText(
                            controller.centerPortfolioModel?.data?.nurseryState
                                    ?.area ??
                                "",
                            textStyle: TextStyles.title32Bold.copyWith(
                                color: ColorCode.secondaryBurgundy600),
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: AppStrings.nurserySpace,
                                  style: TextStyles.button12.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: ColorCode.secondaryBurgundy600),
                                ),
                                TextSpan(
                                  text: " / ",
                                  style: TextStyles.button12.copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16.sp,
                                      color: ColorCode.secondaryBurgundy600),
                                ),
                                TextSpan(
                                  text: AppStrings.squareMeter,
                                  style: TextStyles.button12.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: ColorCode.secondaryBurgundy600),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          AppSVGAssets.getWidget(AppSVGAssets.lesson),
                          Gaps.vGap12,
                          CustomText(
                            controller.centerPortfolioModel?.data?.nurseryState
                                    ?.classRooms ??
                                "",
                            textStyle: TextStyles.title32Bold
                                .copyWith(color: ColorCode.primary600),
                          ),
                          CustomText(
                            AppStrings.numberOfClasses,
                            textStyle: TextStyles.button12.copyWith(
                                color: ColorCode.primary600,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          AppSVGAssets.getWidget(AppSVGAssets.people),
                          Gaps.vGap12,
                          CustomText(
                            controller.centerPortfolioModel?.data?.nurseryState
                                    ?.teamMembers ??
                                "",
                            textStyle: TextStyles.title32Bold
                                .copyWith(color: ColorCode.secondary600),
                          ),
                          CustomText(
                            "${AppStrings.team} ${controller.center?.nurseryName ?? ""}",
                            textStyle: TextStyles.button12.copyWith(
                                color: ColorCode.secondary600,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Gaps.vGap24,
                ],
                if (controller.centerPortfolioModel?.data?.teams?.isNotEmpty ??
                    false) ...[
                  Center(
                    child: CustomText(
                      "${AppStrings.team} ${controller.center?.nurseryName ?? ""}",
                      textStyle: TextStyles.button12.copyWith(
                          color: ColorCode.secondary600,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Gaps.vGap24,
                  controller.centerPortfolioModel?.data?.teams?.isEmpty ?? false
                      ? Center(
                          child: CustomText(
                            AppStrings.noTeamsAvailable,
                            textStyle: TextStyles.body16Medium,
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: TeamSlider(
                            team:
                                controller.centerPortfolioModel?.data?.teams ??
                                    [],
                          ),
                        ),
                  Gaps.vGap24,
                ],
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        AppStrings.ourPrograms,
                        textStyle: TextStyles.title24Bold.copyWith(
                          color: ColorCode.primary600,
                        ),
                      ),
                      GetBuilder<CenterDetailsParentController>(
                        builder: (controller) {
                          return BranchesDropdownParent(
                            selectedValue: controller.selectedBranch,
                            isError: controller.isBranchError.value,
                            onChange: (val) async {
                              controller.selectedBranch = val;
                              controller.isBranchError.value = false;
                              await controller.showPortfolioPrices(
                                  controller.selectedBranch?.id.toString() ??
                                      "");
                              controller.update();
                            },
                            branchesList: controller.center?.branches ?? [],
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Gaps.vGap8,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GetBuilder<CenterDetailsParentController>(
                        builder: (controller) {
                          return AgesDropdown(
                            selectedValue: controller.selectedAge,
                            isError: controller.isAgeError.value,
                            onChange: (val) async {
                              controller.selectedAge = val;
                              controller.isAgeError.value = false;
                              controller.update();
                              controller.applyFilter();
                            },
                            agesList: controller.getAges(),
                          );
                        },
                      ),
                      GetBuilder<CenterDetailsParentController>(
                        builder: (controller) {
                          return TypesDropdown(
                            selectedValue: controller.selectedType,
                            isError: controller.isTypeError.value,
                            onChange: (val) async {
                              controller.selectedType = val;
                              controller.isTypeError.value = false;
                              controller.update();
                              controller.applyFilter();
                            },
                            typesList: controller.programTypes,
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Gaps.vGap16,
                GetBuilder<CenterDetailsParentController>(
                    builder: (controller) {
                  return Visibility(
                    visible: controller.isGettingPrices.value == false,
                    replacement: const Center(
                      child: SpinKitCircle(
                        color: ColorCode.primary600,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: PlansSlider(
                        portfolioPricesModel:
                            controller.filteredPortfolioPrices,
                        centerName: controller.center?.nurseryName ?? "",
                        branchName:
                            controller.selectedBranch?.nurseryName ?? "",
                      ),
                    ),
                  );
                }),
                if (controller.centerPortfolioModel?.data?.imagesActivities
                        ?.isNotEmpty ??
                    false) ...[
                  Gaps.vGap24,
                  Center(
                    child: CustomText(
                      AppStrings.nurseryActivities,
                      textStyle: TextStyles.button12.copyWith(
                          color: ColorCode.secondaryBurgundy600,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Center(
                    child: CustomText(
                      controller.centerPortfolioModel?.data
                              ?.activitySectionTitle ??
                          "",
                      textStyle: TextStyles.button12.copyWith(
                        color: ColorCode.neutral600,
                        fontSize: 8.sp,
                      ),
                    ),
                  ),
                  Gaps.vGap24,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: MasonryGridView.count(
                      crossAxisCount: 3,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.centerPortfolioModel?.data
                              ?.imagesActivities?.length ??
                          0,
                      itemBuilder: (context, index) {
                        final imageUrl = controller.centerPortfolioModel?.data
                                ?.imagesActivities?[index] ??
                            "";

                        return ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: CachedNetworkImage(
                            imageUrl: imageUrl,
                            fit: BoxFit.fill,
                            placeholder: (context, url) => AspectRatio(
                              aspectRatio: 1,
                              child: Container(color: Colors.grey.shade200),
                            ),
                            errorWidget: (context, url, error) => AspectRatio(
                              aspectRatio: 1,
                              child: Container(
                                color: Colors.grey.shade300,
                                child: Icon(Icons.error),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Gaps.vGap24,
                ],
              ],
            ),
          );
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Image(
                image: AppAssets.waitSticker,
                fit: BoxFit.fill,
              ),
              Gaps.vGap16,
              CustomText(
                AppStrings.weHaveSomethingNiceForYouWaitForUs,
                textStyle: TextStyles.title24Bold
                    .copyWith(color: ColorCode.neutral600),
              ),
              Gaps.vGap16,
              CustomText(
                AppStrings.beautifulThingsTakeTimeToBeMadeWithLoveAndCare,
                textStyle: TextStyles.body14Regular
                    .copyWith(color: ColorCode.neutral500),
              ),
              // Gaps.vGap8,
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 16),
              //   child: PortfolioProgressBar(
              //     percentage: controller.percentage ?? 0,
              //   ),
              // ),
              Gaps.vGap64,
              InkWell(
                onTap: () {
                  Get.offAllNamed(Routes.BOTTOM_NAVIGATION);
                },
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      transform: GradientRotation(98.52 * (3.14159265 / 180)),
                      // convert degrees to radians
                      colors: [
                        Color(0xFF7A8CFD), // 11.17%
                        Color(0xFF404FB1), // 63.74%
                        Color(0xFF2B3990), // 94.71%
                      ],
                      stops: [
                        0.1117,
                        0.6374,
                        0.9471,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 10.5),
                  margin: const EdgeInsets.symmetric(horizontal: 60),
                  child: Center(
                    child: CustomText(
                      AppStrings.browseOtherCenters,
                      textStyle: TextStyles.body16Medium.copyWith(
                          color: ColorCode.white, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
            ],
          );
        }
      },
          onLoading: const Center(
            child: SpinKitCircle(
              color: ColorCode.primary600,
            ),
          )),
    );
  }
}
