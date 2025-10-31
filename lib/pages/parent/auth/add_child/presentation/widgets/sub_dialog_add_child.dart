import 'package:first_step/pages/parent/auth/add_child/presentation/widgets/signup_branches_dropdown.dart';
import 'package:first_step/pages/parent/auth/add_child/presentation/widgets/signup_pricing_types_dropdown.dart';
import 'package:first_step/pages/parent/auth/signup_parent/presentation/controllers/signup_parent_controller.dart';
import 'package:first_step/pages/parent/auth/signup_parent/presentation/widgets/sub_card.dart';
import 'package:first_step/pages/parent/auth/signup_parent/presentation/widgets/sub_center_card.dart';
import 'package:first_step/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../../consts/colors.dart';
import '../../../../../../consts/text_styles.dart';
import '../../../../../../resources/assets_generated.dart';
import '../../../../../../resources/assets_svg_generated.dart';
import '../../../../../../resources/strings_generated.dart';
import '../../../../../../services/auth_service.dart';
import '../../../../../../widgets/custom_text.dart';
import '../../../../../../widgets/custom_text_form_field.dart';
import '../../../../../../widgets/gaps.dart';
import '../../../../../center/control_panel/presentation/widgets/branches_dropdown.dart';
import '../../../../../center/control_panel/presentation/widgets/pricing_types_dropdown.dart';
import '../controllers/add_child_controller.dart';

