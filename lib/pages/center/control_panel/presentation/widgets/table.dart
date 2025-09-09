import 'package:first_step/consts/colors.dart';
import 'package:first_step/consts/text_styles.dart';
import 'package:first_step/resources/strings_generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../widgets/custom_text.dart';
import '../../models/branch_model.dart';
import '../../models/statistics_model.dart';

class ArabicTableExample extends StatelessWidget {
  final List<BranchesOrderingDependingOnTheNumberOfEnrollments> data;

  const ArabicTableExample({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        headingRowHeight: 36.h,
        columnSpacing: 30,
        headingRowColor: WidgetStateProperty.all(ColorCode.primary600),
        columns: [
          DataColumn(
            label: CustomText(
              AppStrings.ranking,
              textStyle: TextStyles.body16Medium.copyWith(color: Colors.white, fontSize: 8.sp),
            ),
          ),
          DataColumn(
            label: CustomText(
              AppStrings.branch,
              textStyle: TextStyles.body16Medium.copyWith(color: Colors.white),
            ),
          ),
          DataColumn(
            label: CustomText(
              AppStrings.numberOfReservations,
              textStyle: TextStyles.body16Medium.copyWith(color: Colors.white, fontSize: 12.sp),
            ),
          ),
          DataColumn(
            label: CustomText(
              AppStrings.revenue,
              textStyle: TextStyles.body16Medium.copyWith(color: Colors.white, fontSize: 12.sp),
            ),
          ),
        ],
        rows: List.generate(data.length, (index) {
          final item = data[index];
          return DataRow(cells: [
            DataCell(CustomText(
              (index + 1).toString(), // rank
              textStyle: TextStyles.body16Medium.copyWith(color: ColorCode.neutral500),
            )),
            DataCell(CustomText(
              item.nurseryName ?? '',
              textStyle: TextStyles.body16Medium.copyWith(color: ColorCode.neutral500, fontSize: 12.sp),
            )),
            DataCell(CustomText(
              (item.enrollmentCount ?? 0).toString(),
              textStyle: TextStyles.body16Medium.copyWith(color: ColorCode.neutral500, fontSize: 12.sp),
            )),
            DataCell(CustomText(
              '${item.totalRevenue} ${AppStrings.sar}',
              textStyle: TextStyles.body16Medium.copyWith(color: ColorCode.neutral500, fontSize: 12.sp),
            )),
          ]);
        }),
      ),
    );
  }
}
