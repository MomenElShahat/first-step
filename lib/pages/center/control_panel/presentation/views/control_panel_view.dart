import 'package:first_step/consts/colors.dart';
import 'package:first_step/pages/center/control_panel/presentation/widgets/drawer_widget.dart';
import 'package:first_step/resources/assets_svg_generated.dart';
import 'package:first_step/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../../../../../../widgets/gaps.dart';
import '../../../../../consts/text_styles.dart';
import '../../../../../resources/assets_generated.dart';
import '../../../../../resources/strings_generated.dart';
import '../../../../../services/auth_service.dart';
import '../controllers/control_panel_controller.dart';
import '../widgets/branches_dropdown.dart';

class ControlPanelScreen extends GetView<ControlPanelController> {
  final VoidCallback? openDrawer;
  final RxInt currentIndex;

  const ControlPanelScreen({
    super.key,
    this.openDrawer,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    print("isExpired ${controller.mainController?.isExpired.value}");
    return Scaffold(
      key: controller.scaffoldKey,
      backgroundColor: ColorCode.white,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: ColorCode.white,
            statusBarIconBrightness: Brightness.dark),
        toolbarHeight: 0,
      ),
      drawer: controller.mainController?.isExpired.value == false
          ? openDrawer == null
              ? Obx(() {
                  return CustomDrawer(
                    selectedIndex: currentIndex.value,
                    onItemSelected: (index) async {
                      if (AuthService.to.userInfo?.user?.role ==
                              "branch_admin" &&
                          index == 5) {
                        await AuthService.to.logout();
                      } else {
                        currentIndex.value = index;
                        controller.update();
                      }
                      // controller.isDrawerScreenActive.value = true;
                      Get.back(); // Close the drawer
                    },
                  );
                })
              : null
          : null,
      body: controller.obx(
          (state) => SafeArea(
                child: controller.mainController?.isExpired.value == false
                    ? Obx(() {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: RefreshIndicator(
                            onRefresh: controller.onRefresh,
                            child: CustomScrollView(
                              slivers: [
                                const SliverToBoxAdapter(
                                  child: SizedBox(height: 16),
                                ),
                                SliverToBoxAdapter(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: openDrawer ??
                                            () {
                                              controller
                                                  .scaffoldKey.currentState
                                                  ?.openDrawer();
                                            },
                                        child: AppSVGAssets.getWidget(
                                            AppSVGAssets.menu),
                                      ),
                                      if (AuthService.to.userInfo?.user?.role ==
                                          "center")
                                        GetBuilder<ControlPanelController>(
                                          builder: (controller) {
                                            return BranchesDropdown(
                                              selectedValue:
                                                  controller.selectedBranch,
                                              isError: controller
                                                  .isBranchError.value,
                                              onChange: (val) {
                                                controller.selectedBranch = val;
                                                controller.getBranchDetails(
                                                    controller
                                                            .selectedBranch?.id
                                                            .toString() ??
                                                        "");
                                                controller.isBranchError.value =
                                                    false;
                                                controller.update();
                                              },
                                              branchesList:
                                                  controller.branches ?? [],
                                            );
                                          },
                                        ),
                                    ],
                                  ),
                                ),
                                const SliverToBoxAdapter(
                                    child: SizedBox(height: 16)),

                                // Handle child screens properly
                                SliverFillRemaining(
                                  hasScrollBody: true,
                                  child: IndexedStack(
                                    index: currentIndex.value,
                                    children: controller.pageBuilders
                                        .map((builder) => builder())
                                        .toList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      })
                    : Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Image(
                                image: AppAssets.subExpired,
                                fit: BoxFit.fill,
                              ),
                              Gaps.vGap16,
                              CustomText(AppStrings.subExpiredScene,
                                  maxLines: 10,
                                  textStyle: TextStyles.title24Bold
                                      .copyWith(color: ColorCode.danger600)),
                              Gaps.vGap24,
                              InkWell(
                                onTap: (){
                                  controller.mainController?.selectedIndex?.value = 2;
                                  // controller.mainController?.update();
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 60),
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
                                    borderRadius:
                                    BorderRadius.circular(8.r),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.5),
                                  child: Center(
                                    child: CustomText(
                                      AppStrings.subscribeNow,
                                      textStyle: TextStyles.body16Medium
                                          .copyWith(
                                          color: ColorCode.white),
                                    ),
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
