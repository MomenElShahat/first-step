import 'package:first_step/consts/colors.dart';
import 'package:first_step/consts/text_styles.dart';
import 'package:first_step/resources/assets_svg_generated.dart';
import 'package:first_step/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PricingExpandableItem extends StatelessWidget {
  final String title;
  final bool isExpanded;
  final VoidCallback onEdit;
  final VoidCallback? onDelete;
  final bool isDeleting;
  final VoidCallback onExpand;
  final Widget expandedContent;

  const PricingExpandableItem({
    super.key,
    required this.title,
    required this.isExpanded,
    required this.onEdit,
    this.onDelete,
    this.isDeleting = false,
    required this.onExpand,
    required this.expandedContent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: ColorCode.neutral400), 
        borderRadius: BorderRadiusDirectional.circular(8.r),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: ListTile(
                  onTap: onExpand,
                  title: CustomText(
                    title,
                    textAlign: TextAlign.start,
                    textStyle: TextStyles.body16Medium.copyWith(
                      color: ColorCode.primary600, 
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              // Separate edit icon
              Padding(
                padding: const EdgeInsetsDirectional.only(end: 8.0),
                child: InkWell(
                  onTap: onEdit,
                  child: AppSVGAssets.getWidget(AppSVGAssets.edit),
                ),
              ),
              // Delete icon or loading
              Padding(
                padding: const EdgeInsetsDirectional.only(end: 16.0),
                child: isDeleting
                    ? SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: ColorCode.danger600))
                    : (onDelete != null
                        ? InkWell(
                            onTap: onDelete,
                            child: AppSVGAssets.getWidget(AppSVGAssets.delete, color: ColorCode.danger600),
                          )
                        : const SizedBox.shrink()),
              ),
            ],
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
