import 'package:first_step/consts/colors.dart';
import 'package:first_step/consts/text_styles.dart';
import 'package:first_step/resources/assets_svg_generated.dart';
import 'package:first_step/resources/strings_generated.dart';
import 'package:first_step/widgets/custom_button.dart';
import 'package:first_step/widgets/custom_text.dart';
import 'package:first_step/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../../widgets/gaps.dart';
import '../controllers/signup_parent_controller.dart';
import '../widgets/step1.dart';

class SignupParentScreen extends GetView<SignupParentController> {
  const SignupParentScreen({super.key});

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
                AppStrings.createAParentAccount,
                textStyle: TextStyles.title24Bold
                    .copyWith(color: ColorCode.primary600),
              ),
            ),
            Gaps.vGap16,
            const Step1(),
          ],
        ),
      ),
    );
  }
}


