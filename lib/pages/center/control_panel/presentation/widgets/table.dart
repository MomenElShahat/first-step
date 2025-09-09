import 'package:first_step/consts/colors.dart';
import 'package:first_step/consts/text_styles.dart';
import 'package:first_step/resources/strings_generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../widgets/custom_text.dart';
import '../../models/branch_model.dart';

class ArabicTableExample extends StatelessWidget {
  final List<BranchModel> data;

  const ArabicTableExample({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    // Sort the data list by enrollmentsCount ascending
    final sortedData = [...data]..sort((a, b) {
        return (a.enrollmentsCount ?? 0).compareTo(b.enrollmentsCount ?? 0);
      });

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
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
          // DataColumn(
          //   label: CustomText(
          //     AppStrings.revenue,
          //     textStyle: TextStyles.body16Medium.copyWith(color: Colors.white, fontSize: 12.sp),
          //   ),
          // ),
        ],
        rows: List.generate(sortedData.length, (index) {
          final item = sortedData[index];
          return DataRow(cells: [
            DataCell(CustomText(
              (index + 1).toString(), // rank
              textStyle: TextStyles.body16Medium.copyWith(color: ColorCode.neutral500),
            )),
            DataCell(CustomText(
              item.name ?? '',
              textStyle: TextStyles.body16Medium.copyWith(color: ColorCode.neutral500, fontSize: 12.sp),
            )),
            DataCell(CustomText(
              (item.enrollmentsCount ?? 0).toString(),
              textStyle: TextStyles.body16Medium.copyWith(color: ColorCode.neutral500, fontSize: 12.sp),
            )),
            // DataCell(CustomText(
            //   '0 ${AppStrings.sar}', // fixed revenue for now
            //   textStyle: TextStyles.body16Medium.copyWith(color: ColorCode.neutral500, fontSize: 12.sp),
            // )),
          ]);
        }),
      ),
    );
  }
}
