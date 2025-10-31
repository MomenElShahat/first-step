import 'package:first_step/routes/app_pages.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../../consts/colors.dart';
import '../../../../../../consts/text_styles.dart';
import '../../../../../../resources/strings_generated.dart';
import '../../../../../../utils/utils.dart';
import '../../../../../../widgets/custom_button.dart';
import '../../../../../../widgets/custom_snackbar.dart';
import '../../../../../../widgets/custom_text.dart';
import '../../../../../../widgets/custom_text_form_field.dart';
import '../../../../../../widgets/gaps.dart';
import '../../../../auth/signup/models/cities_model.dart';
import '../../../../auth/signup/presentation/widgets/cities_dropdown.dart';
import '../../controllers/branch_add_controller.dart';
import 'check_box_branch.dart';
import 'image_uploader_branch.dart';

class BranchAddStep1 extends GetView<BranchAddScreenController> {
  const BranchAddStep1({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Visibility(
          visible: controller.index.value == 1,
          replacement: const SizedBox(),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: CirclePhotoPickerBranch(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: AppStrings.branchName,
                            style: TextStyles.body14Medium
                                .copyWith(color: ColorCode.neutral500)),
                        TextSpan(
                            text: "*",
                            style: TextStyles.body14Medium
                                .copyWith(color: ColorCode.danger700)),
                      ],
                    ),
                  ),
                ),
                Gaps.vGap8,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CustomTextFormField(
                      hint: AppStrings.egWowNursery,
                      onSave: (String? val) {
                        controller.arabic.text = val!;
                      },
                      onChange: (String? val) {
                        controller.arabic.text = val!;
                        // final englishText = convertArabicToEnglish(val ??"");
                        // controller.floorNumber.value  =controller.floorNumber.value.copyWith(
                        //   text: englishText,
                        //   selection: TextSelection.collapsed(offset: englishText.length),
                        // );
                      },
                      controller: controller.arabic,
                      validator: (val) {
                        return (controller.arabic.text.isNotEmpty)
                            ? null
                            : AppStrings.emptyField;
                      },
                      inputType: TextInputType.text,
                      label: ""),
                ),
                // Gaps.vGap8,
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 16),
                //   child: RichText(
                //     text: TextSpan(
                //       children: [
                //         TextSpan(
                //             text: AppStrings.centerNameInEnglish,
                //             style: TextStyles.body14Medium
                //                 .copyWith(color: ColorCode.neutral500)),
                //         TextSpan(
                //             text: "*",
                //             style: TextStyles.body14Medium
                //                 .copyWith(color: ColorCode.danger700)),
                //       ],
                //     ),
                //   ),
                // ),
                // Gaps.vGap8,
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 16),
                //   child: CustomTextFormField(
                //       hint: AppStrings.egWowNursery,
                //       onSave: (String? val) {
                //         controller.english.text = val!;
                //       },
                //       onChange: (String? val) {
                //         controller.english.text = val!;
                //         // final englishText = convertArabicToEnglish(val ??"");
                //         // controller.floorNumber.value  =controller.floorNumber.value.copyWith(
                //         //   text: englishText,
                //         //   selection: TextSelection.collapsed(offset: englishText.length),
                //         // );
                //       },
                //       controller: controller.english,
                //       validator: (val) {
                //         return (controller.english.text.isNotEmpty)
                //             ? null
                //             : AppStrings.emptyField;
                //       },
                //       inputType: TextInputType.text,
                //       label: ""),
                // ),
                Gaps.vGap8,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: AppStrings.mobileNumber,
                            style: TextStyles.body14Medium
                                .copyWith(color: ColorCode.neutral500)),
                        TextSpan(
                            text: "*",
                            style: TextStyles.body14Medium
                                .copyWith(color: ColorCode.danger700)),
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
                Gaps.vGap8,
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 16),
                //   child: RichText(
                //     text: TextSpan(
                //       children: [
                //         TextSpan(
                //             text: AppStrings.email,
                //             style: TextStyles.body14Medium
                //                 .copyWith(color: ColorCode.neutral500)),
                //         TextSpan(
                //             text: "*",
                //             style: TextStyles.body14Medium
                //                 .copyWith(color: ColorCode.danger700)),
                //       ],
                //     ),
                //   ),
                // ),
                // Gaps.vGap8,
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 16),
                //   child: CustomTextFormField(
                //       hint: AppStrings.egEmail,
                //       onSave: (String? val) {
                //         controller.email.text = val!;
                //       },
                //       onChange: (String? val) {
                //         controller.email.text = val!;
                //         // final englishText = convertArabicToEnglish(val ??"");
                //         // controller.floorNumber.value  =controller.floorNumber.value.copyWith(
                //         //   text: englishText,
                //         //   selection: TextSelection.collapsed(offset: englishText.length),
                //         // );
                //       },
                //       controller: controller.email,
                //       validator: (val) {
                //         return isValidEmail(controller.email.text)
                //             ? null
                //             : AppStrings.validateMail;
                //       },
                //       inputType: TextInputType.text,
                //       label: ""),
                // ),
                // Gaps.vGap8,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: AppStrings.theCity,
                            style: TextStyles.body14Medium
                                .copyWith(color: ColorCode.neutral500)),
                        TextSpan(
                            text: "*",
                            style: TextStyles.body14Medium
                                .copyWith(color: ColorCode.danger700)),
                      ],
                    ),
                  ),
                ),
                Gaps.vGap8,
                GetBuilder<BranchAddScreenController>(builder: (controller) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: CitiesDropdown(
                      citiesList: controller.cities,
                      selectedValue: controller.selectedCity,
                      isError: controller.isCityError.value,
                      onChange: (val) {
                        controller.selectedCity = val ?? City();
                        controller.update();
                        if (val != null) {
                          controller.isCityError.value = false;
                          controller.update();
                        }
                      },
                    ),
                  );
                }),
                Gaps.vGap8,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: AppStrings.theNeighborhood,
                            style: TextStyles.body14Medium
                                .copyWith(color: ColorCode.neutral500)),
                        TextSpan(
                            text: "*",
                            style: TextStyles.body14Medium
                                .copyWith(color: ColorCode.danger700)),
                      ],
                    ),
                  ),
                ),
                Gaps.vGap8,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CustomTextFormField(
                      hint: "........",
                      onSave: (String? val) {
                        controller.neighborhood.text = val!;
                      },
                      onChange: (String? val) {
                        controller.neighborhood.text = val!;
                        // final englishText = convertArabicToEnglish(val ??"");
                        // controller.floorNumber.value  =controller.floorNumber.value.copyWith(
                        //   text: englishText,
                        //   selection: TextSelection.collapsed(offset: englishText.length),
                        // );
                      },
                      controller: controller.neighborhood,
                      validator: (val) {
                        return (controller.neighborhood.text.isNotEmpty)
                            ? null
                            : AppStrings.emptyField;
                      },
                      inputType: TextInputType.text,
                      label: ""),
                ),
                Gaps.vGap8,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: AppStrings.locationLink,
                            style: TextStyles.body14Medium
                                .copyWith(color: ColorCode.neutral500)),
                        TextSpan(
                            text: "*",
                            style: TextStyles.body14Medium
                                .copyWith(color: ColorCode.danger700)),
                      ],
                    ),
                  ),
                ),
                Gaps.vGap8,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CustomTextFormField(
                      hint: AppStrings.egGoogleMapsLink,
                      onSave: (String? val) {
                        controller.locationLink.text = val!;
                      },
                      onChange: (String? val) {
                        controller.locationLink.text = val!;
                        // final englishText = convertArabicToEnglish(val ??"");
                        // controller.floorNumber.value  =controller.floorNumber.value.copyWith(
                        //   text: englishText,
                        //   selection: TextSelection.collapsed(offset: englishText.length),
                        // );
                      },
                      controller: controller.locationLink,
                      validator: (val) {
                        return (controller.locationLink.text.isNotEmpty)
                            ? null
                            : AppStrings.emptyField;
                      },
                      inputType: TextInputType.text,
                      label: ""),
                ),
                Gaps.vGap16,
                Center(
                  child: CustomText(
                    AppStrings.centerType,
                    textStyle: TextStyles.body16Medium
                        .copyWith(color: ColorCode.primary600),
                  ),
                ),
                Gaps.vGap8,
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     buildCheckBoxRow(0, 1, 2, controller.centerTypes),
                //   ],
                // ),
                ...buildCheckBoxGrid(controller.centerTypes),
                Gaps.vGap16,
                Center(
                  child: CustomText(
                    AppStrings.availableServices,
                    textStyle: TextStyles.body16Medium
                        .copyWith(color: ColorCode.primary600),
                  ),
                ),
                Gaps.vGap8,
                ...buildCheckBoxGrid(controller.services),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     buildCheckBoxRow(
                //         0, 1, 2, controller.centerTypes),
                //   ],
                // ),
                // Gaps.vGap8,
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     buildCheckBoxRow(
                //         3, 4, 5, controller.centerTypes),
                //   ],
                // ),
                Gaps.vGap16,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text:
                                "${AppStrings.isThereAServiceThatHasNotBeenAdded} ",
                            style: TextStyles.body14Medium
                                .copyWith(color: ColorCode.neutral500)),
                        TextSpan(
                            text: AppStrings.egToiletTraining,
                            style: TextStyles.button12
                                .copyWith(color: ColorCode.neutral400)),
                      ],
                    ),
                  ),
                ),
                Gaps.vGap8,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CustomTextFormField(
                      hint: AppStrings.egWowNursery,
                      onSave: (String? val) {
                        controller.service.text = val!;
                      },
                      onChange: (String? val) {
                        controller.service.text = val!;
                        // final englishText = convertArabicToEnglish(val ??"");
                        // controller.floorNumber.value  =controller.floorNumber.value.copyWith(
                        //   text: englishText,
                        //   selection: TextSelection.collapsed(offset: englishText.length),
                        // );
                      },
                      controller: controller.service,
                      validator: (val) {
                        return null;
                      },
                      inputType: TextInputType.text,
                      label: ""),
                ),
                Gaps.vGap24,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CustomButton(
                      child: CustomText(
                        AppStrings.next,
                        textStyle: TextStyles.body16Medium.copyWith(
                            fontWeight: FontWeight.w700,
                            color: ColorCode.white),
                      ),
                      onPressed: () {
                        if (controller.formKey.currentState?.validate() ??
                            false) {
                          if (!(controller.centerTypes.any(
                            (element) => element["isChecked"].value == true,
                          ))) {
                            customSnackBar(AppStrings.pleaseSelectACenterType,
                                ColorCode.danger700);
                          } else if (!(controller.services.any(
                            (element) => element["isChecked"].value == true,
                          ))) {
                            customSnackBar(AppStrings.pleaseSelectAService,
                                ColorCode.danger700);
                          } else if (controller.logo == null) {
                            customSnackBar(AppStrings.pleaseUploadYourLogo,
                                ColorCode.danger700);
                          } else if (controller.selectedCity == null) {
                            customSnackBar(AppStrings.pleaseSelectACity,
                                ColorCode.danger700);
                          } else {
                            controller.index.value = 2;
                            print(
                                "centerTypes ${controller.getSelectedTypes(controller.centerTypes)}");
                            print(
                                "services ${controller.getSelectedServices(controller.services)}");
                          }
                        }
                      }),
                ),
                Gaps.vGap24,
              ],
            ),
          ));
    });
  }
}

