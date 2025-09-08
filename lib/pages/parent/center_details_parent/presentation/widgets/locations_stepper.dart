import 'dart:math';

import 'package:first_step/consts/colors.dart';
import 'package:first_step/consts/text_styles.dart';
import 'package:first_step/resources/assets_svg_generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../models/center_portfolio_model.dart';

class TimelineScreen extends StatelessWidget {
  final List<Color> colors;
  final List<BranchesModel> locationNames;

  const TimelineScreen({super.key, required this.locationNames, required this.colors});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Timeline line
          Container(
            height: 2,
            width: max(MediaQuery.of(context).size.width, locationNames.length * 62), // dynamic width
            color: ColorCode.neutral400,
          ),
          Row(
            children: List.generate(locationNames.length, (index) {
              final isOdd = index % 2 == 0;
              final color = colors[index % colors.length];

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: isOdd
                      ? [
                          AppSVGAssets.getWidget(
                            AppSVGAssets.branchLocation,
                            color: color,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            locationNames[index].branchName ?? "",
                            style: TextStyles.title24Bold.copyWith(color: color, fontSize: 8.sp),
                          ),
                        ]
                      : [
                          Text(
                            locationNames[index].branchName ?? "",
                            style: TextStyles.title24Bold.copyWith(color: color, fontSize: 8.sp),
                          ),
                          const SizedBox(height: 8),
                          AppSVGAssets.getWidget(
                            AppSVGAssets.branchLocationDown,
                            color: color,
                          ),
                        ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class LocationData {
  final String name;
  final Color color;

  LocationData({required this.name, required this.color});
}

class LocationCircle extends StatelessWidget {
  final LocationData data;

  const LocationCircle(this.data);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Top circle
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: data.color.withOpacity(0.5),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: data.color,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
        // Hook base
        Container(
          width: 40,
          height: 10,
          decoration: BoxDecoration(
            color: data.color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ],
    );
  }
}
