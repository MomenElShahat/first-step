import "package:first_step/consts/colors.dart";
import "package:first_step/consts/text_styles.dart";
import "package:first_step/pages/center/control_panel/models/child_model.dart";
import "package:first_step/resources/assets_svg_generated.dart";
import "package:first_step/widgets/custom_text.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:get/get.dart";

import "../../../../../resources/assets_generated.dart";
import "../../../../../resources/strings_generated.dart";
import "../../../../../routes/app_pages.dart";
import "../../../../../services/auth_service.dart";
import "../../../../../widgets/gaps.dart";

class ChildCard extends StatelessWidget {
  final ChildModel childModel;
  final void Function()? onTap;

  const ChildCard({super.key, required this.childModel, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.r),
          color: ColorCode.neutral10,
          border:
              const Border(bottom: BorderSide(color: ColorCode.neutral400))),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (AuthService.to.userInfo?.user?.role == "parent")
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: onTap,
                  child: AppSVGAssets.getWidget(AppSVGAssets.delete),
                ),
              ],
            ),
          Gaps.vGap8,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              childModel.gender == "boy"
                  ? const Image(image: AppAssets.boyFill)
                  : const Image(image: AppAssets.girlFill),
              Gaps.hGap8,
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomText(
                    childModel.childName ?? "",
                    textStyle: TextStyles.body16Medium.copyWith(
                        fontWeight: FontWeight.w700,
                        color: ColorCode.primary600),
                  ),
                  Gaps.vGap8,
                  CustomText(
                    "${AppStrings.dateOfBirth}: ${childModel.birthdayDate ?? ""}",
                    textStyle: TextStyles.body16Medium
                        .copyWith(fontSize: 12.sp, color: ColorCode.neutral500),
                  ),
                  Gaps.vGap8,
                  CustomText(
                    "${AppStrings.gender}: ${childModel.gender == "boy" ? AppStrings.boy : AppStrings.girl}",
                    textStyle: TextStyles.body16Medium
                        .copyWith(fontSize: 12.sp, color: ColorCode.neutral500),
                  ),
                  Gaps.vGap8,
                  CustomText(
                    "${AppStrings.parentName}: ${childModel.parentName ?? ""}",
                    textStyle: TextStyles.body16Medium
                        .copyWith(fontSize: 12.sp, color: ColorCode.neutral500),
                  ),
                ],
              )),
            ],
          ),
          Gaps.vGap8,
          AuthService.to.userInfo?.user?.role == "parent"
              ? Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Get.toNamed(Routes.CHILD_DETAILS_SCREEN,
                              arguments: childModel.id.toString());
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
                          padding: const EdgeInsets.symmetric(
                              vertical: 14.5, horizontal: 24),
                          child: Center(
                            child: CustomText(
                              AppStrings.viewTheChildFile,
                              textStyle: TextStyles.body14Regular
                                  .copyWith(color: ColorCode.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Gaps.hGap16,
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Get.toNamed(Routes.EDIT_CHILD_DETAILS_SCREEN,
                              arguments: childModel.id.toString());
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(36.r),
                            border: Border.all(color: ColorCode.primary600),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 14.5, horizontal: 24),
                          child: Center(
                            child: CustomText(
                              AppStrings.editChild,
                              textStyle: TextStyles.body14Regular
                                  .copyWith(color: ColorCode.primary600),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : InkWell(
                  onTap: () {
                    Get.toNamed(Routes.CHILD_DETAILS_SCREEN,
                        arguments: childModel.id.toString());
                  },
                  child: Container(
                    width: Get.width / 2,
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
                    padding: const EdgeInsets.symmetric(
                        vertical: 14.5, horizontal: 24),
                    child: Center(
                      child: CustomText(
                        AppStrings.viewTheChildFile,
                        textStyle: TextStyles.body14Regular
                            .copyWith(color: ColorCode.white),
                      ),
                    ),
                  ),
                ),
          Gaps.vGap16,
          CustomText(
            AppStrings.chronicDiseases,
            textStyle:
                TextStyles.body16Medium.copyWith(color: ColorCode.primary600),
          ),
          if (childModel.diseaseDetails != null ||
              (childModel.diseaseDetails?.isNotEmpty ?? false))
            ...List.generate(
              childModel.diseaseDetails?.length ?? 0,
                  (index) => Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: CustomText(
                                    childModel.diseaseDetails?[index].diseaseName ?? "",
                                    textStyle: TextStyles.body16Medium
                      .copyWith(fontSize: 12.sp, color: ColorCode.neutral500),
                                  ),
                  ),
            ),
          if (childModel.diseaseDetails == null ||
              (childModel.diseaseDetails?.isEmpty ?? false))
            CustomText(
              AppStrings.notFound,
              textStyle: TextStyles.body16Medium
                  .copyWith(fontSize: 12.sp, color: ColorCode.neutral500),
            ),
          Gaps.vGap16,
          CustomText(
            AppStrings.allergies,
            textStyle:
                TextStyles.body16Medium.copyWith(color: ColorCode.primary600),
          ),
          Gaps.vGap8,
          if (childModel.allergies != null ||
              (childModel.allergies?.isNotEmpty ?? false))
            ...List.generate(
              childModel.allergies?.length ?? 0,
              (index) => Padding(
                padding: const EdgeInsets.only(top: 5),
                child: CustomText(
                  childModel.allergies?[index].name ?? "",
                  textStyle: TextStyles.body16Medium
                      .copyWith(fontSize: 12.sp, color: ColorCode.neutral500),
                ),
              ),
            ),
          if (childModel.allergies == null ||
              (childModel.allergies?.isEmpty ?? false))
            CustomText(
              AppStrings.notFound,
              textStyle: TextStyles.body16Medium
                  .copyWith(fontSize: 12.sp, color: ColorCode.neutral500),
            ),
          Gaps.vGap16,
          CustomText(
            AppStrings.authorizedPersons,
            textStyle:
                TextStyles.body16Medium.copyWith(color: ColorCode.primary600),
          ),
          Gaps.vGap8,
          if (childModel.authorizedPeople != null ||
              (childModel.authorizedPeople?.isNotEmpty ?? false))
            ...List.generate(
              childModel.authorizedPeople?.length ?? 0,
              (index) => CustomText(
                "${childModel.authorizedPeople?[index].name ?? ""} - ${childModel.authorizedPeople?[index].cin ?? ""}",
                textStyle: TextStyles.body16Medium
                    .copyWith(fontSize: 12.sp, color: ColorCode.neutral500),
              ),
            ),
          if (childModel.authorizedPeople == null ||
              (childModel.authorizedPeople?.isEmpty ?? false))
            CustomText(
              AppStrings.notFound,
              textStyle: TextStyles.body16Medium
                  .copyWith(fontSize: 12.sp, color: ColorCode.neutral500),
            ),
        ],
      ),
    );
  }
}