Widget buildCheckBoxRow(
  int? index1,
  int? index2,
  int? index3,
  List<Map<String, dynamic>> isChecked, {
  bool isReadOnly = false,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      if (index1 != null)
        CheckBoxBranch(
          isChecked[0]["isChecked"],
          label: isChecked[0]["type"],
          index: index1,
          isReadOnly: isReadOnly,
        ),
      Gaps.hGap4,
      if (index2 != null)
        CheckBoxBranch(
          isChecked[1]["isChecked"],
          label: isChecked[1]["type"],
          index: index2,
          isReadOnly: isReadOnly,
        ),
      Gaps.hGap4,
      if (index3 != null)
        CheckBoxBranch(
          isChecked[2]["isChecked"],
          label: isChecked[2]["type"],
          index: index3,
          isReadOnly: isReadOnly,
        ),
    ],
  );
}

List<Widget> buildCheckBoxGrid(
  List<Map<String, dynamic>> centerTypes, {
  bool isReadOnly = false,
}) {
  List<Widget> rows = [];

  for (int i = 0; i < centerTypes.length; i += 3) {
    rows.add(
      buildCheckBoxRow(
        i,
        i + 1 < centerTypes.length ? i + 1 : null,
        i + 2 < centerTypes.length ? i + 2 : null,
        centerTypes.sublist(i, (i + 3).clamp(0, centerTypes.length)),
        isReadOnly: isReadOnly,
      ),
    );
  }

  return rows;
}
