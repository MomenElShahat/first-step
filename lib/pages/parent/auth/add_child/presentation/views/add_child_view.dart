import 'package:first_step/consts/colors.dart';
import 'package:first_step/consts/text_styles.dart';
import 'package:first_step/resources/assets_svg_generated.dart';
import 'package:first_step/resources/strings_generated.dart';
import 'package:first_step/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../widgets/gaps.dart';
import '../controllers/add_child_controller.dart';
import '../widgets/step1.dart';
import '../widgets/step2.dart';
import '../widgets/step3.dart';
import '../widgets/step4.dart';
import '../widgets/step_widget_parent.dart';

class AddChildScreen extends GetView<AddChildController> {
  const AddChildScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorCode.white,
      appBar: AppBar(
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: ColorCode.white),
        toolbarHeight: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(child: AppSVGAssets.getWidget(AppSVGAssets.signupLogo)),
            Center(
              child: CustomText(
                AppStrings.addChild,
                textStyle: TextStyles.title24Bold
                    .copyWith(color: ColorCode.primary600),
              ),
            ),
            Gaps.vGap20,
            // Obx(() {
            //   return ResponsiveStepperParent(currentIndex: controller.index.value,);
            // }),
            // Gaps.vGap16,
            const Step1(),
            // const Step2(),
            // const Step3(),
            // const Step4(),
          ],
        ),
      ),
    );
  }
}


