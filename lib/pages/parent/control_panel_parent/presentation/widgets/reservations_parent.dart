import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../../../../../consts/colors.dart';
import '../../../../../consts/text_styles.dart';
import '../../../../../resources/strings_generated.dart';
import '../../../../../widgets/custom_text.dart';
import '../../../../../widgets/gaps.dart';
import '../../../../center/control_panel/models/child_model.dart';
import '../controllers/control_panel_parent_controller.dart';
import 'child_reservation_card.dart';
import 'delete_child_dialog.dart';

class ReservationsParent extends GetView<ControlPanelParentController> {
  const ReservationsParent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: controller.obx(
              (state) => GetBuilder<ControlPanelParentController>(
              builder: (controller) {
                return ListView(
                    padding: const EdgeInsets.only(bottom: 16),
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: CustomText(
                              AppStrings.reservations,
                              textStyle: TextStyles.title24Medium,
                            ),
                          ),
                        ],
                      ),
                      Gaps.vGap16,
                      ...List.generate(
                        controller.children?.length ?? 0,
                            (index) => ChildReservationCard(
                          childModel:
                          controller.children?[index] ?? ChildModel(),
                          onTap: () {
                            showDeleteChildConfirmDialog(
                              context: context,
                              isDeletingMember: controller.isDeletingBranch,
                              onConfirm: () {
                                controller.deleteChild(
                                    controller.children?[index].id.toString() ??
                                        "");
                              },
                            );
                          },
                        ),
                      ),
                    ]);
              }),
          onLoading: const Center(
            child: SpinKitCircle(
              color: ColorCode.primary600,
            ),
          )),
    );
  }
}
