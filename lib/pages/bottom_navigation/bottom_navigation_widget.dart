import 'package:first_step/consts/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../consts/colors.dart';
import '../../resources/assets_svg_generated.dart';
import '../../resources/strings_generated.dart';
import '../../services/auth_service.dart';
import '../center/control_panel/presentation/views/control_panel_view.dart';
import '../center/control_panel/presentation/widgets/drawer_widget.dart';
import '../parent/control_panel_parent/presentation/controllers/control_panel_parent_controller.dart';
import '../parent/control_panel_parent/presentation/views/control_panel_parent_view.dart';
import '../parent/control_panel_parent/presentation/widgets/drawer_widget_parent.dart';
import 'controller/main_controller.dart';

class BottomNavigationWidget extends GetView<MainController> {
  const BottomNavigationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      drawer: AuthService.to.userInfo?.user?.role == "parent"
          ? Obx(() {
              return CustomDrawerParent(
                selectedIndex: controller.currentIndex.value,
                onItemSelected: (index) async {
                  controller.currentIndex.value = index;
                  controller.isDrawerScreenActive.value = true;
                  Get.back(); // Close the drawer
                },
              );
            })
          : Obx(() {
              return CustomDrawer(
                selectedIndex: controller.currentIndex.value,
                onItemSelected: (index) {
                  controller.currentIndex.value = index;
                  controller.isDrawerScreenActive.value = true;
                  Get.back(); // Close the drawer
                },
              );
            }),
      body: AuthService.to.userInfo?.user?.role == "parent"
          ? Obx(() {
              if (controller.isDrawerScreenActive.value) {
                final screen = ControlPanelParentScreen(
                  openDrawer: () {
                    scaffoldKey.currentState?.openDrawer();
                  },
                  currentIndex: controller.currentIndex,
                );
                print('Showing drawer screen: ${screen.runtimeType}');
                return screen;
              } else {
                final index = controller.selectedIndex?.value ?? 0;
                final page = controller.pageList[index];
                print('Showing bottom nav page: ${page.runtimeType}');
                if (index == 0 && page is ControlPanelParentScreen) {
                  return ControlPanelParentScreen(
                    openDrawer: () {
                      scaffoldKey.currentState?.openDrawer();
                    },
                    currentIndex: controller.currentIndex,
                  );
                }
                return page;
              }
            })
          : Obx(() {
              if (controller.isDrawerScreenActive.value) {
                final screen = ControlPanelScreen(
                  openDrawer: () {
                    scaffoldKey.currentState?.openDrawer();
                  },
                  currentIndex: controller.currentIndex,
                );
                print('Showing drawer screen: ${screen.runtimeType}');
                return screen;
              } else {
                final index = controller.selectedIndex?.value ?? 0;
                final page = controller.pageList[index];
                print('Showing bottom nav page: ${page.runtimeType}');
                if (index == 0 && page is ControlPanelScreen) {
                  return ControlPanelScreen(
                    openDrawer: () {
                      scaffoldKey.currentState?.openDrawer();
                    },
                    currentIndex: controller.currentIndex,
                  );
                }
                return page;
              }
            }),
      extendBody: true,
      bottomNavigationBar: Obx(() {
        return Padding(
          padding: const EdgeInsetsDirectional.only(start: 16, end: 16, bottom: 16),
          child: Container(
            // height: 75.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(48),
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFE2F3EB), Color(0xFFFFFFFF)],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 9,right: 9,left: 9),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(48),
                child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  selectedFontSize: 12,
                  unselectedFontSize: 12,
                  selectedLabelStyle: TextStyles.button12.copyWith(
                    fontWeight: FontWeight.w700,
                    color: ColorCode.primary600,
                  ),
                  unselectedLabelStyle: TextStyles.button12.copyWith(
                    color: ColorCode.neutral500,
                  ),
                  selectedItemColor: ColorCode.primary600,
                  unselectedItemColor: ColorCode.neutral500,
                  currentIndex: controller.selectedIndex?.value ?? 0,
                  onTap: controller.onItemTapped,
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsetsDirectional.only(bottom: 7),
                        child: AppSVGAssets.getWidget(AppSVGAssets.controlPanelUnselected),
                      ),
                      activeIcon: Padding(
                        padding: const EdgeInsets.only(bottom: 7),
                        child: AppSVGAssets.getWidget(
                          AppSVGAssets.controlPanelSelected,
                          color: ColorCode.primary600,
                        ),
                      ),
                      label: AppStrings.controlPanel,
                    ),
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: AppSVGAssets.getWidget(AppSVGAssets.blogUnselected),
                      ),
                      activeIcon: Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: AppSVGAssets.getWidget(
                          AppSVGAssets.blogSelected,
                          color: ColorCode.primary600,
                        ),
                      ),
                      label: AppStrings.blog,
                    ),
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.only(bottom: 3),
                        child: AppSVGAssets.getWidget(AppSVGAssets.homeUnselected),
                      ),
                      activeIcon: Padding(
                        padding: const EdgeInsets.only(bottom: 3),
                        child: AppSVGAssets.getWidget(
                          AppSVGAssets.homeSelected,
                          color: ColorCode.primary600,
                        ),
                      ),
                      label: AppStrings.home,
                    ),
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.only(bottom: 2),
                        child: AppSVGAssets.getWidget(
                            AppSVGAssets.notificationLight),
                      ),
                      activeIcon: Padding(
                        padding: const EdgeInsets.only(bottom: 2),
                        child: AppSVGAssets.getWidget(
                          AppSVGAssets.notificationLight,
                          color: ColorCode.primary600,
                        ),
                      ),
                      label: AppStrings.notifications,
                    ),
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.only(bottom: 2),
                        child: AppSVGAssets.getWidget(AppSVGAssets.profileUnselected),
                      ),
                      activeIcon: Padding(
                        padding: const EdgeInsets.only(bottom: 2),
                        child: AppSVGAssets.getWidget(
                          AppSVGAssets.profileSelected,
                          color: ColorCode.primary600,
                        ),
                      ),
                      label: AppStrings.profile,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
