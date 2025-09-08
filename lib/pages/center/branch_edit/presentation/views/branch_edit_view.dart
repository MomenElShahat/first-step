import 'package:first_step/consts/colors.dart';
import 'package:first_step/consts/text_styles.dart';
import 'package:first_step/pages/center/branch_edit/presentation/views/widgets/step1.dart';
import 'package:first_step/pages/center/branch_edit/presentation/views/widgets/step2.dart';
import 'package:first_step/pages/center/branch_edit/presentation/views/widgets/step3.dart';
import 'package:first_step/pages/center/branch_edit/presentation/views/widgets/step4.dart';
import 'package:first_step/resources/assets_svg_generated.dart';
import 'package:first_step/resources/strings_generated.dart';
import 'package:first_step/widgets/custom_button.dart';
import 'package:first_step/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../../../../../../widgets/gaps.dart';
import '../../../../../utils/utils.dart';
import '../../../../../widgets/custom_text_form_field.dart';
import '../../../auth/signup/models/cities_model.dart';
import '../../../auth/signup/presentation/widgets/cities_dropdown.dart';
import '../../../auth/signup/presentation/widgets/days_dropdown.dart';
import '../../../auth/signup/presentation/widgets/step1.dart';
import '../controllers/branch_edit_controller.dart';

class BranchEditScreen extends GetView<BranchEditScreenController> {
  const BranchEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorCode.white,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: controller.obx(
          (state) => SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const BranchEditStep1(),
                      const BranchEditStep2(),
                      const BranchEditStep3(),
                      const BranchEditStep4(),
                      Gaps.vGap8,
                      Obx(() {
                        return Visibility(
                          visible: controller.isSaving.value,
                          replacement: Padding(
                            padding: const EdgeInsets.all(16),
                            child: CustomButton(
                              height: 54.h,
                              child: CustomText(
                                AppStrings.saveEdit,
                                textStyle: TextStyles.body16Medium
                                    .copyWith(color: ColorCode.white),
                              ),
                              onPressed: () async {
                                await controller.onSaveEditsClicked(
                                    context: context);
                              },
                            ),
                          ),
                          child: const Center(
                            child: SpinKitCircle(
                              color: ColorCode.primary600,
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
          onLoading: const Center(
            child: SpinKitCircle(
              color: ColorCode.primary600,
            ),
          )),
    );
  }
}
