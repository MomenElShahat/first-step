import 'package:first_step/consts/colors.dart';
import 'package:flutter/material.dart';

import '../../../../../consts/text_styles.dart';
import '../../../../../resources/strings_generated.dart';
import '../../../../../widgets/custom_text.dart';
import '../../../../../widgets/gaps.dart';

class PortfolioProgressBar extends StatelessWidget {
  final double percentage; // Between 0 and 100

  const PortfolioProgressBar({super.key, required this.percentage});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gaps.vGap8,
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: percentage / 100),
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeOut,
            builder: (context, value, _) {
              return LinearProgressIndicator(
                value: value,
                minHeight: 10,
                backgroundColor: Colors.grey.shade300,
                valueColor:
                const AlwaysStoppedAnimation<Color>(ColorCode.primary600),
              );
            },
          ),
        ),
        Gaps.vGap8,
        Center(
          child: CustomText(
            "${percentage.toStringAsFixed(1)}% ${AppStrings.completed}",
            textStyle: TextStyles.body16Medium,
          ),
        ),
      ],
    );
  }
}