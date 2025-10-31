import 'package:first_step/consts/colors.dart';
import 'package:first_step/consts/text_styles.dart';
import 'package:first_step/resources/assets_svg_generated.dart';
import 'package:first_step/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExpandableSectionItem extends StatelessWidget {
  final String title;
  final bool isExpanded;
  final VoidCallback onEdit;
  final VoidCallback? onReset;
  final Widget expandedContent;

  const ExpandableSectionItem({
    super.key,
    required this.title,
    required this.isExpanded,
    required this.onEdit,
    this.onReset,
    required this.expandedContent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(border: Border.all(color: ColorCode.neutral400), borderRadius: BorderRadiusDirectional.circular(8.r)),
      child: Column(
        children: [
          ListTile(
            onTap: onEdit,
            title: CustomText(
              title,
              textAlign: TextAlign.start,
              textStyle: TextStyles.body16Medium.copyWith(color: ColorCode.primary600, fontWeight: FontWeight.w700),
            ),
            trailing: isExpanded
                ? InkWell(
                    onTap: onReset,
                    child: AppSVGAssets.getWidget(AppSVGAssets.delete),
                  )
                : AppSVGAssets.getWidget(AppSVGAssets.edit),
          ),
          if (isExpanded)
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: expandedContent,
            ),
        ],
      ),
    );
  }
}
