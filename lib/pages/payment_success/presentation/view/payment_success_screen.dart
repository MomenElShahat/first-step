import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:first_step/pages/payment_success/presentation/controller/payment_success_controller.dart';

import '../../../../consts/colors.dart';
import '../../../../consts/text_styles.dart';
import '../../../../resources/assets_generated.dart';
import '../../../../resources/assets_svg_generated.dart';
import '../../../../resources/strings_generated.dart';
import '../../../../routes/app_pages.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/gaps.dart';
import '../../../bottom_navigation/controller/main_controller.dart';

class PaymentSuccessScreen extends GetView<PaymentSuccessController> {
  const PaymentSuccessScreen({super.key});

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
          (state) => Stack(
                children: [
                  PositionedDirectional(
                    top: 0,
                    end: 0,
                    child: AppSVGAssets.getWidget(AppSVGAssets.sketches1),
                  ),
                  PositionedDirectional(
                    bottom: 0,
                    start: 0,
                    child: AppSVGAssets.getWidget(AppSVGAssets.sketches2),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Image(
                          image: AppAssets.pinCodeSecuredPayment,
                          fit: BoxFit.fill,
                        ),
                        Gaps.vGap16,
                        CustomText(
                          AppStrings.paymentSuccessful,
                          textStyle: TextStyles.title24Bold
                              .copyWith(color: ColorCode.neutral600),
                        ),
                        Gaps.vGap16,
                        CustomText(
                          AppStrings.weAreHappyToHaveYouJoinTheFirstStepFamily,
                          textStyle: TextStyles.body14Regular
                              .copyWith(color: ColorCode.neutral500),
                        ),
                        Gaps.vGap64,
                        InkWell(
                          onTap: () {
                            // Get.put(MainController());
                            // final MainController controller = Get.find<MainController>();
                            // controller.bottomController.index = 0;
                            // controller.bottomController.jumpToTab(0);
                            // controller.selectedIndex.value = 0;
                            // controller.update();
                            Get.offAllNamed(Routes.BOTTOM_NAVIGATION,
                                arguments: 0.obs);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                transform: GradientRotation(
                                    98.52 * (3.14159265 / 180)),
                                // convert degrees to radians
                                colors: [
                                  Color(0xFF7A8CFD), // 11.17%
                                  Color(0xFF404FB1), // 63.74%
                                  Color(0xFF2B3990), // 94.71%
                                ],
                                stops: [
                                  0.1117,
                                  0.6374,
                                  0.9471,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 10.5),
                            margin: const EdgeInsets.symmetric(horizontal: 60),
                            child: Center(
                              child: CustomText(
                                AppStrings.goToYourControlPanel,
                                textStyle: TextStyles.body16Medium.copyWith(
                                    color: ColorCode.white,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
          onLoading: const Center(
              child: SpinKitCircle(
            color: ColorCode.primary600,
          ))),
    );
  }
}
