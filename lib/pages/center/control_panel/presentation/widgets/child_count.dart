import 'package:first_step/consts/colors.dart';
import 'package:first_step/consts/text_styles.dart';
import 'package:first_step/resources/strings_generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math';

import '../../../../../widgets/custom_text.dart';
import '../../../../../widgets/gaps.dart';

class ChildrenCapacityWidget extends StatelessWidget {
  final int current;
  final int capacity;

  const ChildrenCapacityWidget({
    super.key,
    required this.current,
    required this.capacity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: Colors.white, // Background
        borderRadius: BorderRadius.circular(24), // Rounded corners
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(34, 34, 34, 0.16), // Shadow color with opacity
            blurRadius: 4, // Blur effect (softness)
            offset: Offset(0, 0), // No offset
            spreadRadius: 0, // No spread
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(
            AppStrings.numberOfChildren,
            textStyle: TextStyles.body16Medium.copyWith(fontWeight: FontWeight.w700, color: ColorCode.primary600),
          ),
          Gaps.vGap(100),
          CustomPaint(
            size: const Size(150, 150),
            painter: SegmentedCirclePainter(current, capacity),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    '$current',
                    textStyle: TextStyles.body16Medium.copyWith(fontWeight: FontWeight.w700, color: ColorCode.primary600, fontSize: 30.sp),
                  ),
                  CustomText(
                    AppStrings.child,
                    textStyle: TextStyles.body16Medium.copyWith(fontWeight: FontWeight.w700, color: ColorCode.primary600),
                  ),
                ],
              ),
            ),
          ),
          Gaps.vGap(100),
          // CustomText(
          //   '${AppStrings.nurseryCapacity}: $capacity ${AppStrings.child}',
          //   textStyle: TextStyles.body16Medium.copyWith(color: ColorCode.neutral600),
          // ),
        ],
      ),
    );
  }
}

class SegmentedCirclePainter extends CustomPainter {
  final int current;
  final int capacity;

  SegmentedCirclePainter(this.current, this.capacity);

  @override
  void paint(Canvas canvas, Size size) {
    const int totalSegments = 100;
    const double angleStep = 2 * pi / totalSegments;
    final double radius = size.width / 3;
    final Offset center = Offset(size.width / 2, size.height / 2);

    final Paint activePaint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2;

    final Paint inactivePaint = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = 2;

    final int activeCount = ((current / capacity) * totalSegments).round();

    for (int i = 0; i < totalSegments; i++) {
      final double angle = -pi / 2 + i * angleStep;
      final Paint paint = i < activeCount ? activePaint : inactivePaint;

      // Dot first (inner)
      final Offset dotCenter = Offset(
        center.dx + (radius - 20) * cos(angle),
        center.dy + (radius - 20) * sin(angle),
      );
      canvas.drawCircle(dotCenter, 1.5, paint);

      // Line next (outer)
      final Offset lineStart = Offset(
        center.dx + (radius - 16) * cos(angle),
        center.dy + (radius - 16) * sin(angle),
      );
      final Offset lineEnd = Offset(
        center.dx + (radius - 6) * cos(angle),
        center.dy + (radius - 6) * sin(angle),
      );
      canvas.drawLine(lineStart, lineEnd, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
