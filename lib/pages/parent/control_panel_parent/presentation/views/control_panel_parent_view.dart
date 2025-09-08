import 'package:first_step/consts/colors.dart';
import 'package:first_step/resources/assets_svg_generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../../../widgets/gaps.dart';
import '../controllers/control_panel_parent_controller.dart';

class ControlPanelParentScreen extends GetView<ControlPanelParentController> {
  final VoidCallback openDrawer;
  final RxInt currentIndex;

  const ControlPanelParentScreen({
    super.key,
    required this.openDrawer,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorCode.white,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: ColorCode.white,
          statusBarBrightness: Brightness.dark,
        ),
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: Obx(() {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: RefreshIndicator(
              onRefresh: controller.onRefresh,
              child: CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(child: SizedBox(height: 16)),

                  // Menu Row
                  SliverToBoxAdapter(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: openDrawer,
                          child: AppSVGAssets.getWidget(AppSVGAssets.menu),
                        ),
                        // You can enable this later if needed
                        // BranchesDropdown(...)
                      ],
                    ),
                  ),

                  const SliverToBoxAdapter(child: SizedBox(height: 16)),

                  // Main content
                  SliverFillRemaining(
                    hasScrollBody: true,
                    child: IndexedStack(
                      index: currentIndex.value,
                      children: controller.pageBuilders.map((builder) => builder()).toList(),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
