import 'package:first_step/consts/colors.dart';
import 'package:first_step/consts/text_styles.dart';
import 'package:first_step/resources/assets_generated.dart';
import 'package:first_step/resources/assets_svg_generated.dart';
import 'package:first_step/resources/strings_generated.dart';
import 'package:first_step/widgets/cached_image.dart';
import 'package:first_step/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../../../../../../widgets/gaps.dart';
import '../../../../../utils/utils.dart';
import '../../../../../widgets/custom_text_form_field.dart';
import '../../../auth/signup/presentation/widgets/days_dropdown.dart';
import '../../../auth/signup/presentation/widgets/step1.dart';
import '../controllers/edit_member_controller.dart';

class EditMemberScreen extends GetView<EditMemberScreenController> {
  const EditMemberScreen({super.key});

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
                      Center(
                        child: CustomText(
                          AppStrings.editMemberInformation,
                          textStyle: TextStyles.title24Bold.copyWith(fontWeight: FontWeight.w500, color: ColorCode.primary600),
                        ),
                      ),
                      Gaps.vGap8,
                      Center(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            GetBuilder<EditMemberScreenController>(builder: (controller) {
                              return Container(
                                width: 200.w,
                                height: 240.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16.r),
                                  child: controller.pickedImage != null
                                      ? Image.file(
                                          controller.pickedImage!,
                                          fit: BoxFit.fill,
                                        )
                                      : controller.branchTeamMemberModel?.data?.imageUrl != null
                                          ? ClipRRect(
                                              borderRadius: BorderRadius.circular(16.r),
                                              child: CachedImage(
                                                url: controller.branchTeamMemberModel?.data?.imageUrl ?? "",
                                                fit: BoxFit.fill,
                                                placeHolder: const Image(
                                                  image: AppAssets.member,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            )
                                          : const Image(
                                              image: AppAssets.member,
                                              fit: BoxFit.cover,
                                            ),
                                ),
                              );
                            }),
                            InkWell(
                              onTap: controller.pickImage,
                              child: Container(
                                width: Get.width / 2.5,
                                margin: const EdgeInsets.symmetric(horizontal: 22.5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(36.r),
                                  border: Border.all(color: ColorCode.white),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 14.5),
                                child: Center(
                                  child: CustomText(
                                    AppStrings.uploadImage,
                                    textStyle: TextStyles.body16Regular.copyWith(color: ColorCode.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Gaps.vGap8,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(text: AppStrings.memberName, style: TextStyles.body14Medium.copyWith(color: ColorCode.neutral500)),
                            ],
                          ),
                        ),
                      ),
                      Gaps.vGap8,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: CustomTextFormField(
                            hint: AppStrings.binaryName,
                            onSave: (String? val) {
                              controller.memberName.text = val!;
                            },
                            onChange: (String? val) {
                              controller.memberName.text = val!;
                              // final englishText = convertArabicToEnglish(val ??"");
                              // controller.floorNumber.value  =controller.floorNumber.value.copyWith(
                              //   text: englishText,
                              //   selection: TextSelection.collapsed(offset: englishText.length),
                              // );
                            },
                            controller: controller.memberName,
                            validator: (val) {
                              return (controller.memberName.text.isNotEmpty) ? null : AppStrings.emptyField;
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
                      //             text: AppStrings.memberProfession, style: TextStyles.body14Medium.copyWith(color: ColorCode.neutral500)),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // Gaps.vGap8,
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 16),
                      //   child: CustomTextFormField(
                      //       hint: AppStrings.fullNameAsOnId,
                      //       onSave: (String? val) {
                      //         controller.profession.text = val!;
                      //       },
                      //       onChange: (String? val) {
                      //         controller.profession.text = val!;
                      //         // final englishText = convertArabicToEnglish(val ??"");
                      //         // controller.floorNumber.value  =controller.floorNumber.value.copyWith(
                      //         //   text: englishText,
                      //         //   selection: TextSelection.collapsed(offset: englishText.length),
                      //         // );
                      //       },
                      //       controller: controller.profession,
                      //       validator: (val) {
                      //         return (controller.profession.text.isNotEmpty) ? null : AppStrings.emptyField;
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
                              TextSpan(text: AppStrings.memberProfession, style: TextStyles.body14Medium.copyWith(color: ColorCode.neutral500)),
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
                              controller.memberProfession.text = val!;
                            },
                            onChange: (String? val) {
                              controller.memberProfession.text = val!;
                              // final englishText = convertArabicToEnglish(val ??"");
                              // controller.floorNumber.value  =controller.floorNumber.value.copyWith(
                              //   text: englishText,
                              //   selection: TextSelection.collapsed(offset: englishText.length),
                              // );
                            },
                            controller: controller.memberProfession,
                            validator: (val) {
                              return (controller.memberProfession.text.isNotEmpty) ? null : AppStrings.emptyField;
                            },
                            inputType: TextInputType.text,
                            label: ""),
                      ),
                      Gaps.vGap32,
                      Obx(() {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            controller.isSaving.value
                                ? const Center(
                                    child: SpinKitCircle(
                                      color: ColorCode.primary600,
                                    ),
                                  )
                                : InkWell(
                                    onTap: () {
                                      controller.editBranchTeamDetails();
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(36.r),
                                        gradient: const LinearGradient(
                                          begin: Alignment(-0.15, -1.0), // Approximate direction for 98.52 degrees
                                          end: Alignment(1.0, 0.15),
                                          colors: [
                                            Color(0xFF7A8CFD),
                                            Color(0xFF404FB1),
                                            Color(0xFF2B3990),
                                          ],
                                          stops: [0.1117, 0.6374, 0.9471],
                                        ),
                                      ),
                                      padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 14.5),
                                      child: Center(
                                        child: CustomText(
                                          AppStrings.saveEdit,
                                          textStyle: TextStyles.body16Regular.copyWith(color: ColorCode.white),
                                        ),
                                      ),
                                    ),
                                  ),
                            Gaps.hGap(24),
                            InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(36.r),
                                  border: Border.all(color: ColorCode.neutral400),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 14.5),
                                child: Center(
                                  child: CustomText(
                                    AppStrings.cancel,
                                    textStyle: TextStyles.body16Regular.copyWith(color: ColorCode.neutral500),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
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
