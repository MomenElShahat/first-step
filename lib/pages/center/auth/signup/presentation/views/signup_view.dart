import 'package:first_step/consts/colors.dart';
import 'package:first_step/consts/text_styles.dart';
import 'package:first_step/resources/assets_svg_generated.dart';
import 'package:first_step/resources/strings_generated.dart';
import 'package:first_step/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../../../../../../widgets/gaps.dart';
import '../controllers/signup_controller.dart';
import '../widgets/step1.dart';
import '../widgets/step2.dart';
import '../widgets/step3.dart';
import '../widgets/step4.dart';
import '../widgets/step_widget.dart';

class SignupScreen extends GetView<SignupController> {
  const SignupScreen({super.key});

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
                    Center(
                        child: AppSVGAssets.getWidget(AppSVGAssets.signupLogo)),
                    Center(
                      child: CustomText(
                        AppStrings.createAccountCenter,
                        textStyle: TextStyles.title24Bold
                            .copyWith(color: ColorCode.primary600),
                      ),
                    ),
                    Gaps.vGap20,
                    Obx(() {
                      return ResponsiveStepper(currentIndex: controller.index.value,);
                    }),
                    Gaps.vGap16,
                    const Step1(),
                    // const Step2(),
                    // const Step3(),
                    const Step4(),
                  ],
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