class SubDialogAddChild extends GetView<AddChildController> {
  const SubDialogAddChild({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        insetPadding: const EdgeInsets.symmetric(horizontal: 16),
        backgroundColor: ColorCode.white,
        child: controller.isCentersLoading.value
            ? Center(
          child: SpinKitCircle(
            color: ColorCode.primary600,
          ),
        )
            : Padding(
          padding: const EdgeInsets.all(16),
          child: Visibility(
            visible: !controller.isSubed.value &&
                !controller.isCenterSelected.value,
            replacement:
            GetBuilder<AddChildController>(builder: (controller) {
              if (controller.isSubed.value) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            controller.isSubed.value = false;
                            controller.isCenterSelected.value = false;
                          },
                          child: Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: 16,
                            color: ColorCode.neutral400,
                          ),
                        ),
                      ],
                    ),
                    CustomText(
                      AppStrings.findYourChildNurseryOrCenter,
                      textStyle: TextStyles.button12.copyWith(
                          color: ColorCode.neutral600,
                          fontWeight: FontWeight.bold),
                    ),
                    Gaps.vGap8,
                    SizedBox(
                      height: 55.h,
                      child: CustomTextFormField(
                        hint: AppStrings.findACenterOrNursery,
                        inputType: TextInputType.text,
                        label: "",
                        onSave: (p0) {},
                        onChange: (value) {
                          controller.filterNurseries();
                        },
                        validator: (p0) {
                          return null;
                        },
                        controller: controller.search,
                        prefixIcon: AppSVGAssets.getWidget(
                            AppSVGAssets.searchUnselected),
                      ),
                    ),
                    ListView.builder(
                      itemBuilder: (context, index) {
                        final center =
                        controller.filteredNurseries[index];
                        return InkWell(
                          onTap: () async {
                            controller.isSubed.value = false;
                            controller.isCenterSelected.value = true;
                            controller.selectedCenter = center;
                            if ((controller.children?.isEmpty ?? false) ||
                                controller.children == null) {
                              await controller.getChildren();
                            }
                          },
                          child: SubCenterCard(center: center),
                        );
                      },
                      itemCount: controller.filteredNurseries.length,
                      shrinkWrap: true,
                    ),
                    Gaps.vGap16,
                    Center(
                      child: CustomText(
                        AppStrings.didntFindANurseryOrCenterForYourSon,
                        textStyle: TextStyles.button12
                            .copyWith(color: ColorCode.neutral600),
                      ),
                    ),
                    Gaps.vGap8,
                    Obx(() {
                      return Visibility(
                        visible: !controller.isSharing.value,
                        replacement: Center(
                          child: SpinKitCircle(color: ColorCode.primary600,),
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(8.r),
                          onTap: () async {
                            controller.isSharing.value = true;
                            final result = await SharePlus.instance.share(
                              ShareParams(
                                uri: Uri.parse(
                                    AuthService.to.googlePlayAppLink),
                              ),
                            );
                            if (result.status == ShareResultStatus.success) {
                              controller.isSharing.value = false;
                            }else if (result.status == ShareResultStatus.dismissed) {
                              controller.isSharing.value = false;
                            }else if (result.status == ShareResultStatus.unavailable) {
                              controller.isSharing.value = false;
                            }
                          },
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              gradient: const LinearGradient(
                                begin: Alignment.centerRight,
                                end: Alignment.centerLeft,
                                transform: GradientRotation(
                                  98.52 * (3.1415926535 / 180),
                                ),
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
                            margin: EdgeInsets.symmetric(horizontal: 8),
                            padding:
                            const EdgeInsets.symmetric(vertical: 10.5),
                            child: CustomText(
                              AppStrings.inviteYourNurseryOrCenter,
                              textStyle: TextStyles.body16Medium
                                  .copyWith(color: ColorCode.white),
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                );
              } else if (controller.isCenterSelected.value) {
                if (controller.isChildrenLoading.value) {
                  return Center(
                    child: SpinKitCircle(
                      color: ColorCode.primary600,
                    ),
                  );
                } else {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              controller.isSubed.value = true;
                              controller.isCenterSelected.value = false;
                            },
                            child: Icon(
                              Icons.arrow_forward_ios_outlined,
                              size: 16,
                              color: ColorCode.neutral400,
                            ),
                          ),
                        ],
                      ),
                      CustomText(
                        AppStrings.findYourChildNurseryOrCenter,
                        textStyle: TextStyles.button12.copyWith(
                            color: ColorCode.neutral600,
                            fontWeight: FontWeight.bold),
                      ),
                      Gaps.vGap8,
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          // border-radius: 8px
                          gradient: const LinearGradient(
                            begin: Alignment.bottomRight,
                            end: Alignment.topLeft,
                            transform:
                            GradientRotation(104 * 3.14159265 / 180),
                            // 104deg in radians
                            colors: [
                              Color.fromRGBO(233, 241, 255, 0.48),
                              Color.fromRGBO(159, 195, 255, 0.48),
                            ],
                            stops: [0.0, 0.9646], // 0% and 96.46%
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 12),
                        child: Row(
                          children: [
                            AppSVGAssets.getWidget(
                                AppSVGAssets.centerIcon),
                            Gaps.hGap4,
                            CustomText(
                              controller.selectedCenter?.nurseryName ??
                                  "",
                              textStyle: TextStyles.button12
                                  .copyWith(color: ColorCode.neutral600),
                            ),
                            Gaps.hGap4,
                            AppSVGAssets.getWidget(
                                AppSVGAssets.subLocation),
                            Gaps.hGap4,
                            CustomText(
                              "${AppStrings.mainBranch}: ${AuthService.to
                                  .language == "ar" ? controller.selectedCenter
                                  ?.city?.name?.ar ?? "" : controller
                                  .selectedCenter?.city?.name?.en ?? ""}",
                              textStyle: TextStyles.button12.copyWith(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 8.sp,
                                  color: ColorCode.neutral600),
                            ),
                          ],
                        ),
                      ),
                      Gaps.vGap16,
                      SizedBox(
                        height: 200.h,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.children?.length ?? 0,
                          itemBuilder: (context, index) =>
                              GestureDetector(
                                onTap: () {
                                  controller.toggleChildFilter(
                                      controller.children?[index].id ?? 0);
                                },
                                child: Container(
                                  margin: const EdgeInsetsDirectional.only(
                                      end: 8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16.r),
                                    border: Border.all(
                                        color: controller.isChildSelected(
                                            controller.children?[index]
                                                .id ??
                                                0)
                                            ? (controller.children?[index]
                                            .gender ==
                                            "boy"
                                            ? ColorCode.secondary600
                                            : ColorCode
                                            .secondaryBurgundy600)
                                            : ColorCode.neutral400),
                                  ),
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Image(
                                            image: controller.isChildSelected(
                                                controller
                                                    .children?[index]
                                                    .id ??
                                                    0)
                                                ? (controller.children?[index]
                                                .gender ==
                                                "boy"
                                                ? AppAssets.boyFill
                                                : AppAssets.girlFill)
                                                : controller.children?[index]
                                                .gender ==
                                                "boy"
                                                ? AppAssets.boy
                                                : AppAssets.girl),
                                      ),
                                      Gaps.vGap8,
                                      CustomText(
                                        controller
                                            .children?[index].childName ??
                                            "",
                                        textStyle: TextStyles.body16Medium
                                            .copyWith(
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.w500,
                                            color: controller
                                                .isChildSelected(
                                                controller
                                                    .children?[
                                                index]
                                                    .id ??
                                                    0)
                                                ? ColorCode.primary600
                                                : ColorCode.neutral500),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                        ),
                      ),
                      Gaps.vGap16,
                      GetBuilder<AddChildController>(
                        builder: (controller) {
                          return SizedBox(
                            width: double.infinity,
                            child: SignupBranchesDropdown(
                              selectedValue: controller.selectedBranch,
                              isError: controller.isBranchError.value,
                              onChange: (val) {
                                controller.selectedBranch = val;
                                controller.isBranchError.value = false;
                                controller.update();
                              },
                              branchesList:
                              controller.selectedCenter?.branches ??
                                  [],
                            ),
                          );
                        },
                      ),
                      Gaps.vGap16,
                      GetBuilder<AddChildController>(builder: (ctrl) {
                        return SignupPricingTypesDropdown(
                          selectedValue: ctrl.selectedBranchPricing,
                          isError: false,
                          onChange: (val) {
                            ctrl.selectedBranchPricing = val;
                            ctrl.update();
                          },
                          typesList: ctrl.selectedBranch?.pricing ?? [],
                        );
                      }),
                      Gaps.vGap16,
                      Obx(() {
                        return Visibility(
                          visible: !controller.isSending.value,
                          replacement: Center(
                            child: SpinKitCircle(
                              color: ColorCode.primary600,
                            ),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(8.r),
                            onTap: () async {
                              await controller.sendRequest();
                            },
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                gradient: const LinearGradient(
                                  begin: Alignment.centerRight,
                                  end: Alignment.centerLeft,
                                  transform: GradientRotation(
                                      98.52 * (3.1415926535 / 180)),
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
                              margin: EdgeInsets.symmetric(horizontal: 16),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.5),
                              child: CustomText(
                                AppStrings.submitARequest,
                                textStyle: TextStyles.body16Medium
                                    .copyWith(color: ColorCode.white),
                              ),
                            ),
                          ),
                        );
                      }),
                    ],
                  );
                }
              } else {
                return SizedBox();
              }
            }),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: AppSVGAssets.getWidget(
                          AppSVGAssets.closeDialog),
                    ),
                  ],
                ),
                Center(
                  child: CustomText(
                    AppStrings.yourAccountHasBeenCreatedSuccessfully,
                    textStyle: TextStyles.subtitle20Bold
                        .copyWith(color: ColorCode.success600),
                  ),
                ),
                Gaps.vGap16,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(8.r),
                      onTap: () async {
                        controller.isSubed.value = true;
                        if ((controller.centersModel?.data?.isEmpty ??
                            false) ||
                            controller.centersModel == null) {
                          await controller.getCentersWithFilter(
                              filter: AppStrings.all);
                        }
                      },
                      child: SubCard(
                        assetName: AppAssets.globeLocation,
                        title: AppStrings.doYouHaveASubscription,
                        subTitle: AppStrings.findYourChildNurseryOrCenter,
                      ),
                    ),
                    Gaps.hGap4,
                    InkWell(
                      borderRadius: BorderRadius.circular(8.r),
                      onTap: () async {
                        Get.offAllNamed(Routes.BOTTOM_NAVIGATION);
                      },
                      child: SubCard(
                        assetName: AppAssets.abstractSearch,
                        title: AppStrings.dontHaveASubscription,
                        subTitle:
                        AppStrings.findANurseryOrCenterThatSuitsYou,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
