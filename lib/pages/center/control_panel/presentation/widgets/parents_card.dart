import "package:first_step/consts/colors.dart";
import "package:first_step/consts/text_styles.dart";
import "package:first_step/resources/assets_svg_generated.dart";
import "package:first_step/widgets/custom_text.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:get/get.dart";

import "../../../../../resources/assets_generated.dart";
import "../../../../../resources/strings_generated.dart";
import "../../../../../routes/app_pages.dart";
import "../../../../../widgets/gaps.dart";
import "../../models/parent_model.dart";

class ParentCard extends StatelessWidget {
  // final void Function() onTap;
  final ParentModel parentModel;

  const ParentCard(
      {super.key,
      // required this.onTap
      required this.parentModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.r),
          color: ColorCode.neutral10,
          border: const Border(bottom: BorderSide(color: ColorCode.neutral400))),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                  // onTap: onTap,
                  child: AppSVGAssets.getWidget(AppSVGAssets.delete, color: Colors.transparent))
            ],
          ),
          Gaps.vGap8,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomText(
                parentModel.name ?? "",
                textStyle: TextStyles.body16Medium.copyWith(fontWeight: FontWeight.w700, color: ColorCode.primary600),
              ),
              Gaps.vGap8,
              CustomText(
                "${AppStrings.mobileNumber}: ${parentModel.phone ?? "21548456123"}",
                textStyle: TextStyles.body16Medium.copyWith(fontSize: 12.sp, color: ColorCode.neutral500),
              ),
              Gaps.vGap8,
              CustomText(
                "${AppStrings.email}: ${parentModel.email ?? ""}",
                textStyle: TextStyles.body16Medium.copyWith(fontSize: 12.sp, color: ColorCode.neutral500),
              ),
              Gaps.vGap8,
              CustomText(
                "${AppStrings.idNumber}: ${parentModel.nationalNumber ?? ""}",
                textStyle: TextStyles.body16Medium.copyWith(fontSize: 12.sp, color: ColorCode.neutral500),
              ),
            ],
          ),
          Gaps.vGap8,
          InkWell(
            onTap: () {
              Get.toNamed(Routes.PARENT_DETAILS, arguments: parentModel.id.toString());
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
              padding: const EdgeInsets.symmetric(vertical: 14.5, horizontal: 24),
              child: Center(
                child: CustomText(
                  AppStrings.viewParent,
                  textStyle: TextStyles.body14Regular.copyWith(color: ColorCode.white),
                ),
              ),
            ),
          ),
          Gaps.vGap16,
          CustomText(
            "${AppStrings.numberOfChildren}:",
            textStyle: TextStyles.body16Medium.copyWith(color: ColorCode.primary600, fontSize: 20.sp),
          ),
          Gaps.vGap8,
          CustomText(
            "${parentModel.children?.length ?? 0} ${AppStrings.childrens}",
            textStyle: TextStyles.body16Medium.copyWith(color: ColorCode.neutral500),
          ),
          Gaps.vGap16,
          CustomText(
            AppStrings.childrenNames,
            textStyle: TextStyles.body16Medium.copyWith(color: ColorCode.primary600, fontSize: 20.sp),
          ),
          Gaps.vGap8,
          ...List.generate(
            parentModel.children?.length ?? 0,
            (index) => CustomText(
              parentModel.children?[index].childName ?? "",
              textStyle: TextStyles.body16Medium.copyWith(color: ColorCode.neutral500),
            ),
          )
        ],
      ),
    );
  }
}
