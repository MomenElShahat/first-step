import 'package:first_step/consts/colors.dart';
import 'package:first_step/consts/text_styles.dart';
import 'package:first_step/resources/assets_svg_generated.dart';
import 'package:first_step/resources/strings_generated.dart';
import 'package:first_step/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../../../../../../widgets/gaps.dart';
import '../../../../../resources/assets_generated.dart';
import '../../../../../services/auth_service.dart';
import '../../../../../widgets/custom_text_form_field.dart';
import '../../../../parent/blog_parent/models/blogs_model.dart';
import '../../../../parent/blog_parent/presentation/widgets/blog_card.dart';
import '../controllers/blog_controller.dart';

class BlogScreen extends GetView<BlogScreenController> {
  const BlogScreen({super.key});

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
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 0),
                                      child: AppSVGAssets.getWidget(
                                          AppSVGAssets.slogan),
                                    ),
                                    Gaps.hGap4,
                                    AppSVGAssets.getWidget(
                                        AppSVGAssets.signupLogo,
                                        fit: BoxFit.fill),
                                  ],
                                ),
                                CustomText(
                                  "${AppStrings.welcome} ${AuthService.to.userInfo?.user?.name ?? ""}",
                                  textStyle: TextStyles.button12.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: ColorCode.neutral600,
                                  ),
                                ),
                              ],
                            ),
                            Gaps.vGap40,

                            // 🔍 Search bar
                            SizedBox(
                              height: 55.h,
                              child: CustomTextFormField(
                                hint: AppStrings.findTheArticle,
                                inputType: TextInputType.text,
                                validator: (p0) => null,
                                label: "",
                                onChange: (value) {
                                  controller.filteredBlogs.value = controller
                                          .blogsParentResponseModel?.data
                                          ?.where((blog) => (AuthService
                                                          .to.language ==
                                                      "ar"
                                                  ? blog.title?.ar ?? ''
                                                  : blog.title?.en ?? '')
                                              .toLowerCase()
                                              .contains(
                                                  value?.toLowerCase() ?? ""))
                                          .toList() ??
                                      [];
                                },
                                controller: controller.search,
                                prefixIcon: AppSVGAssets.getWidget(
                                    AppSVGAssets.searchUnselected),
                                suffixIcon:
                                    AppSVGAssets.getWidget(AppSVGAssets.filter),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Gaps.vGap16,
              Center(
                child: CustomText(
                  AppStrings.blog,
                  textStyle: TextStyles.title24Bold
                      .copyWith(color: ColorCode.primary600),
                ),
              ),
              Center(
                child: CustomText(
                  "First Step",
                  textStyle: TextStyles.title24Bold
                      .copyWith(color: ColorCode.primary600),
                ),
              ),
              Gaps.vGap5,
              Center(
                child: CustomText(
                  AppStrings.articlesAndResourcesOnChildcareAndWorkLifeBalance,
                  textStyle: TextStyles.body14Regular
                      .copyWith(color: ColorCode.neutral600, fontSize: 8.sp),
                ),
              ),
              Gaps.vGap16,
              // 📜 Scrollable content (list only)
              Obx(() {
                return controller.isBlogsLoading.value
                    ? Center(
                        child: Column(
                          children: [
                            Gaps.vGap128,
                            const SpinKitCircle(
                              color: ColorCode.primary600,
                            ),
                          ],
                        ),
                      )
                    : (controller.filteredBlogs.isNotEmpty)
                        ? Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: RefreshIndicator(
                                  onRefresh: controller.onRefresh,
                                  child: SingleChildScrollView(
                                    child: LayoutBuilder(
                                      builder: (context, constraints) {
                                        // Calculate width for exactly 2 cards per row
                                        double screenWidth =
                                            constraints.maxWidth;
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
                                          verticalDirection:
                                              VerticalDirection.down,
                                          clipBehavior: Clip.none,
                                          runSpacing: 16,
                                          spacing: spacing,
                                          alignment: WrapAlignment.start,
                                          children: List.generate(
                                            controller.filteredBlogs.length,
                                            (index) {
                                              final blog = controller
                                                  .filteredBlogs[index];
                                              return SizedBox(
                                                width: itemWidth,
                                                child: BlogCard(
                                                  blog: blog,
                                                  blogs:
                                                      controller.filteredBlogs,
                                                ),
                                              );
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                  )),
                            ),
                          )
                        : Center(
                            child: RefreshIndicator(
                              onRefresh: controller.onRefresh,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Gaps.vGap128,
                                    CustomText(AppStrings.noBlogsFound),
                                  ],
                                ),
                              ),
                            ),
                          );
              }),
              // Gaps.vGap(100),
            ],
          ),
        ),
      ),
    );
  }
}
