import 'package:first_step/consts/colors.dart';
import 'package:first_step/consts/text_styles.dart';
import 'package:first_step/pages/center/control_panel/models/child_model.dart';
import 'package:first_step/resources/assets_svg_generated.dart';
import 'package:first_step/resources/strings_generated.dart';
import 'package:first_step/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../../../../../../widgets/gaps.dart';
import '../../../../../resources/assets_generated.dart';
import '../../../../../utils/utils.dart';
import '../../../../../widgets/custom_text_form_field.dart';
import '../../../../parent/home_parent/presentation/widgets/center_card.dart';
import '../../../control_panel/presentation/widgets/child_card.dart';
import '../controllers/parent_details_controller.dart';

class ParentDetailsScreen extends GetView<ParentDetailsScreenController> {
  const ParentDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorCode.white,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: controller.obx(
          (state) => SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(text: AppStrings.name, style: TextStyles.body14Medium.copyWith(color: ColorCode.neutral500)),
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
                              return (controller.arabic.text.isNotEmpty) ? null : AppStrings.emptyField;
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
                              TextSpan(text: AppStrings.mobileNumber, style: TextStyles.body14Medium.copyWith(color: ColorCode.neutral500)),
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
                                      return (isValidSaudiNumber(controller.mobileNumber.text))
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
                      Gaps.vGap8,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(text: AppStrings.idNumber, style: TextStyles.body14Medium.copyWith(color: ColorCode.neutral500)),
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
                            hint: "5255555666666666666",
                            onSave: (String? val) {
                              controller.nationalID.text = val!;
                            },
                            enable: false,
                            onChange: (String? val) {
                              controller.nationalID.text = val!;
                              // final englishText = convertArabicToEnglish(val ??"");
                              // controller.floorNumber.value  =controller.floorNumber.value.copyWith(
                              //   text: englishText,
                              //   selection: TextSelection.collapsed(offset: englishText.length),
                              // );
                            },
                            controller: controller.nationalID,
                            validator: (val) {
                              return controller.nationalID.text.isNotEmpty ? null : AppStrings.emptyField;
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
                              TextSpan(text: AppStrings.email, style: TextStyles.body14Medium.copyWith(color: ColorCode.neutral500)),
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
                            hint: AppStrings.egEmail,
                            onSave: (String? val) {
                              controller.email.text = val!;
                            },
                            enable: false,
                            onChange: (String? val) {
                              controller.email.text = val!;
                              // final englishText = convertArabicToEnglish(val ??"");
                              // controller.floorNumber.value  =controller.floorNumber.value.copyWith(
                              //   text: englishText,
                              //   selection: TextSelection.collapsed(offset: englishText.length),
                              // );
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
                        child: CustomText(
                          AppStrings.childrenData,
                          textStyle: TextStyles.title24Medium.copyWith(color: ColorCode.primary600),
                        ),
                      ),
                      Gaps.vGap8,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            ...List.generate(
                              controller.parentModel?.children?.length ?? 0,
                              (index) => ChildCard(
                                childModel: controller.parentModel?.children?[index] ?? ChildModel(),
                              ),
                            ),
                          ],
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
