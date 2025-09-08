import 'package:first_step/consts/colors.dart';
import 'package:first_step/consts/text_styles.dart';
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
import '../../../../parent/auth/add_child/presentation/widgets/allergy_section.dart';
import '../../../../parent/auth/add_child/presentation/widgets/authorized_section.dart';
import '../../../../parent/auth/add_child/presentation/widgets/chronic_section.dart';
import '../../../control_panel/presentation/widgets/child_card.dart';
import '../controllers/child_details_controller.dart';

class ChildDetailsScreen extends GetView<ChildDetailsScreenController> {
  const ChildDetailsScreen({super.key});

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
                        child: CustomText(
                          AppStrings.childData,
                          textStyle: TextStyles.body16Medium.copyWith(color: ColorCode.primary600),
                        ),
                      ),
                      Gaps.vGap8,
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
                              controller.childName.text = val!;
                            },
                            enable: false,
                            onChange: (String? val) {
                              controller.childName.text = val!;
                              // final englishText = convertArabicToEnglish(val ??"");
                              // controller.floorNumber.value  =controller.floorNumber.value.copyWith(
                              //   text: englishText,
                              //   selection: TextSelection.collapsed(offset: englishText.length),
                              // );
                            },
                            controller: controller.childName,
                            validator: (val) {
                              return (controller.childName.text.isNotEmpty) ? null : AppStrings.emptyField;
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
                          // onTap: () async {
                          //   controller.dateOfBirth.text = await controller.pickDate(context) ?? "08/08/2019";
                          // },
                          child: CustomTextFormField(
                              hint: "08/08/2019",
                              onSave: (String? val) {
                                controller.dateOfBirth.text = val!;
                              },
                              readOnly: true,
                              enable: false,
                              onChange: (String? val) {
                                controller.dateOfBirth.text = val!;
                                // final englishText = convertArabicToEnglish(val ??"");
                                // controller.floorNumber.value  =controller.floorNumber.value.copyWith(
                                //   text: englishText,
                                //   selection: TextSelection.collapsed(offset: englishText.length),
                                // );
                              },
                              controller: controller.dateOfBirth,
                              validator: (val) {
                                return (controller.dateOfBirth.text.isNotEmpty) ? null : AppStrings.emptyField;
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
                              TextSpan(text: AppStrings.fatherName, style: TextStyles.body14Medium.copyWith(color: ColorCode.neutral500)),
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
                              controller.fatherName.text = val!;
                            },
                            enable: false,
                            onChange: (String? val) {
                              controller.fatherName.text = val!;
                              // final englishText = convertArabicToEnglish(val ??"");
                              // controller.floorNumber.value  =controller.floorNumber.value.copyWith(
                              //   text: englishText,
                              //   selection: TextSelection.collapsed(offset: englishText.length),
                              // );
                            },
                            controller: controller.fatherName,
                            validator: (val) {
                              return (controller.fatherName.text.isNotEmpty) ? null : AppStrings.emptyField;
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
                              TextSpan(text: AppStrings.motherName, style: TextStyles.body14Medium.copyWith(color: ColorCode.neutral500)),
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
                              controller.motherName.text = val!;
                            },
                            enable: false,
                            onChange: (String? val) {
                              controller.motherName.text = val!;
                              // final englishText = convertArabicToEnglish(val ??"");
                              // controller.floorNumber.value  =controller.floorNumber.value.copyWith(
                              //   text: englishText,
                              //   selection: TextSelection.collapsed(offset: englishText.length),
                              // );
                            },
                            controller: controller.motherName,
                            validator: (val) {
                              return (controller.motherName.text.isNotEmpty) ? null : AppStrings.emptyField;
                            },
                            inputType: TextInputType.text,
                            label: ""),
                      ),
                      Gaps.vGap8,
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24),
                                    border: Border.all(
                                        color: controller.selectedGender.value == "boy" ? ColorCode.secondary600 : ColorCode.secondaryBurgundy600)),
                                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
                                child: Column(
                                  children: [
                                    Image(
                                      image: controller.selectedGender.value == "boy" ? AppAssets.boyFill : AppAssets.girlFill,
                                    ),
                                    Gaps.vGap10,
                                    CustomText(
                                      controller.selectedGender.value == "boy" ? AppStrings.boy : AppStrings.girl,
                                      textStyle: TextStyles.body16Medium.copyWith(
                                          color: controller.selectedGender.value == AppStrings.boy ? ColorCode.primary600 : ColorCode.neutral600),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                      Gaps.vGap16,
                      if(controller.chronicDiseases.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: CustomText(
                            AppStrings.chronicDiseases,
                            textStyle: TextStyles.body16Medium.copyWith(color: ColorCode.primary600),
                          ),
                        ),
                      Obx(() => Form(
                        key: controller.formKey2,
                        child: Column(
                          children:
                          List.generate(controller.chronicDiseases.length, (index) {
                            return ChronicDiseaseSection(
                              index: index,
                              diseaseModel: controller.chronicDiseases[index],
                              onRemove: () => controller.removeChronicDisease(index),
                              enabled: false,
                            );
                          }),
                        ),
                      )),
                      Gaps.vGap8,
                      if(controller.allergySections.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: CustomText(
                            AppStrings.allergies,
                            textStyle: TextStyles.body16Medium.copyWith(color: ColorCode.primary600),
                          ),
                        ),
                      Form(
                        key: controller.formKey3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(controller.allergySections.length, (index) {
                            return AllergySection(
                              index: index,
                              allergyModel: controller.allergySections[index],
                              onRemove: () => controller.removeAllergySection(index),
                              enabled: false,
                            );
                          }),
                        ),
                      ),
                      Gaps.vGap16,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: CustomText(
                          AppStrings.recommendationsForChild,
                          textStyle: TextStyles.body16Medium.copyWith(color: ColorCode.primary600),
                        ),
                      ),
                      Gaps.vGap8,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text: AppStrings.describeYourChildIn3Words, style: TextStyles.body14Medium.copyWith(color: ColorCode.neutral500)),
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
                            hint: AppStrings.egSmartNaughtyUnfocused,
                            onSave: (String? val) {
                              controller.describeYourChildIn3Words.text = val!;
                            },
                            enable: false,
                            onChange: (String? val) {
                              controller.describeYourChildIn3Words.text = val!;
                              // final englishText = convertArabicToEnglish(val ??"");
                              // controller.floorNumber.value  =controller.floorNumber.value.copyWith(
                              //   text: englishText,
                              //   selection: TextSelection.collapsed(offset: englishText.length),
                              // );
                            },
                            controller: controller.describeYourChildIn3Words,
                            validator: (val) {
                              return (controller.describeYourChildIn3Words.text.isNotEmpty) ? null : AppStrings.emptyField;
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
                              TextSpan(text: AppStrings.thingsYourChildLikes, style: TextStyles.body14Medium.copyWith(color: ColorCode.neutral500)),
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
                            hint: AppStrings.egPlayingTennisHisYellowDollWatchingCartoons,
                            onSave: (String? val) {
                              controller.thingsYourChildLikes.text = val!;
                            },
                            enable: false,
                            onChange: (String? val) {
                              controller.thingsYourChildLikes.text = val!;
                              // final englishText = convertArabicToEnglish(val ??"");
                              // controller.floorNumber.value  =controller.floorNumber.value.copyWith(
                              //   text: englishText,
                              //   selection: TextSelection.collapsed(offset: englishText.length),
                              // );
                            },
                            controller: controller.thingsYourChildLikes,
                            validator: (val) {
                              return (controller.thingsYourChildLikes.text.isNotEmpty) ? null : AppStrings.emptyField;
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
                                  text: "${AppStrings.doYouHaveAnyRecommendationsForYourChild} ",
                                  style: TextStyles.body14Medium.copyWith(color: ColorCode.neutral500)),
                            ],
                          ),
                        ),
                      ),
                      Gaps.vGap8,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: CustomTextFormField(
                            hint: AppStrings.writeHere,
                            onSave: (String? val) {
                              controller.doYouHaveAnyRecommendationsForYourChild.text = val!;
                            },
                            enable: false,
                            onChange: (String? val) {
                              controller.doYouHaveAnyRecommendationsForYourChild.text = val!;
                              // final englishText = convertArabicToEnglish(val ??"");
                              // controller.floorNumber.value  =controller.floorNumber.value.copyWith(
                              //   text: englishText,
                              //   selection: TextSelection.collapsed(offset: englishText.length),
                              // );
                            },
                            controller: controller.doYouHaveAnyRecommendationsForYourChild,
                            validator: (val) {
                              return (controller.doYouHaveAnyRecommendationsForYourChild.text.isNotEmpty) ? null : AppStrings.emptyField;
                            },
                            inputType: TextInputType.text,
                            label: ""),
                      ),
                      Gaps.vGap16,
                      if(controller.authorizedPersons.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: CustomText(
                            AppStrings.authorizedPersons,
                            textStyle: TextStyles.body16Medium.copyWith(color: ColorCode.primary600),
                          ),
                        ),
                      Gaps.vGap8,
                      Obx(() => Form(
                        key: controller.formKey5,
                        child: Column(
                          children: List.generate(controller.authorizedPersons.length,
                                  (index) {
                                return AuthorizedSection(
                                  index: index,
                                  authorizedPerson: controller.authorizedPersons[index],
                                  onRemove: () =>
                                      controller.removeAuthorizedPersons(index),
                                  enabled: false,
                                );
                              }),
                        ),
                      )),
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
