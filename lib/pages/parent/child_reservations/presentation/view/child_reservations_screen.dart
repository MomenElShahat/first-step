import 'package:first_step/consts/colors.dart';
import 'package:first_step/pages/parent/child_reservations/presentation/view/widgets/enrollments_list_parent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../../../../../consts/text_styles.dart';
import '../../../../../resources/strings_generated.dart';
import '../../../../../widgets/custom_text.dart';
import '../../../../../widgets/gaps.dart';
import '../controller/child_reservations_controller.dart';

class ChildReservationsScreen extends GetView<ChildReservationsController> {
  const ChildReservationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorCode.white,
      appBar: AppBar(
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: ColorCode.white),
        toolbarHeight: 0,
      ),
      body: controller.obx(
          (state) => SingleChildScrollView(
            child: Column(
                  children: [
                    Gaps.vGap16,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: const Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: ColorCode.primary600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gaps.vGap16,
                    CustomText(
                      AppStrings.reservations,
                      textStyle: TextStyles.title24Medium,
                    ),
                    Gaps.vGap16,
                    if (controller.enrollments?.isEmpty ?? false) ...[
                      SizedBox(
                        height: Get.height / 3,
                      ),
                      Center(
                        child: CustomText(
                          AppStrings.noReservationsFound,
                          textStyle:
                              TextStyles.body16Medium.copyWith(fontSize: 20.sp),
                        ),
                      ),
                    ],
                    CenterEnrollmentListParent(
                      enrollments: controller.enrollments ?? [],
                    ),
                  ],
                ),
          ),
          onLoading: Column(
            children: [
              SizedBox(
                height: Get.height / 3,
              ),
              const Center(
                child: SpinKitCircle(
                  color: ColorCode.primary600,
                ),
              )
            ],
          )),
    );
  }
}
