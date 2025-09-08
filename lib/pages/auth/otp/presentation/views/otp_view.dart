import 'package:first_step/consts/colors.dart';
import 'package:first_step/consts/text_styles.dart';
import 'package:first_step/widgets/custom_snackbar.dart';
import 'package:first_step/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:first_step/resources/assets_svg_generated.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../../../resources/strings_generated.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../../widgets/custom_button.dart';
import '../../../../../widgets/gaps.dart';
import '../controllers/otp_controller.dart';

class OtpScreen extends GetView<OtpController> {
  const OtpScreen({super.key});

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
        child: Center(
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gaps.vGap(100),
                Center(child: AppSVGAssets.getWidget(AppSVGAssets.signupLogo)),
                Center(
                  child: CustomText(
                    AppStrings.otpCode,
                    textStyle: TextStyles.title24Bold
                        .copyWith(color: ColorCode.primary600),
                  ),
                ),
                Gaps.vGap16,
                Center(
                  child: CustomText(
                    AppStrings.checkYourEmail,
                    textStyle: TextStyles.body16Medium
                        .copyWith(color: ColorCode.neutral500),
                  ),
                ),
                Gaps.vGap16,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: PinCodeTextField(
                    appContext: context,
                    controller: controller.pinController,
                    length: 4,
                    keyboardType: TextInputType.number,
                    textStyle: TextStyles.title32Bold
                        .copyWith(color: ColorCode.neutral500),
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(8),
                      fieldHeight: 80.h,
                      fieldWidth: 60.w,
                      activeColor: ColorCode.neutral400,
                      selectedColor: ColorCode.neutral400,
                      inactiveColor: ColorCode.neutral400,
                    ),
                    onChanged: (value) {},
                  ),
                ),
                Gaps.vGap16,
                GetBuilder<OtpController>(builder: (controller) {
                  return Center(
                    child: CustomText(
                      "${AppStrings.theCodeWillExpireIn} ${controller.secondsRemaining.toString().padLeft(2, '0')}:00",
                      textStyle: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    ),
                  );
                }),
                Gaps.vGap16,
                controller.obx(
                    (state) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: CustomButton(
                            onPressed: () {
                              if (controller.formKey.currentState?.validate() ??
                                  false) {
                                controller.onCheckCodeClicked(context);
                              }
                            },
                            child: CustomText(
                              AppStrings.confirm,
                              textStyle: TextStyles.body16Medium.copyWith(
                                  color: ColorCode.neutral10,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                    onLoading: const Center(
                      child: SpinKitCircle(
                        color: ColorCode.primary600,
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
