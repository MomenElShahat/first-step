import 'package:first_step/consts/colors.dart';
import 'package:first_step/consts/text_styles.dart';
import 'package:first_step/resources/assets_generated.dart';
import 'package:first_step/resources/assets_svg_generated.dart';
import 'package:first_step/resources/strings_generated.dart';
import 'package:first_step/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../widgets/gaps.dart';

class CustomDrawerParent extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const CustomDrawerParent({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: ColorCode.neutral10,
        child: Column(
          children: [
            Gaps.vGap40,
            // Drawer Header
            // AppSVGAssets.getWidget(AppSVGAssets.drawerIcon),
            // Gaps.vGap24,
            // Menu Items
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  // _buildDrawerItem(
                  //   index: 0,
                  //   icon: AppSVGAssets.homeDrawer,
                  //   label: AppStrings.home,
                  //   selected: selectedIndex == 0,
                  //   onTap: () => onItemSelected(0),
                  // ),
                  _buildDrawerItem(
                    index: 0,
                    icon: AppSVGAssets.childrenFiles,
                    label: AppStrings.myChildren,
                    selected: selectedIndex == 0,
                    onTap: () => onItemSelected(0),
                  ),
                  _buildDrawerItem(
                    index: 1,
                    icon: AppSVGAssets.booking,
                    label: AppStrings.reservations,
                    selected: selectedIndex == 1,
                    onTap: () => onItemSelected(1),
                  ),
                  _buildDrawerItem(
                    index: 2,
                    icon: AppSVGAssets.dailyReports,
                    label: AppStrings.dailyReports,
                    selected: selectedIndex == 2,
                    onTap: () => onItemSelected(2),
                  ),
                  _buildDrawerItem(
                    index: 3,
                    icon: AppSVGAssets.chat,
                    label: AppStrings.chat,
                    selected: selectedIndex == 3,
                    onTap: () => onItemSelected(3),
                  ),
                ],
              ),
            ),
            // Gaps.vGap40,
            // Bottom Branding
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   children: [
            //     Gaps.hGap(24),
            //     AppSVGAssets.getWidget(AppSVGAssets.logoFull),
            //   ],
            // ),
            // Gaps.vGap(35),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required int index,
    required String icon,
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: selected ? null : ColorCode.neutral10,
            gradient: selected ? const LinearGradient(
              begin: Alignment(-0.15, -1.0), // Approximate direction for 98.52 degrees
              end: Alignment(1.0, 0.15),
              colors: [
                Color(0xFF7A8CFD),
                Color(0xFF404FB1),
                Color(0xFF2B3990),
              ],
              stops: [0.1117, 0.6374, 0.9471],
            ) : null,
            borderRadius: BorderRadius.circular(8.r)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        margin: const EdgeInsetsDirectional.only(start: 24, end: 36),
        child: Row(
          children: [
            Container(
              height: 40.h,
              width: 40.w,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: selected ? ColorCode.white : ColorCode.primary600),
              child: Center(
                  child: AppSVGAssets.getWidget(icon,
                      color:
                          selected ? ColorCode.primary600 : ColorCode.white)),
            ),
            Gaps.hGap8,
            CustomText(
              label,
              textStyle: TextStyles.body16Medium.copyWith(
                  fontWeight: FontWeight.w700,
                  color: selected ? ColorCode.white : ColorCode.neutral500,
                  height: 2),
            )
          ],
        ),
      ),
    );
  }
}
