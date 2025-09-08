import 'package:first_step/consts/colors.dart';
import 'package:first_step/consts/text_styles.dart';
import 'package:first_step/pages/center/branch_details/presentation/controllers/branch_details_controller.dart';
import 'package:first_step/resources/assets_svg_generated.dart';
import 'package:first_step/resources/strings_generated.dart';
import 'package:first_step/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../../../../../../widgets/gaps.dart';
import '../../../../../utils/utils.dart';
import '../../../../../widgets/custom_text_form_field.dart';
import '../../../auth/signup/models/cities_model.dart';
import '../../../auth/signup/presentation/widgets/cities_dropdown.dart';
import '../../../auth/signup/presentation/widgets/days_dropdown.dart';
import '../../../auth/signup/presentation/widgets/step1.dart';

class BranchDetailsScreen extends GetView<BranchDetailsScreenController> {
  const BranchDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorCode.white,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: controller.obx(
              (state) =>
              SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(text: AppStrings.branchNameInArabic,
                                  style: TextStyles.body14Medium.copyWith(
                                      color: ColorCode.neutral500)),
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
                              controller.arabic.text = val!;
                            },
                            enable: false,
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
                              TextSpan(text: AppStrings.mobileNumber,
                                  style: TextStyles.body14Medium.copyWith(
                                      color: ColorCode.neutral500)),
                              // TextSpan(
                              //     text: "*",
                              //     style: TextStyles.body14Medium
                              //         .copyWith(color: ColorCode.danger700)),
                            ],
                          ),
                        ),
                      ),
                      Gaps.vGap8,
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 12),
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
                                    enable: false,
                                    onSave: (String? val) {
                                      controller.mobileNumber.text = val!;
                                    },
                                    onChange: (String? val) {
                                      controller.mobileNumber.text = val!;
                                      // final englishText = convertArabicToEnglish(val ??"");
                                      // controller.floorNumber.value  =controller.floorNumber.value.copyWith(
                                      //   text: englishText,
                                      //   selection: TextSelection.collapsed(offset: englishText.length),
                                      // );
                                    },
                                    maxLength: 9,
                                    controller: controller.mobileNumber,
                                    validator: (val) {
                                      return (isValidSaudiNumber(
                                          controller.mobileNumber.text))
                                          ? null
                                          : AppStrings.phoneValidation;
                                    },
                                    inputType: TextInputType.phone,
                                    label: ""),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Gaps.vGap8,
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 16),
                      //   child: RichText(
                      //     text: TextSpan(
                      //       children: [
                      //         TextSpan(
                      //             text: AppStrings.idNumber,
                      //             style: TextStyles.body14Medium
                      //                 .copyWith(color: ColorCode.neutral500)),
                      //         // TextSpan(
                      //         //     text: "*",
                      //         //     style: TextStyles.body14Medium
                      //         //         .copyWith(color: ColorCode.danger700)),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // Gaps.vGap8,
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 16),
                      //   child: CustomTextFormField(
                      //       hint: "5255555666666666666",
                      //       onSave: (String? val) {
                      //         controller.nationalID.text = val!;
                      //       },
                      //       onChange: (String? val) {
                      //         controller.nationalID.text = val!;
                      //         // final englishText = convertArabicToEnglish(val ??"");
                      //         // controller.floorNumber.value  =controller.floorNumber.value.copyWith(
                      //         //   text: englishText,
                      //         //   selection: TextSelection.collapsed(offset: englishText.length),
                      //         // );
                      //       },
                      //       controller: controller.nationalID,
                      //       validator: (val) {
                      //         return controller.nationalID.text.isNotEmpty
                      //             ? null
                      //             : AppStrings.emptyField;
                      //       },
                      //       inputType: TextInputType.text,
                      //       label: ""),
                      // ),
                      // Gaps.vGap8,
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 16),
                      //   child: RichText(
                      //     text: TextSpan(
                      //       children: [
                      //         TextSpan(text: AppStrings.email, style: TextStyles.body14Medium.copyWith(color: ColorCode.neutral500)),
                      //         // TextSpan(
                      //         //     text: "*",
                      //         //     style: TextStyles.body14Medium
                      //         //         .copyWith(color: ColorCode.danger700)),
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
                      //         return isValidEmail(controller.email.text) ? null : AppStrings.validateMail;
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
                                  text: AppStrings.theCity, style: TextStyles
                                  .body14Medium.copyWith(
                                  color: ColorCode.neutral500)),
                              // TextSpan(
                              //     text: "*",
                              //     style: TextStyles.body14Medium
                              //         .copyWith(color: ColorCode.danger700)),
                            ],
                          ),
                        ),
                      ),
                      Gaps.vGap8,
                      Obx(() {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: CitiesDropdown(
                            isReadOnly: true,
                            citiesList: controller.cities,
                            selectedValue: controller.selectedCity.value,
                            isError: controller.isCityError.value,
                            onChange: (val) {
                              controller.selectedCity.value = val ?? City();
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
                              TextSpan(text: AppStrings.theNeighborhood,
                                  style: TextStyles.body14Medium.copyWith(
                                      color: ColorCode.neutral500)),
                              // TextSpan(
                              //     text: "*",
                              //     style: TextStyles.body14Medium
                              //         .copyWith(color: ColorCode.danger700)),
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
                              controller.neighborhood.text = val!;
                            },
                            enable: false,
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
                      // Gaps.vGap8,
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 16),
                      //   child: RichText(
                      //     text: TextSpan(
                      //       children: [
                      //         TextSpan(text: AppStrings.theStreet, style: TextStyles.body14Medium.copyWith(color: ColorCode.neutral500)),
                      //         // TextSpan(
                      //         //     text: "*",
                      //         //     style: TextStyles.body14Medium
                      //         //         .copyWith(color: ColorCode.danger700)),
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
                      //         controller.street.text = val!;
                      //       },
                      //       onChange: (String? val) {
                      //         controller.street.text = val!;
                      //         // final englishText = convertArabicToEnglish(val ??"");
                      //         // controller.floorNumber.value  =controller.floorNumber.value.copyWith(
                      //         //   text: englishText,
                      //         //   selection: TextSelection.collapsed(offset: englishText.length),
                      //         // );
                      //       },
                      //       controller: controller.street,
                      //       validator: (val) {
                      //         return (controller.street.text.isNotEmpty) ? null : AppStrings.emptyField;
                      //       },
                      //       inputType: TextInputType.text,
                      //       label: ""),
                      // ),
                      Gaps.vGap16,
                      Center(
                        child: CustomText(
                          AppStrings.availableServices,
                          textStyle: TextStyles.body16Medium.copyWith(
                              color: ColorCode.primary600),
                        ),
                      ),
                      Gaps.vGap8,
                      ...buildCheckBoxGrid(
                          controller.services, isReadOnly: true),
                      Gaps.vGap8,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(text: AppStrings.workStartsFromTheDay,
                                  style: TextStyles.body14Medium.copyWith(
                                      color: ColorCode.neutral500)),
                              TextSpan(text: "*", style: TextStyles.body14Medium
                                  .copyWith(color: ColorCode.danger700)),
                            ],
                          ),
                        ),
                      ),
                      Gaps.vGap8,
                      Obx(() =>
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: DaysDropdown(
                              isReadOnly: true,
                              selectedValue: controller.selectedStartDay.value,
                              isError: controller.isStartDayError.value,
                              // onChange: (val) {
                              //   controller.selectedStartDay.value = val ?? "";
                              //   controller.update();
                              //   if (val != null) {
                              //     controller.isStartDayError.value = false;
                              //     controller.update();
                              //   }
                              // },
                              daysList: controller.daysList,
                            ),
                          )),
                      Gaps.vGap8,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(text: AppStrings.fromTheHour,
                                  style: TextStyles.body14Medium.copyWith(
                                      color: ColorCode.neutral500)),
                              TextSpan(text: "*", style: TextStyles.body14Medium
                                  .copyWith(color: ColorCode.danger700)),
                            ],
                          ),
                        ),
                      ),
                      Gaps.vGap8,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: InkWell(
                          // onTap: () async {
                          //   controller.startTime = await controller.pickTime(context);
                          //   controller.fromHour.text = controller.startTime?.format(context) ?? "";
                          //   // "${controller.startTime?.hour ?? 0} : ${controller.startTime?.minute ?? 0}";
                          // },
                          child: CustomTextFormField(
                              hint: "16:55",
                              suffixIcon: AppSVGAssets.getWidget(
                                  AppSVGAssets.timeLine, width: 10, height: 10),
                              onSave: (String? val) {
                                controller.fromHour.text = val!;
                              },
                              readOnly: true,
                              enable: false,
                              onChange: (String? val) {
                                controller.fromHour.text = val!;
                                // final englishText = convertArabicToEnglish(val ??"");
                                // controller.floorNumber.value  =controller.floorNumber.value.copyWith(
                                //   text: englishText,
                                //   selection: TextSelection.collapsed(offset: englishText.length),
                                // );
                              },
                              controller: controller.fromHour,
                              validator: (val) {
                                return (controller.fromHour.text.isNotEmpty)
                                    ? null
                                    : AppStrings.emptyField;
                              },
                              inputType: TextInputType.text,
                              label: ""),
                        ),
                      ),
                      Gaps.vGap8,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(text: AppStrings.workEndsAtTheDay,
                                  style: TextStyles.body14Medium.copyWith(
                                      color: ColorCode.neutral500)),
                              TextSpan(text: "*", style: TextStyles.body14Medium
                                  .copyWith(color: ColorCode.danger700)),
                            ],
                          ),
                        ),
                      ),
                      Gaps.vGap8,
                      Obx(() =>
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: DaysDropdown(
                              daysList: controller.daysList,
                              selectedValue: controller.selectedEndDay.value,
                              isError: controller.isEndDayError.value,
                              isReadOnly: true,
                              // onChange: (val) {
                              //   controller.selectedEndDay.value = val ?? "";
                              //   controller.update();
                              //   if (val != null) {
                              //     controller.isEndDayError.value = false;
                              //     controller.update();
                              //   }
                              // },
                            ),
                          )),
                      Gaps.vGap8,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(text: AppStrings.untilTheHour,
                                  style: TextStyles.body14Medium.copyWith(
                                      color: ColorCode.neutral500)),
                              TextSpan(text: "*", style: TextStyles.body14Medium
                                  .copyWith(color: ColorCode.danger700)),
                            ],
                          ),
                        ),
                      ),
                      Gaps.vGap8,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: InkWell(
                          // onTap: () async {
                          //   controller.endTime = await controller.pickTime(context);
                          //   controller.untilHour.text = controller.endTime?.format(context) ?? "";
                          //   // "${controller.endTime?.hour ?? 0} : ${controller.endTime?.minute ?? 0}";
                          // },
                          child: CustomTextFormField(
                              hint: "16:55",
                              suffixIcon: AppSVGAssets.getWidget(
                                  AppSVGAssets.timeLine, width: 10, height: 10),
                              onSave: (String? val) {
                                controller.untilHour.text = val!;
                              },
                              readOnly: true,
                              enable: false,
                              onChange: (String? val) {
                                controller.untilHour.text = val!;
                                // final englishText = convertArabicToEnglish(val ??"");
                                // controller.floorNumber.value  =controller.floorNumber.value.copyWith(
                                //   text: englishText,
                                //   selection: TextSelection.collapsed(offset: englishText.length),
                                // );
                              },
                              controller: controller.untilHour,
                              validator: (val) {
                                return (controller.untilHour.text.isNotEmpty)
                                    ? null
                                    : AppStrings.emptyField;
                              },
                              inputType: TextInputType.text,
                              label: ""),
                        ),
                      ),
                      Gaps.vGap24,
                    ],
                  ),
                ),
              ),
          onLoading: const Center(
            child: SpinKitCircle(
              color: ColorCode.primary600,
            ),
          )),
    );
  }
}
