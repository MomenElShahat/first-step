import 'package:first_step/consts/text_styles.dart';
import 'package:first_step/resources/assets_svg_generated.dart';
import 'package:first_step/resources/strings_generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../../../../consts/colors.dart';
import '../../../../../resources/assets_generated.dart';
import '../../../../../utils/utils.dart';
import '../../../../../widgets/custom_text.dart';
import '../../../../../widgets/custom_text_form_field.dart';
import '../../../../../widgets/gaps.dart';
import '../controller/add_parents_controller.dart';

class AddParentsScreen extends GetView<AddParentsController> {
  const AddParentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorCode.white,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: SafeArea(
        child: Obx(() {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gaps.vGap16,
                Center(
                  child: CustomText(
                    AppStrings.createParentAccounts,
                    textStyle: TextStyles.title24Bold.copyWith(color: ColorCode.primary600),
                  ),
                ),
                Gaps.vGap8,
                Center(
                  child: CustomText(
                    AppStrings.createParentAccounts,
                    textStyle: TextStyles.title24Bold.copyWith(color: ColorCode.primary600, fontSize: 16.sp),
                  ),
                ),
                Gaps.vGap24,

                // Display existing parents as cards
                ...controller.parents.asMap().entries.map((entry) {
                  int parentIndex = entry.key;
                  var parent = entry.value;
                  bool isCurrentParent = parentIndex == controller.currentParentIndex.value;

                  // If parent has no name, show placeholder
                  final parentDisplayName = (parent.nameText.isNotEmpty) ? parent.nameText : "${AppStrings.parentData} ${parentIndex + 1}";

                  // Show detailed card (Parent data + children) ONLY when this parent is the current and has children
                  final showDetailed = isCurrentParent && parent.children.isNotEmpty;

                  return Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        color: ColorCode.neutral400,
                      ),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          parentDisplayName,
                          textStyle: TextStyles.body16Medium.copyWith(color: ColorCode.primary600, fontWeight: FontWeight.bold),
                        ),
                        if (showDetailed) ...[
                          Gaps.vGap8,
                          // List children with index
                          ...parent.children.asMap().entries.map((childEntry) {
                            final childIndex = childEntry.key;
                            final child = childEntry.value;
                            final childNameDisplay =
                                (child.childNameText.isNotEmpty) ? child.childNameText : "${AppStrings.childData} ${childIndex + 1}";

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    childNameDisplay,
                                    textStyle: TextStyles.body16Medium.copyWith(fontWeight: FontWeight.w500, color: ColorCode.primary600),
                                  ),
                                  // Gaps.vGap4,
                                  // CustomText(
                                  //   childNameDisplay,
                                  //   textStyle: TextStyles.body14Medium.copyWith(color: ColorCode.neutral600),
                                  // ),
                                ],
                              ),
                            );
                          }),
                        ],
                      ],
                    ),
                  );
                }).toList(),

                Gaps.vGap16,

                // Show parent form if it's the first parent or adding new parent (controlled by controller.shouldShowParentForm)
                if (controller.shouldShowParentForm) ...[
                  _buildParentForm(),
                  Gaps.vGap16,
                ],

                // Always show child form (user can add child to current parent)
                _buildChildForm(),

                Gaps.vGap24,

                // Add Another Child Button
                InkWell(
                  borderRadius: BorderRadius.circular(8.r),
                  onTap: () {
                    controller.addChild();
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.r), border: Border.all(color: ColorCode.primary600)),
                    padding: const EdgeInsets.symmetric(vertical: 10.5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppSVGAssets.getWidget(AppSVGAssets.plusLine, color: ColorCode.primary600),
                        Gaps.hGap16,
                        CustomText(
                          AppStrings.addAnotherChild,
                          textStyle: TextStyles.body16Medium.copyWith(color: ColorCode.primary600, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),

                Gaps.vGap24,

                // Bottom buttons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Obx(() {
                        return Visibility(
                          visible: !controller.isSaving.value,
                          replacement: const Center(
                            child: SpinKitCircle(
                              color: ColorCode.primary600,
                            ),
                          ),
                          child: Expanded(
                            child: InkWell(
                              borderRadius: BorderRadius.circular(8.r),
                              onTap: () async {
                                final isParentFilled = controller.isParentFormFilled();
                                final isChildFilled = controller.isChildFormFilled();

                                // CASE 1: parents list empty
                                if (controller.parents.isEmpty) {
                                  if ((controller.formKey.currentState?.validate() ?? false) && isParentFilled && isChildFilled) {
                                    // both parent and child forms filled → create first parent
                                    controller.addNewParent();
                                    await controller.addParent();
                                  } else {}
                                }
                                // CASE 2: parents exist
                                else {
                                  // both parent & child forms filled → add another parent with child
                                  if ((controller.formKey.currentState?.validate() ?? false) && isParentFilled && isChildFilled) {
                                    controller.addNewParent();
                                    await controller.addParent();
                                  }
                                  // both parent & child forms empty → send API
                                  else if (!isParentFilled && !isChildFilled) {
                                    await controller.addParent();
                                  }
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    begin: Alignment(-0.15, -1.0),
                                    end: Alignment(1.0, 0.15),
                                    colors: [
                                      Color(0xFF7A8CFD),
                                      Color(0xFF404FB1),
                                      Color(0xFF2B3990),
                                    ],
                                    stops: [0.1117, 0.6374, 0.9471],
                                  ),
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 10.5),
                                child: CustomText(
                                  AppStrings.confirmAccountCreation,
                                  textStyle: TextStyles.body16Medium.copyWith(color: ColorCode.white, fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                      Gaps.hGap(24),
                      Expanded(
                        child: Obx(() => InkWell(
                              borderRadius: BorderRadius.circular(8.r),
                              onTap: controller.canAddAnotherParentWithChild
                                  ? () {
                                      controller.addNewParent();
                                    }
                                  : null,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.r),
                                    border: Border.all(color: controller.canAddAnotherParentWithChild ? ColorCode.primary600 : ColorCode.neutral300)),
                                padding: const EdgeInsets.symmetric(vertical: 10.5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AppSVGAssets.getWidget(AppSVGAssets.plusLine,
                                        color: controller.canAddAnotherParentWithChild ? ColorCode.primary600 : ColorCode.neutral400),
                                    Gaps.hGap8,
                                    CustomText(
                                      AppStrings.addAnotherParent,
                                      textStyle: TextStyles.body16Medium.copyWith(
                                          color: controller.canAddAnotherParentWithChild ? ColorCode.primary600 : ColorCode.neutral400,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
                Gaps.vGap24,
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildParentForm() {
    return Form(
      key: controller.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CustomText(
              AppStrings.parentData,
              textStyle: TextStyles.title24Bold.copyWith(color: ColorCode.primary600, fontSize: 16.sp),
            ),
          ),
          Gaps.vGap16,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(text: AppStrings.name, style: TextStyles.body14Medium.copyWith(color: ColorCode.neutral500)),
                  TextSpan(text: "*", style: TextStyles.body14Medium.copyWith(color: ColorCode.danger700)),
                ],
              ),
            ),
          ),
          Gaps.vGap8,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CustomTextFormField(
                hint: AppStrings.fullNameAsOnId,
                onSave: (String? val) {
                  controller.name.text = val ?? '';
                  controller.updateParentValidation();
                },
                onChange: (String? val) {
                  controller.name.text = val ?? '';
                  controller.updateParentValidation();
                },
                controller: controller.name,
                validator: (val) {
                  return (controller.name.text.isNotEmpty) ? null : AppStrings.emptyField;
                },
                inputType: TextInputType.text,
                label: ""),
          ),
          Gaps.vGap16,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(text: AppStrings.email, style: TextStyles.body14Medium.copyWith(color: ColorCode.neutral500)),
                  TextSpan(text: "*", style: TextStyles.body14Medium.copyWith(color: ColorCode.danger700)),
                ],
              ),
            ),
          ),
          Gaps.vGap8,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CustomTextFormField(
                hint: AppStrings.egEmail,
                onSave: (String? val) {
                  controller.email.text = val ?? '';
                  controller.updateParentValidation();
                },
                onChange: (String? val) {
                  controller.email.text = val ?? '';
                  controller.updateParentValidation();
                },
                controller: controller.email,
                validator: (val) {
                  return isValidEmail(controller.email.text) ? null : AppStrings.validateMail;
                },
                inputType: TextInputType.text,
                label: ""),
          ),
          Gaps.vGap16,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(text: AppStrings.mobileNumber, style: TextStyles.body14Medium.copyWith(color: ColorCode.neutral500)),
                  TextSpan(text: "*", style: TextStyles.body14Medium.copyWith(color: ColorCode.danger700)),
                ],
              ),
            ),
          ),
          Gaps.vGap8,
          Directionality(
            textDirection: TextDirection.ltr,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey.shade100,
                        ),
                        child: const Text(
                          '+966 🇸🇦', // Saudi code with flag
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Gaps.hGap8,
                      Expanded(
                        child: CustomTextFormField(
                          hint: AppStrings.egMobileNumber,
                          onSave: (val) => controller.mobileNumber.text = val ?? '',
                          onChange: (val) {
                            controller.mobileNumber.text = val ?? '';
                            controller.phone.value = controller.mobileNumber.text;
                          },
                          maxLength: 9,
                          controller: controller.mobileNumber,
                          // ✅ Don't use the internal validator
                          validator: (_) => null,
                          inputType: TextInputType.phone,
                          label: "",
                        ),
                      ),
                    ],
                  ),
                  // ✅ Custom error text below (keeps field position stable)
                  Obx(() {
                    final isValid = isValidSaudiNumber(controller.phone.value);
                    return isValid
                        ? const SizedBox.shrink()
                        : Padding(
                      padding: const EdgeInsets.only(left: 72, top: 4),
                      child: CustomText(
                        AppStrings.phoneValidation,
                        textAlign: TextAlign.start,
                        textStyle: TextStyles.button12.copyWith(
                            color: ColorCode.danger700,
                            fontWeight: FontWeight.w400),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChildForm() {
    return Form(
      key: controller.formKeyChild,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CustomText(
              AppStrings.childData,
              textStyle: TextStyles.body16Medium.copyWith(color: ColorCode.primary600),
            ),
          ),
          Gaps.vGap16,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(text: AppStrings.childName, style: TextStyles.body14Medium.copyWith(color: ColorCode.neutral500)),
                  TextSpan(text: "*", style: TextStyles.body14Medium.copyWith(color: ColorCode.danger700)),
                ],
              ),
            ),
          ),
          Gaps.vGap8,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CustomTextFormField(
                hint: AppStrings.egZiad,
                onSave: (String? val) {
                  controller.childName.text = val ?? '';
                },
                onChange: (String? val) {
                  controller.childName.text = val ?? '';
                  controller.updateChildValidation();
                },
                controller: controller.childName,
                validator: (val) {
                  return (controller.childName.text.isNotEmpty) ? null : AppStrings.emptyField;
                },
                inputType: TextInputType.text,
                label: ""),
          ),
          Gaps.vGap16,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(text: AppStrings.dateOfBirth, style: TextStyles.body14Medium.copyWith(color: ColorCode.neutral500)),
                  TextSpan(text: "*", style: TextStyles.body14Medium.copyWith(color: ColorCode.danger700)),
                ],
              ),
            ),
          ),
          Gaps.vGap8,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: InkWell(
              onTap: () async {
                controller.dateOfBirth.text = await controller.pickDate(Get.context!) ?? "";
                controller.updateChildValidation();
              },
              child: CustomTextFormField(
                  hint: "08/08/2019",
                  onSave: (String? val) {
                    controller.dateOfBirth.text = val ?? '';
                  },
                  readOnly: true,
                  enable: false,
                  onChange: (String? val) {
                    controller.dateOfBirth.text = val ?? '';
                    controller.updateChildValidation();
                  },
                  controller: controller.dateOfBirth,
                  validator: (val) {
                    return (controller.dateOfBirth.text.isNotEmpty) ? null : AppStrings.emptyField;
                  },
                  inputType: TextInputType.text,
                  label: ""),
            ),
          ),
          Gaps.vGap16,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(text: AppStrings.kinship, style: TextStyles.body14Medium.copyWith(color: ColorCode.neutral500)),
                  TextSpan(text: "*", style: TextStyles.body14Medium.copyWith(color: ColorCode.danger700)),
                ],
              ),
            ),
          ),
          Gaps.vGap8,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CustomTextFormField(
                hint: AppStrings.egFatherGrandmotherOrUncle,
                onSave: (String? val) {
                  controller.kinship.text = val ?? '';
                },
                onChange: (String? val) {
                  controller.kinship.text = val ?? '';
                  controller.updateChildValidation();
                },
                controller: controller.kinship,
                validator: (val) {
                  return (controller.kinship.text.isNotEmpty) ? null : AppStrings.emptyField;
                },
                inputType: TextInputType.text,
                label: ""),
          ),
          Gaps.vGap16,
          Center(
            child: CustomText(
              AppStrings.babyGender,
              textStyle: TextStyles.body16Medium.copyWith(color: ColorCode.primary600),
            ),
          ),
          Gaps.vGap8,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Obx(() {
              return Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        controller.selectedGender.value = AppStrings.boy;
                        controller.updateChildValidation();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            border:
                                Border.all(color: controller.selectedGender.value == AppStrings.boy ? ColorCode.secondary600 : ColorCode.neutral400)),
                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
                        child: Column(
                          children: [
                            Image(
                              image: controller.selectedGender.value == AppStrings.boy ? AppAssets.boyFill : AppAssets.boy,
                            ),
                            Gaps.vGap10,
                            CustomText(
                              AppStrings.boy,
                              textStyle: TextStyles.body16Medium
                                  .copyWith(color: controller.selectedGender.value == AppStrings.boy ? ColorCode.primary600 : ColorCode.neutral600),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Gaps.hGap(25),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        controller.selectedGender.value = AppStrings.girl;
                        controller.updateChildValidation();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          border:
                              Border.all(color: controller.selectedGender.value == AppStrings.girl ? ColorCode.secondary600 : ColorCode.neutral400),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
                        child: Column(
                          children: [
                            Image(
                              image: controller.selectedGender.value == AppStrings.girl ? AppAssets.girlFill : AppAssets.girl,
                            ),
                            Gaps.vGap10,
                            CustomText(
                              AppStrings.girl,
                              textStyle: TextStyles.body16Medium
                                  .copyWith(color: controller.selectedGender.value == AppStrings.girl ? ColorCode.primary600 : ColorCode.neutral600),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
