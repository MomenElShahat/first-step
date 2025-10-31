import "package:cached_network_image/cached_network_image.dart";
import "package:first_step/consts/colors.dart";
import "package:first_step/consts/text_styles.dart";
import "package:first_step/resources/assets_svg_generated.dart";
import "package:first_step/widgets/cached_image.dart";
import "package:first_step/widgets/custom_text.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:get/get.dart";
import "../../../../../resources/assets_generated.dart";
import "../../../../../resources/strings_generated.dart";
import "../../../../../routes/app_pages.dart";
import "../../../../../widgets/gaps.dart";
import "../../models/branch_model.dart";

class BranchCard extends StatelessWidget {
  final void Function() onTap;
  final BranchModel branchModel;

  const BranchCard({super.key, required this.onTap, required this.branchModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        color: ColorCode.neutral10,
        border: const Border(
          bottom: BorderSide(color: ColorCode.neutral400),
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (branchModel.isMainBranch == 0)
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
              branchModel.logo == null
                  ? const Image(image: AppAssets.instagramLogo)
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(50.r),
                      child: CachedNetworkImage(
                        width: 50.w,
                        height: 50.h,
                        imageUrl: branchModel.logo ?? "",
                        fit: BoxFit.fill,
                        placeholder: (context, url) => Container(color: Colors.grey.shade200),
                        errorWidget: (context, url, error) => Container(
                          color: Colors.grey.shade300,
                          child: const Icon(Icons.error),
                        ),
                      ),
                    ),
              Gaps.hGap8,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomText(
                      branchModel.name ?? "",
                      textStyle: TextStyles.body16Medium.copyWith(fontWeight: FontWeight.w700, color: ColorCode.primary600),
                    ),
                    Gaps.vGap8,
                    CustomText(
                      "${AppStrings.address}: ${branchModel.location ?? ""}",
                      textStyle: TextStyles.body16Medium.copyWith(fontSize: 12.sp, color: ColorCode.neutral500),
                    ),
                    Gaps.vGap8,
                    CustomText(
                      "${AppStrings.children}: ${branchModel.childrenCount.toString()} ${AppStrings.child}",
                      textStyle: TextStyles.body16Medium.copyWith(fontSize: 12.sp, color: ColorCode.neutral500),
                    ),
                    Gaps.vGap8,
                    CustomText(
                      "${AppStrings.totalReservations}: ${branchModel.enrollmentsCount.toString()} ${AppStrings.reservation}",
                      textStyle: TextStyles.body16Medium.copyWith(fontSize: 12.sp, color: ColorCode.neutral500),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Gaps.vGap8,
          Row(
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(8.r),
                onTap: () {
                  Get.toNamed(Routes.BRANCH_DETAILS_SCREEN, arguments: branchModel.id.toString());
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
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
                  padding: const EdgeInsets.symmetric(vertical: 10.5, horizontal: 24),
                  child: Center(
                    child: CustomText(
                      AppStrings.viewBranch,
                      textStyle: TextStyles.body14Regular.copyWith(color: ColorCode.white),
                    ),
                  ),
                ),
              ),
              Gaps.hGap16,
              InkWell(
                borderRadius: BorderRadius.circular(8.r),
                onTap: () {
                  Get.toNamed(Routes.BRANCH_EDIT_SCREEN, arguments: branchModel.id.toString());
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: ColorCode.primary600),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 10.5, horizontal: 24),
                  child: Center(
                    child: CustomText(
                      AppStrings.editBranch,
                      textStyle: TextStyles.body14Regular.copyWith(color: ColorCode.primary600),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Gaps.vGap16,
          CustomText(
            AppStrings.acceptableAges,
            textStyle: TextStyles.body16Medium.copyWith(color: ColorCode.primary600),
          ),
          Gaps.vGap8,
          ...List.generate(
            branchModel.acceptedAges?.length ?? 0,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: CustomText(
                branchModel.acceptedAges?[index] == "0-3"
                    ? AppStrings.from0To3Years
                    : branchModel.acceptedAges?[index] == "3-6"
                        ? AppStrings.from3To6Years
                        : AppStrings.childrenWithSpecialNeeds,
                textStyle: TextStyles.body16Medium.copyWith(color: ColorCode.neutral500),
              ),
            ),
          ),
          Gaps.vGap16,
          CustomText(
            AppStrings.servicesAvailableAtTheBranch,
            textStyle: TextStyles.body16Medium.copyWith(color: ColorCode.primary600),
          ),
          Gaps.vGap8,
          ...List.generate(
            branchModel.services?.length ?? 0,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: CustomText(
                branchModel.services?[index] ?? "",
                textStyle: TextStyles.body16Medium.copyWith(color: ColorCode.neutral500),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
