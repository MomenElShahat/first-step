import 'package:first_step/consts/colors.dart';
import 'package:first_step/consts/text_styles.dart';
import 'package:first_step/resources/strings_generated.dart';
import 'package:first_step/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../routes/app_pages.dart';
import '../../../../../widgets/gaps.dart';
import '../../../../center/control_panel/models/chats_model.dart';
import '../../../../parent/control_panel_parent/models/nurseries_model.dart';
import '../controllers/control_panel_parent_controller.dart';

class ChatCardParent extends GetView<ControlPanelParentController> {
  final Contacts? chats;
  final NurseriesModel? nursery;

  const ChatCardParent({super.key, this.chats, this.nursery});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (chats == null) {
          Get.back();
        }
        Get.toNamed(Routes.CHAT_DETAILS_SCREEN, arguments: {
          "receiverId": chats?.contactId.toString() ?? nursery?.id.toString(),
          "name": chats?.contact?.name ?? nursery?.name,
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  clipBehavior: Clip.none,
                  fit: StackFit.passthrough,
                  children: [
                    Container(
                      height: 30,
                      width: 30,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: AlignmentDirectional(-1.0, -1.0),
                          end: AlignmentDirectional(1.0, 1.0),
                          colors: [
                            Color(0xFF83CBAA),
                            Color(0xFFE3FFF2),
                          ],
                          transform: GradientRotation(50.81 *
                              3.1416 /
                              180), // Convert degrees to radians
                        ),
                      ),
                      padding: const EdgeInsets.all(0),
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: controller.arabicRegex.hasMatch(chats != null
                                    ? chats?.contact?.name ?? ""
                                    : nursery?.name ?? "")
                                ? 0
                                : 5),
                        child: Center(
                            child: CustomText(
                                controller.getFirstTwoCapitalLetters(
                                    chats != null
                                        ? chats?.contact?.name ?? ""
                                        : nursery?.name ?? ""),
                                textStyle: TextStyles.subtitle20Medium.copyWith(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16.sp,
                                    color: ColorCode.white))),
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color.fromRGBO(34, 34, 34, 0.12),
                            Color.fromRGBO(34, 34, 34, 0.12),
                          ],
                        ),
                      ),
                    ),
                    if (chats != null)
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: chats?.isOnline == 1
                              ? ColorCode.info600
                              : ColorCode.neutral400,
                          border: Border.all(color: ColorCode.white, width: 2),
                        ),
                      ),
                  ],
                ),
                Gaps.hGap8,
                CustomText(
                  chats != null
                      ? chats?.contact?.name ?? ""
                      : nursery?.name ?? "",
                  textStyle: TextStyles.body16Regular
                      .copyWith(color: ColorCode.neutral500, fontSize: 12.sp),
                )
              ],
            ),
            if (chats != null && chats?.unreadCount != 0)
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: .5, color: ColorCode.primary600),
                ),
                padding: const EdgeInsetsDirectional.only(top: 5),
                child: Center(
                  child: CustomText(
                    chats?.unreadCount.toString() ?? "",
                    textStyle: TextStyles.button12.copyWith(
                        color: ColorCode.primary600,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
