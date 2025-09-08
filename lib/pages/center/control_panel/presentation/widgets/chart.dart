import 'package:first_step/consts/colors.dart';
import 'package:first_step/consts/text_styles.dart';
import 'package:first_step/resources/strings_generated.dart';
import 'package:first_step/services/auth_service.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../widgets/custom_text.dart';
import '../../../../../widgets/gaps.dart';
import '../../models/statistics_model.dart';
import '../controllers/control_panel_controller.dart';

class RevenueChart extends GetView<ControlPanelController> {
  final List<TotalRevenueForTheLates5Months> revenues;

  const RevenueChart({super.key, required this.revenues});

  @override
  Widget build(BuildContext context) {
    // If empty, fill with 5 placeholder months with zero values
    final isEmpty = revenues.isEmpty;
    final dataSource = isEmpty ? _generateEmptyRevenues() : revenues;

    final data = controller.buildRevenueSpots(dataSource);
    final maxIndex = controller.getMaxRevenueIndex(dataSource);
    final maxRevenue = dataSource[maxIndex];

    final NumberFormat currencyFormatter = NumberFormat.decimalPattern(
        AuthService.to.language == "ar" ? "ar" : "en");

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Highest month text
          CustomText(
            isEmpty
                ? AppStrings.highestMonth
                : "${AppStrings.highestMonth} ${_extractMonthNumber(maxRevenue.month).startsWith("0") ? _extractMonthNumber(maxRevenue.month).replaceAll("0", "") : _extractMonthNumber(maxRevenue.month)}",
            textStyle:
                TextStyles.title24Bold.copyWith(color: ColorCode.primary600),
          ),
          Gaps.vGap4,
          CustomText(
            "${currencyFormatter.format(maxRevenue.totalPaid ?? 0)} ${AppStrings.sar}",
            textStyle:
                TextStyles.title24Bold.copyWith(color: ColorCode.neutral500),
          ),
          Gaps.vGap16,
          LayoutBuilder(
            builder: (context, constraints) {
              final chartWidth = constraints.maxWidth;

              return SizedBox(
                width: chartWidth,
                height: 300.h,
                child: Stack(
                  children: [
                    LineChart(
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.easeInOut,
                      LineChartData(
                        minX: 1,
                        maxX: dataSource.length.toDouble(),
                        minY: 0,
                        maxY: _getMaxY(data) * 1.2,
                        gridData: FlGridData(
                          show: true,
                          drawVerticalLine: true,
                          drawHorizontalLine: false,
                          getDrawingVerticalLine: (value) => const FlLine(
                            color: ColorCode.neutral0,
                            strokeWidth: 1,
                          ),
                        ),
                        titlesData: FlTitlesData(
                          leftTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          topTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          rightTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 24,
                              interval: 1,
                              getTitlesWidget: (value, _) {
                                int index = value.toInt() - 1;
                                if (index >= 0 && index < dataSource.length) {
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: CustomText(
                                      _extractMonthNumber(
                                          dataSource[index].month),
                                      textStyle:
                                          TextStyles.title24Bold.copyWith(
                                        fontSize: 10.sp,
                                        color: ColorCode.black2,
                                      ),
                                    ),
                                  );
                                }
                                return const CustomText('');
                              },
                            ),
                          ),
                        ),
                        borderData: FlBorderData(show: false),
                        lineBarsData: [
                          LineChartBarData(
                            spots: data,
                            isCurved: true,
                            preventCurveOverShooting: true,
                            color: ColorCode.primary600,
                            barWidth: 2,
                            belowBarData: BarAreaData(
                              show: true,
                              gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0xFFADB7F9),
                                  Color(0x00B1B9F8),
                                ],
                              ),
                            ),
                            dotData: FlDotData(
                              show: true,
                              getDotPainter: (spot, index, _, __) {
                                final maxY = data
                                    .map((e) => e.y)
                                    .reduce((a, b) => a > b ? a : b);
                                return spot.y == maxY
                                    ? FlDotCirclePainter(
                                        radius: 5,
                                        color: ColorCode.info600,
                                        strokeWidth: 3,
                                        strokeColor: ColorCode.white,
                                      )
                                    : FlDotCirclePainter(radius: 0);
                              },
                            ),
                          ),
                        ],
                        lineTouchData: LineTouchData(
                          enabled: true,
                          handleBuiltInTouches: true,
                          getTouchedSpotIndicator: (barData, spotIndexes) {
                            return spotIndexes.map((index) {
                              return TouchedSpotIndicatorData(
                                FlLine(
                                  color: ColorCode.primary600,
                                  strokeWidth: 1,
                                ),
                                FlDotData(show: true),
                              );
                            }).toList();
                          },
                          touchSpotThreshold: 50,
                          touchTooltipData: LineTouchTooltipData(
                            fitInsideHorizontally: true,
                            fitInsideVertically: true,
                            tooltipBorderRadius: BorderRadius.circular(8),
                            getTooltipItems: (touchedSpots) {
                              return touchedSpots.map((spot) {
                                final int index = spot.x.toInt() - 1;
                                if (index < 0 || index >= dataSource.length) {
                                  return null;
                                }

                                final revenue = dataSource[index];
                                final double value =
                                    revenue.totalPaid?.toDouble() ?? 0.0;

                                return LineTooltipItem(
                                  currencyFormatter.format(value),
                                  const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              }).toList();
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  String _extractMonthNumber(String? fullMonth) {
    if (fullMonth == null) return "--";
    final parts = fullMonth.split("-");
    return parts.length > 1 ? parts[1].padLeft(2, '0') : "--";
  }

  double _getMaxY(List<FlSpot> spots) {
    if (spots.isEmpty) return 1000;
    return spots.map((e) => e.y).reduce((a, b) => a > b ? a : b);
  }

  List<TotalRevenueForTheLates5Months> _generateEmptyRevenues() {
    final now = DateTime.now();
    return List.generate(5, (index) {
      final date = DateTime(now.year, now.month - (4 - index));
      final formatted = "${date.year}-${date.month.toString().padLeft(2, '0')}";
      return TotalRevenueForTheLates5Months(
        month: formatted,
        totalPaid: 0,
      );
    });
  }
}
