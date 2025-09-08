import 'package:first_step/consts/colors.dart';
import 'package:first_step/consts/text_styles.dart';
import 'package:first_step/resources/strings_generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../../widgets/custom_text.dart';
import '../controller/parent_payment_controller.dart';

class ParentPaymentScreen extends GetView<ParentPaymentController> {
  const ParentPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorCode.white,
      appBar: AppBar(
          centerTitle: true,
          title: CustomText(
            AppStrings.moyasarPayment,
            textStyle: TextStyles.title24Bold.copyWith(
                color: ColorCode.primary600),
          )),
      body: controller.obx(
              (state) =>
              Obx(() {
                return Stack(
                  children: [
                    WebViewWidget(
                        controller: controller.controller ??
                            WebViewController()),
                    if (controller.isLoading.value)
                      const Center(
                        child: SpinKitCircle(
                          color: ColorCode.primary600,
                        ),
                      ),
                  ],
                );
              }),
          onLoading: const Center(
            child: SpinKitCircle(
              color: ColorCode.primary600,
            ),
          )),
    );
  }
}
