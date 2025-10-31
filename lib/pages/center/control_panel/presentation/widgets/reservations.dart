import 'package:first_step/pages/center/control_panel/presentation/controllers/control_panel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../consts/text_styles.dart';
import '../../../../../resources/strings_generated.dart';
import '../../../../../widgets/custom_text.dart';
import 'enrollments_list.dart';

class Reservations extends GetView<ControlPanelController> {
  const Reservations({super.key});

  @override
  Widget build(BuildContext context) {
    if (controller.enrollments?.isNotEmpty ?? false) {
      return CenterEnrollmentList(
        enrollments: controller.enrollments ?? [],
      );
    } else {
      return Column(
        children: [
          SizedBox(
            height: Get.height / 3,
          ),
          Center(
            child: CustomText(
              AppStrings.noReservationsFound,
              textStyle: TextStyles.body16Medium.copyWith(fontSize: 20.sp),
            ),
          ),
        ],
      );
    }
  }
}
