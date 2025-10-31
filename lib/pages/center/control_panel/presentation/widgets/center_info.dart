import 'dart:io';

import 'package:first_step/consts/colors.dart';
import 'package:first_step/pages/center/control_panel/presentation/controllers/control_panel_controller.dart';
import 'package:first_step/pages/center/control_panel/presentation/widgets/branch_card.dart';
import 'package:first_step/pages/center/control_panel/presentation/widgets/expandable_section_item.dart';
import 'package:first_step/pages/center/control_panel/presentation/widgets/priceing_widget.dart';
import 'package:first_step/pages/center/control_panel/presentation/widgets/pricing_section.dart';
import 'package:first_step/pages/center/control_panel/presentation/widgets/services_section.dart';
import 'package:first_step/pages/center/control_panel/presentation/widgets/team_section.dart';
import 'package:first_step/resources/assets_svg_generated.dart';
import 'package:first_step/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../../../../consts/text_styles.dart';
import '../../../../../resources/strings_generated.dart';
import '../../../../../widgets/custom_text.dart';
import '../../../../../widgets/gaps.dart';
import '../../../../parent/center_details_parent/presentation/widgets/portfolio_progress_bar.dart';
import 'delete_branch_dialog.dart';

class CenterInfo extends GetView<ControlPanelController> {
  const CenterInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SafeArea(
        child: GetBuilder<ControlPanelController>(builder: (controller) {
          return ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.only(bottom: 16),
            children: [
              CustomText(
                AppStrings.nurseryProfile,
                textStyle: TextStyles.title24Medium.copyWith(color: ColorCode.primary600),
              ),
              Gaps.vGap16,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: PortfolioProgressBar(
                  percentage: controller.percentage ?? 0,
                ),
              ),
              Gaps.vGap16,
              Obx(
                () => _buildSection(0, AppStrings.mainSection, _mainSectionForm(controller), controller, () {
                  controller.resetMainSection();
                }),
              ),
              Obx(
                () => _buildSection(1, AppStrings.branches, _branchesForm(controller), controller, () {
                  controller.resetBranchesSection();
                }),
              ),
              Obx(
                () => _buildSection(2, AppStrings.yourAdvertisingSpace, _adsForm(controller), controller, () {
                  controller.resetAdsSection();
                }),
              ),
              Obx(
                () => _buildSection(
                    3, "${AppStrings.ourPhilosophy},${AppStrings.ourMethodology},${AppStrings.ourGoal}", _ourGoalsSectionForm(controller), controller,
                    () {
                  controller.resetGoalsSection();
                }),
              ),
              Obx(
                () => _buildSection(4, AppStrings.ourPrograms, const PricingSection(), controller, () {
                  controller.resetGoalsSection();
                }),
              ),
              Obx(
                () => _buildSection(
                    5,
                    AppStrings.ourServices,
                    ServicesSection(
                      controller: controller,
                    ),
                    controller, () {
                  controller.resetOurServicesSection();
                }),
              ),
              Obx(
                () => _buildSection(6, AppStrings.centerInfo, _centerInfoSectionForm(controller), controller, () {
                  controller.resetCenterInfoSection();
                }),
              ),
              Obx(
                () => _buildSection(7, AppStrings.activities, _activitiesForm(controller), controller, () {
                  controller.resetActivitiesSection();
                }),
              ),
              Obx(
                () => _buildSection(
                    8,
                    AppStrings.ourTeam,
                    TeamSection(
                      controller: controller,
                    ),
                    controller, () {
                  controller.resetOurTeamsSection();
                }),
              ),
              Gaps.vGap16,
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    children: [
                      Obx(() {
                        return Visibility(
                          visible: controller.isUpdating.value == false,
                          replacement: const Center(
                            child: SpinKitCircle(
                              color: ColorCode.primary600,
                            ),
                          ),
                          child: Expanded(
                              flex: 2,
                              child: GestureDetector(
                                onTap: () {
                                  // Collect all data and submit
                                  controller.collectCenterInfoData();
                                  // You can now use controller.centerInfoModel for API submission
                                  // Example: controller.getCenterInfoJson() for JSON
                                  // Example: controller.getCenterInfoFormData() for FormData
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.r),
                                    gradient: const LinearGradient(
                                      begin: Alignment.centerRight,
                                      end: Alignment.centerLeft,
                                      transform: GradientRotation(98.52 * (3.1415926535 / 180)),
                                      // Convert degrees to radians
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
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 10.5),
                                  child: CustomText(
                                    AppStrings.confirm,
                                    textStyle: TextStyles.body16Medium.copyWith(color: ColorCode.white),
                                  ),
                                ),
                              )),
                        );
                      }),
                      Gaps.hGap32,
                      Expanded(
                          flex: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              border: Border.all(color: ColorCode.neutral400),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 10.5),
                            child: CustomText(
                              AppStrings.cancel,
                              textStyle: TextStyles.body16Medium.copyWith(color: ColorCode.neutral500),
                            ),
                          )),
                    ],
                  ))
              // _buildSection(
              //     1, 'القسم الثاني', _secondSectionForm(), controller),
              // _buildSection(2, 'القسم الثالث', _thirdSectionForm(), controller),
            ],
          );
        }),
      ),
    );
  }
}

