import 'package:first_step/consts/colors.dart';
import 'package:first_step/resources/strings_generated.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../consts/text_styles.dart';
import '../../../../../../resources/assets_generated.dart';
import '../../../../../../widgets/custom_text.dart';
import '../../../../../../widgets/gaps.dart';
import '../../../../../center/control_panel/models/portfolio_prices_model.dart';
import '../../../../home_parent/models/centers_model.dart';
import '../../controller/booking_controller.dart';

class PriceOptions extends GetView<BookingController> {
  final PortfolioPrice selectedPrice;

  const PriceOptions({super.key, required this.selectedPrice});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingController>(builder: (controller) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        child: Row(
          // mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(controller.pricingList?.length ?? 0, (index) {
            bool isSelected = controller.selectedPrice == controller.pricingList?[index];

            return GestureDetector(
              onTap: () {
                controller.selectedPrice = controller.pricingList?[index];
                controller.selectedDays.clear();
                controller.selectedDay = null;
                controller.selectedMonth = null;
                controller.day.clear();
                controller.month.clear();
                controller.update();
              },
              child: AnimatedScale(
                duration: const Duration(milliseconds: 300),
                scale: isSelected ? 1.1 : 0.9,
                curve: Curves.easeOutBack,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutBack,
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  child: isSelected
                      ? ClipPath(
                          clipper: CleanCouponClipper(),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              gradient: const LinearGradient(
                                colors: [Color(0xFF7A8CFD), Color(0xFF404FB1), Color(0xFF2B3990)],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x22222214),
                                  blurRadius: 80,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: content(
                                isSelected, controller.pricingList?[index].enrollmentType ?? "", controller.pricingList?[index].priceAmount ?? ""),
                          ),
                        )
                      : Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: content(
                              isSelected, controller.pricingList?[index].enrollmentType ?? "", controller.pricingList?[index].priceAmount ?? ""),
                        ),
                ),
              ),
            );
          }),
        ),
      );
    });
  }

  Widget content(bool isSelected, String description, String price) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image(
              image: AppAssets.riyal,
              width: 15,
              height: 15,
              color: isSelected ? ColorCode.white : ColorCode.primary600,
            ),
            Gaps.hGap4,
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: CustomText(
                price,
                textStyle: TextStyles.body16Medium.copyWith(fontWeight: FontWeight.w700, color: isSelected ? ColorCode.white : ColorCode.primary600),
              ),
            ),
          ],
        ),
        Gaps.vGap5,
        Container(
          margin: const EdgeInsets.only(top: 5, bottom: 5),
          height: 1,
          width: Get.width / 8,
          color: isSelected ? ColorCode.white : ColorCode.secondary600,
        ),
        Gaps.vGap5,
        CustomText(
          description,
          textStyle: TextStyles.button12.copyWith(color: isSelected ? ColorCode.white : ColorCode.neutral500),
        ),
      ],
    );
  }
}

/// Custom Clipper for Coupon-Style Cut Edges
class CleanCouponClipper extends CustomClipper<Path> {
  final double cornerRadius = 4;
  final double cutWidth = 8; // Wider rectangle cuts
  final double cutDepth = 4;

  @override
  Path getClip(Size size) {
    Path path = Path();

    double width = size.width;
    double height = size.height;

    int horizontalCount = ((width - 2 * cornerRadius) / (cutWidth + cutDepth) / 1.5).floor();
    double horizontalSpacing = (width - 2 * cornerRadius - horizontalCount * cutWidth) / (horizontalCount + 1) * 1.15;

    int verticalCount = ((height - 2 * cornerRadius) / (cutWidth + cutDepth) / 1.5).floor();
    double verticalSpacing = (height - 2 * cornerRadius - verticalCount * cutWidth) / (verticalCount + 1) * 1.15;

    path.moveTo(cornerRadius, 0);

    // Top Edge with Rectangular Cuts
    for (int i = 0; i < horizontalCount; i++) {
      double startX = cornerRadius + horizontalSpacing * (i + 1) + cutWidth * i;
      path.lineTo(startX + 4, 0);
      path.lineTo(startX + 4, cutDepth);
      path.lineTo(startX + cutWidth, cutDepth);
      path.lineTo(startX + cutWidth, 0);
    }
    path.lineTo(width - cornerRadius, 0);

    // Top-right Rounded Corner
    path.arcToPoint(Offset(width, cornerRadius), radius: Radius.circular(cornerRadius));

    // Right Edge with Rectangular Cuts
    for (int i = 0; i < verticalCount; i++) {
      double startY = cornerRadius + verticalSpacing * (i + 1) + cutWidth * i;
      path.lineTo(width, startY + 4);
      path.lineTo(width - cutDepth, startY + 4);
      path.lineTo(width - cutDepth, startY + cutWidth);
      path.lineTo(width, startY + cutWidth);
    }
    path.lineTo(width, height - cornerRadius);

    // Bottom-right Rounded Corner
    path.arcToPoint(Offset(width - cornerRadius, height), radius: Radius.circular(cornerRadius));

    // Bottom Edge with Rectangular Cuts
    for (int i = 0; i < horizontalCount; i++) {
      double startX = width - cornerRadius - horizontalSpacing * (i + 1) - cutWidth * i;
      path.lineTo(startX, height);
      path.lineTo(startX, height - cutDepth);
      path.lineTo(startX - cutWidth + 4, height - cutDepth);
      path.lineTo(startX - cutWidth + 4, height);
    }
    path.lineTo(cornerRadius, height);

    // Bottom-left Rounded Corner
    path.arcToPoint(Offset(0, height - cornerRadius), radius: Radius.circular(cornerRadius));

    // Left Edge with Rectangular Cuts
    for (int i = 0; i < verticalCount; i++) {
      double startY = height - cornerRadius - verticalSpacing * (i + 1) - cutWidth * i;
      path.lineTo(0, startY);
      path.lineTo(cutDepth, startY);
      path.lineTo(cutDepth, startY - cutWidth + 4);
      path.lineTo(0, startY - cutWidth + 4);
    }
    path.lineTo(0, cornerRadius);

    // Top-left Rounded Corner
    path.arcToPoint(Offset(cornerRadius, 0), radius: Radius.circular(cornerRadius));

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
