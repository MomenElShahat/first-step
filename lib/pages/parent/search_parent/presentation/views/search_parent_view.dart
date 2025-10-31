import 'package:first_step/consts/colors.dart';
import 'package:first_step/consts/text_styles.dart';
import 'package:first_step/resources/assets_svg_generated.dart';
import 'package:first_step/resources/strings_generated.dart';
import 'package:first_step/widgets/custom_text.dart';
import 'package:first_step/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../../../../../../widgets/gaps.dart';
import '../../../../../resources/assets_generated.dart';
import '../../../../../routes/app_pages.dart';
import '../../../home_parent/presentation/widgets/center_card.dart';
import '../controllers/search_parent_controller.dart';

class SearchParentScreen extends GetView<SearchParentScreenController> {
  const SearchParentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorCode.white,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true, // Add this line
      body: AnnotatedRegion(
        value: SystemUiOverlayStyle(
            statusBarColor: ColorCode.primary600.withOpacity(.9)),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
                      //   bottom: 50,
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
                              Gaps.vGap16,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    children: [
                                      AppSVGAssets.getWidget(
                                          AppSVGAssets.signupLogo),
                                      Gaps.hGap4,
                                      AppSVGAssets.getWidget(AppSVGAssets.slogan),
                                    ],
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.back();
                                    },
                                    child: const Icon(
                                        Icons.arrow_forward_ios_outlined),
                                  ),
                                ],
                              ),
                              Gaps.vGap40,
                              GetBuilder<SearchParentScreenController>(builder: (controller) {
                                return SizedBox(
                                  height: 55.h,
                                  child: CustomTextFormField(
                                    hint: AppStrings.findACenterOrNursery,
                                    inputType: TextInputType.text,
                                    label: "",
                                    onChange: (value) {
                                      controller.filterNurseries();
                                    },
                                    validator: (p0) => null,
                                    controller: controller.search,
                                    prefixIcon: AppSVGAssets.getWidget(
                                        AppSVGAssets.searchUnselected),
                                    suffixIcon: InkWell(
                                      onTap: () {
                                        controller.openCitiesDialog(context);
                                      },
                                      child: AppSVGAssets.getWidget(
                                          AppSVGAssets.filter),
                                    ),
                                  ),
                                );
                              })
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // 📜 Scrollable content (list only)
                Obx(
                      () {
                    return controller.isSearchClicked.value
                        ? const Center(
                      child: SpinKitCircle(
                        color: ColorCode.primary600,
                      ),
                    )
                        : RefreshIndicator(
                      onRefresh: controller.onRefresh,
                      child: controller.isSearching.value
                          ? SingleChildScrollView(
                        child: GetBuilder<
                            SearchParentScreenController>(
                            builder: (controller) {
                              return Padding(
                                padding: const EdgeInsets.all(16),
                                child: LayoutBuilder(
                                    builder: (context, constraints) {
                                      // Calculate width for exactly 2 cards per row
                                      double screenWidth = constraints.maxWidth;
                                      double spacing = 16;
                                      double totalSpacing =
                                          spacing; // one spacing between two items
                                      double itemWidth =
                                          (screenWidth - totalSpacing) / 2;
                                      return Wrap(
                                        direction: Axis.horizontal,
                                        crossAxisAlignment:
                                        WrapCrossAlignment.start,
                                        runAlignment: WrapAlignment.start,
                                        verticalDirection: VerticalDirection.down,
                                        clipBehavior: Clip.none,
                                        runSpacing: 16,
                                        spacing: spacing,
                                        alignment: WrapAlignment.start,
                                        children: List.generate(
                                          controller
                                              .filteredNurseries.length,
                                              (index) {
                                            final center = controller
                                                .filteredNurseries[index];
                                            return SizedBox(
                                              width: itemWidth,
                                              child: InkWell(
                                                onTap: () {
                                                  controller.searchCenters(
                                                      keyword: center.nurseryName ?? "");
                                                },
                                                child: CenterCard(
                                                    center: center
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  ),
                              );
                                LayoutBuilder(
                                builder: (context, constraints) {
                                  return GridView.builder(
                                    shrinkWrap: true,
                                    physics:
                                    const NeverScrollableScrollPhysics(),
                                    itemCount: controller
                                        .filteredNurseries.length ??
                                        0,
                                    gridDelegate:
                                    SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent:
                                        constraints.maxWidth /
                                            2,
                                        crossAxisSpacing: 16,
                                        mainAxisSpacing: 16,
                                        childAspectRatio: .9),
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          controller.searchCenters(
                                              keyword: controller
                                                  .filteredNurseries[
                                              index]
                                                  .nurseryName ??
                                                  "");
                                        },
                                        child: CenterCard(
                                          center: controller
                                              .filteredNurseries[index],
                                        ),
                                      );
                                    },
                                  );
                                },
                              );
                            }),
                      )
                          : GetBuilder<SearchParentScreenController>(
                        builder: (controller) =>
                        (controller
                            .nurseries.isEmpty &&
                            controller.isLoading == true)
                            ? Center(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Gaps.vGap8,
                              CustomText(
                                AppStrings.recentSearches,
                                textStyle: TextStyles
                                    .title32Bold
                                    .copyWith(
                                  fontSize: 8.sp,
                                  color: ColorCode.neutral500,
                                ),
                              ),
                              Gaps.vGap128,
                              const SpinKitCircle(
                                color: ColorCode.primary600,
                              ),
                            ],
                          ),
                        )
                            : (controller.nurseries.isEmpty &&
                            controller.isLoading == false)
                            ? RefreshIndicator(
                          onRefresh: controller.onRefresh,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Gaps.vGap128,
                                CustomText(AppStrings
                                    .noNurseriesFound),
                              ],
                            ),
                          ),
                        )
                            : Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Gaps.vGap8,
                            CustomText(
                              AppStrings.recentSearches,
                              textStyle: TextStyles
                                  .title32Bold
                                  .copyWith(
                                fontSize: 8.sp,
                                color:
                                ColorCode.neutral500,
                              ),
                            ),
                            Gaps.vGap8,
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: LayoutBuilder(
                                builder: (context, constraints) {
                                  // Calculate width for exactly 2 cards per row
                                  double screenWidth = constraints.maxWidth;
                                  double spacing = 16;
                                  double totalSpacing =
                                      spacing; // one spacing between two items
                                  double itemWidth =
                                      (screenWidth - totalSpacing) / 2;
                                  return Wrap(
                                    direction: Axis.horizontal,
                                    crossAxisAlignment:
                                    WrapCrossAlignment.start,
                                    runAlignment: WrapAlignment.start,
                                    verticalDirection: VerticalDirection.down,
                                    clipBehavior: Clip.none,
                                    runSpacing: 16,
                                    spacing: spacing,
                                    alignment: WrapAlignment.start,
                                    children: List.generate(
                                      controller
                                          .nurseries.length,
                                          (index) {
                                        final center = controller
                                            .nurseries[index];
                                        return SizedBox(
                                          width: itemWidth,
                                          child: InkWell(
                                            onTap: () {
                                              Get.toNamed(
                                                  Routes.CENTER_DETAILS_PARENT,
                                                  arguments: {
                                                    "center":
                                                    center
                                                  });
                                            },
                                            child: CenterCard(
                                              center: center
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),
                            // LayoutBuilder(
                            //   builder:
                            //       (context, constraints) {
                            //     return GridView.builder(
                            //       shrinkWrap: true,
                            //       itemCount: controller
                            //           .nurseries.length,
                            //       gridDelegate:
                            //       SliverGridDelegateWithMaxCrossAxisExtent(
                            //           maxCrossAxisExtent:
                            //           constraints
                            //               .maxWidth /
                            //               2,
                            //           crossAxisSpacing:
                            //           16,
                            //           mainAxisSpacing:
                            //           16,
                            //           childAspectRatio:
                            //           .9),
                            //       itemBuilder:
                            //           (context, index) {
                            //         final center =
                            //         controller
                            //             .nurseries[
                            //         index];
                            //         return InkWell(
                            //           onTap: () {
                            //             Get.toNamed(
                            //                 Routes
                            //                     .CENTER_DETAILS_PARENT,
                            //                 arguments: {
                            //                   "center":
                            //                   center
                            //                 });
                            //           },
                            //           child: CenterCard(
                            //               center: center),
                            //         );
                            //       },
                            //     );
                            //   },
                            // ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                // Gaps.vGap(100),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