Widget _buildSection(int index, String title, Widget expandedContent, ControlPanelController controller, VoidCallback onReset) {
  return ExpandableSectionItem(
    title: title,
    isExpanded: controller.expandedIndex.value == index,
    onEdit: () {
      controller.expandedIndex.value = (controller.expandedIndex.value == index ? -1 : index);
    },
    onReset: onReset,
    expandedContent: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        expandedContent,
      ],
    ),
  );
}

Widget _mainSectionForm(ControlPanelController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildTextField(AppStrings.centerName, AppStrings.egHopeCenter, controller.centerNameController),
      _buildTextField(AppStrings.centerSlogan, AppStrings.egWeLiveByHope, controller.centerSloganController),
      _buildTextField(AppStrings.description, AppStrings.description, controller.centerdescController),
      CustomText(
        AppStrings.backgroundImage,
        textStyle: TextStyles.body14Regular.copyWith(color: ColorCode.neutral500),
      ),
      Gaps.vGap4,
      InkWell(
        onTap: () async {
          controller.centerBackgroundImage = await controller.pickImage();
          controller.centerimageController.text = controller.centerBackgroundImage?.path.split('/').last ?? "";
        },
        child: CustomTextFormField(
            hint: AppStrings.selectAFile,
            onSave: (String? val) {
              controller.centerimageController.text = val!;
            },
            readOnly: true,
            enable: false,
            onTap: () async {
              controller.centerBackgroundImage = await controller.pickImage();
              controller.centerimageController.text = controller.centerBackgroundImage?.path.split('/').last ?? "";
            },
            suffixIcon: AppSVGAssets.getWidget(AppSVGAssets.attachLine, width: 16, height: 16, color: ColorCode.neutral400),
            onChange: (String? val) {
              controller.centerimageController.text = val!;
              // final englishText = convertArabicToEnglish(val ??"");
              // controller.floorNumber.value  =controller.floorNumber.value.copyWith(
              //   text: englishText,
              //   selection: TextSelection.collapsed(offset: englishText.length),
              // );
            },
            controller: controller.centerimageController,
            validator: (p0) => null,
            // validator: (val) {
            //   return (controller.centerimageController.text.isNotEmpty)
            //       ? null
            //       : AppStrings.emptyField;
            // },
            inputType: TextInputType.text,
            label: ""),
      ),
      // _buildTextField("زر اتخاذ القرار", "مثلاً: احجز معنا"),
    ],
  );
}

Widget _branchesForm(ControlPanelController controlPanelController) {
  return Obx(() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...controlPanelController.branchControllers.asMap().entries.map((entry) {
          final i = entry.key;
          final controller = entry.value;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: _buildTextField(AppStrings.branchName, AppStrings.egBranchNames, controller),
              ),
              if (i > 0)
                IconButton(
                  icon: AppSVGAssets.getWidget(AppSVGAssets.delete),
                  onPressed: () => controlPanelController.removeBranch(i),
                ),
            ],
          );
        }),
        Center(
          child: TextButton.icon(
            onPressed: controlPanelController.addBranch,
            icon: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: CustomText(
                AppStrings.addBranch,
                textStyle: TextStyles.body14Medium.copyWith(
                  color: ColorCode.primary600,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            label: AppSVGAssets.getWidget(AppSVGAssets.plusLine, color: ColorCode.primary600, width: 16, height: 16),
          ),
        ),
      ],
    );
  });
}

