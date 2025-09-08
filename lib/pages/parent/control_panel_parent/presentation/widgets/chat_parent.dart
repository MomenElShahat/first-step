import 'package:first_step/consts/colors.dart';
import 'package:first_step/consts/text_styles.dart';
import 'package:first_step/resources/assets_svg_generated.dart';
import 'package:first_step/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../resources/strings_generated.dart';
import '../../../../../widgets/gaps.dart';
import '../../../../center/control_panel/models/chats_model.dart';
import '../../../../center/control_panel/presentation/widgets/chat_card.dart';
import '../controllers/control_panel_parent_controller.dart';
import 'chat_card_parent.dart';

class ChatParent extends GetView<ControlPanelParentController> {
  const ChatParent({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ControlPanelParentController>(builder: (controller) {
      return SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: CustomText(
                AppStrings.chats,
                textStyle: TextStyles.title24Medium
                    .copyWith(color: ColorCode.primary600),
              ),
            ),
            ...List.generate(
              controller.chats?.length ?? 0,
                  (index) =>
                  ChatCardParent(
                    chats: controller.chats?[index] ?? Contacts(),
                  ),
            ),
            if(controller.chats?.isEmpty ?? false)
              ...[
                Gaps.vGap50,
                CustomText(
                  AppStrings.noChatsFound, textStyle: TextStyles.body16Medium,),
                Gaps.vGap50,
              ],
            Gaps.vGap50,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      Get.dialog(Dialog(
                        backgroundColor: ColorCode.white,
                        insetPadding: const EdgeInsets.symmetric(
                            horizontal: 16),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                CustomText(
                                  AppStrings.centers,
                                  textStyle: TextStyles.body16Medium
                                      .copyWith(color: ColorCode.primary600),
                                ),
                                Gaps.vGap8,
                                ...List.generate(
                                  controller.chatNurseries.length,
                                      (index) =>
                                      ChatCardParent(
                                        nursery: controller
                                            .chatNurseries[index],
                                      ),
                                ),
                                if (controller.chatNurseries.isEmpty)
                                  ...[
                                    Gaps.vGap40,
                                    CustomText(
                                      AppStrings.noNurseriesFound,
                                      textStyle: TextStyles.body16Medium,
                                    ),
                                    Gaps.vGap40,
                                  ],
                              ],
                            ),
                          ),
                        ),
                      ));
                    },
                    child: SizedBox(
                      child: Row(
                        children: [
                          CustomText(
                            AppStrings.chat,
                            textStyle: TextStyles.body14Regular.copyWith(
                                color: ColorCode.primary600, height: 1.5),
                          ),
                          Gaps.hGap8,
                          AppSVGAssets.getWidget(AppSVGAssets.plusBold,
                              width: 14, height: 14)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
