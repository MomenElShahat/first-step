import 'package:first_step/consts/colors.dart';
import 'package:first_step/pages/auth/onboarding/presentation/controllers/onboarding_controller.dart';
import 'package:first_step/resources/assets_svg_generated.dart';
import 'package:first_step/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:get/get.dart';

class NextButton extends GetView<OnboardingController> {
  const NextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Circular background
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 4,
                ),
              ],
            ),
          ),

          // Green Arc
          Obx(() {
            return Positioned.fill(
              child: CustomPaint(
                painter: controller.index.value == 1
                    ? ArcPainterUp()
                    : ArcPainterDown(),
              ),
            );
          }),

          // Arrow icon
          AppSVGAssets.getWidget(
              AuthService.to.language == "ar"
                  ? AppSVGAssets.arrowRightLine
                  : AppSVGAssets.arrowLeftLine,
              color: ColorCode.secondary600),
        ],
      ),
    );
  }
}

class ArcPainterUp extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = ColorCode.secondary600
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;

    double startAngle = -pi; // Start from the top
    double sweepAngle = pi; // Half-circle arc

    canvas.drawArc(
      Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2),
          radius: size.width / 2),
      startAngle,
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class ArcPainterDown extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = ColorCode.secondary600
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;

    double startAngle = pi; // Start from the top
    double sweepAngle = -pi; // Half-circle arc
    double startAngle2 = -pi; // Start from the top
    double sweepAngle2 = pi; // Half-circle arc

    canvas.drawArc(
      Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2),
          radius: size.width / 2),
      startAngle,
      sweepAngle,
      false,
      paint,
    );
    canvas.drawArc(
      Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2),
          radius: size.width / 2),
      startAngle2,
      sweepAngle2,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