Widget _adsForm(ControlPanelController controlPanelController) {
  return Obx(() {
    return Column(
      children: [
        ...controlPanelController.adImages.asMap().entries.map((entry) {
          final i = entry.key;
          final image = entry.value;

          return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    AppStrings.backgroundImage,
                    textStyle: TextStyles.body14Regular.copyWith(color: ColorCode.neutral500),
                  ),
                  Gaps.vGap4,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: InkWell(
                      onTap: () => controlPanelController.pickAdsImage(i),
                      child: Container(
                        height: 52.h,
                        decoration: BoxDecoration(
                          border: Border.all(color: ColorCode.neutral400),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                image is File?
                                    ? image?.path.split('/').last ?? AppStrings.selectAFile
                                    : image?.split('/').last ?? AppStrings.selectAFile,
                                style: TextStyle(
                                  color: image == null ? Colors.grey : Colors.black,
                                ),
                              ),
                            ),
                            AppSVGAssets.getWidget(AppSVGAssets.attachLine, color: ColorCode.neutral400),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (i > 0)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: AppSVGAssets.getWidget(AppSVGAssets.delete),
                          onPressed: () => controlPanelController.removeAdImage(i),
                        ),
                      ],
                    ),
                ],
              ));
        }),
        TextButton.icon(
          onPressed: controlPanelController.addAdImage,
          icon: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: CustomText(
              AppStrings.add,
              textStyle: TextStyles.body14Medium.copyWith(
                color: ColorCode.primary600,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          label: AppSVGAssets.getWidget(AppSVGAssets.plusLine, color: ColorCode.primary600, width: 16, height: 16),
        ),
      ],
    );
  });
}

Widget _ourGoalsSectionForm(ControlPanelController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildTextField(AppStrings.ourPhilosophy, AppStrings.ourPhilosophy, controller.ourPhilosophyController),
      _buildTextField(AppStrings.ourMethodology, AppStrings.ourMethodology, controller.ourMethodologyController),
      _buildTextField(AppStrings.ourGoal, AppStrings.ourGoal, controller.ourGoalController),
    ],
  );
}

Widget _centerInfoSectionForm(ControlPanelController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildTextField(AppStrings.nurserySpace, AppStrings.nurserySpace, controller.nurserySpaceController),
      _buildTextField(AppStrings.numberOfClasses, AppStrings.numberOfClasses, controller.numberOfClassesController),
      _buildTextField(AppStrings.numberOfTeamMembers, AppStrings.numberOfTeamMembers, controller.numberOfTeamMembersController),
    ],
  );
}

Widget _activitiesForm(ControlPanelController controlPanelController) {
  return Obx(() {
    return Column(
      children: [
        _buildTextField(AppStrings.theActivitiesInTheCenter, AppStrings.egCinemaCookingChessSwimming, controlPanelController.activitiesController),
        Gaps.vGap8,
        ...controlPanelController.activities.asMap().entries.map((entry) {
          final i = entry.key;
          final image = entry.value;

          return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    AppStrings.backgroundImage,
                    textStyle: TextStyles.body14Regular.copyWith(color: ColorCode.neutral500),
                  ),
                  Gaps.vGap4,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: InkWell(
                      onTap: () => controlPanelController.pickActivitiesImage(i),
                      child: Container(
                        height: 52.h,
                        decoration: BoxDecoration(
                          border: Border.all(color: ColorCode.neutral400),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                image is File?
                                    ? image?.path.split('/').last ?? AppStrings.selectAFile
                                    : image?.split('/').last ?? AppStrings.selectAFile,
                                style: TextStyle(
                                  color: image == null ? Colors.grey : Colors.black,
                                ),
                              ),
                            ),
                            AppSVGAssets.getWidget(AppSVGAssets.attachLine, color: ColorCode.neutral400),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (i > 0)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: AppSVGAssets.getWidget(AppSVGAssets.delete),
                          onPressed: () => controlPanelController.removeActivity(i),
                        ),
                      ],
                    ),
                ],
              ));
        }),
        TextButton.icon(
          onPressed: controlPanelController.addActivity,
          icon: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: CustomText(
              AppStrings.addImage,
              textStyle: TextStyles.body14Medium.copyWith(
                color: ColorCode.primary600,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          label: AppSVGAssets.getWidget(AppSVGAssets.plusLine, color: ColorCode.primary600, width: 16, height: 16),
        ),
      ],
    );
  });
}

Widget _buildTextField(String label, String hint, TextEditingController textEditingController, {IconData? icon}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CustomText(
        label,
        textStyle: TextStyles.body14Regular.copyWith(color: ColorCode.neutral500),
      ),
      Gaps.vGap4,
      CustomTextFormField(
          hint: hint,
          onSave: (String? val) {
            textEditingController.text = val!;
          },
          validator: (p0) => null,
          onChange: (String? val) {
            textEditingController.text = val!;
            // final englishText = convertArabicToEnglish(val ??"");
            // controller.floorNumber.value  =controller.floorNumber.value.copyWith(
            //   text: englishText,
            //   selection: TextSelection.collapsed(offset: englishText.length),
            // );
          },
          controller: textEditingController,
          // validator: (val) {
          //   return (controller.neighborhood.text.isNotEmpty)
          //       ? null
          //       : AppStrings.emptyField;
          // },
          inputType: TextInputType.text,
          label: ""),
      Gaps.vGap12,
    ],
  );
}
