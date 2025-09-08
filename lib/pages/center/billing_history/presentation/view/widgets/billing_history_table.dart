import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:first_step/consts/colors.dart';
import 'package:first_step/consts/text_styles.dart';
import 'package:first_step/resources/strings_generated.dart';
import 'package:first_step/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../../resources/assets_svg_generated.dart';
import '../../../../../../services/auth_service.dart';
import '../../../../../../widgets/custom_text.dart';
import '../../../../../../widgets/gaps.dart';
import '../../../model/billing_history_model.dart';
import '../../controller/billing_history_controller.dart';

class BillingHistoryTable extends GetView<BillingHistoryController> {
  final List<Bill> billingHistory;

  const BillingHistoryTable({super.key, required this.billingHistory});

  @override
  Widget build(BuildContext context) {
    final paginatedBillingHistory = billingHistory
        .skip((controller.currentPage - 1) * controller.rowsPerPage)
        .take(controller.rowsPerPage)
        .toList();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          color: ColorCode.primary600,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Row(
            children: [
              Expanded(
                  flex: 3,
                  child: CustomText(AppStrings.subscriptionType,
                      textStyle: TextStyles.body16Medium.copyWith(
                          fontWeight: FontWeight.w500,
                          color: ColorCode.white))),
              Expanded(
                  flex: 3,
                  child: CustomText(AppStrings.subscriptionStartDate,
                      textStyle: TextStyles.button12
                          .copyWith(color: ColorCode.white))),
              Expanded(
                  flex: 3,
                  child: CustomText(AppStrings.subscriptionEndDate,
                      textStyle: TextStyles.button12
                          .copyWith(color: ColorCode.white))),
              Expanded(
                  flex: 3,
                  child: CustomText(AppStrings.paymentMethod,
                      textStyle: TextStyles.button12
                          .copyWith(color: ColorCode.white))),
              Expanded(
                  flex: 3,
                  child: CustomText(AppStrings.price,
                      textStyle: TextStyles.button12
                          .copyWith(color: ColorCode.white))),
              Expanded(
                  flex: 3,
                  child: CustomText(AppStrings.subscriptionStatus,
                      textStyle: TextStyles.button12
                          .copyWith(color: ColorCode.white))),
            ],
          ),
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: paginatedBillingHistory.length,
          itemBuilder: (context, index) {
            final bill = paginatedBillingHistory[index];
            final subscriptionType = bill.typeOfPlan == "3 months"
                ? AppStrings.quarterly
                : bill.typeOfPlan == "6 Months"
                    ? AppStrings.biannual
                    : AppStrings.annual;
            final subscriptionStartDate =
                bill.startOfSubscription ?? '${DateTime.now()}';
            final subscriptionEndDate =
                bill.endOfSubscription ?? '${DateTime.now()}';
            final subscriptionPaymentMethod = AppStrings.moyasar;
                // bill.typeOfPayment ?? AppStrings.notFound;
            final subscriptionPrice = bill.price ?? AppStrings.notFound;
            final subscriptionStatus =
                bill.subscriptionStatus ?? AppStrings.notFound;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: CustomText(
                      subscriptionType,
                      textStyle: TextStyles.body16Medium.copyWith(
                          color: ColorCode.neutral600,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: CustomText(
                      controller.formatDate(subscriptionStartDate),
                      textStyle: TextStyles.button12
                          .copyWith(color: ColorCode.neutral600),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: CustomText(
                      controller.formatDate(subscriptionEndDate),
                      textStyle: TextStyles.button12
                          .copyWith(color: ColorCode.neutral600),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: CustomText(
                      subscriptionPaymentMethod,
                      textStyle: TextStyles.button12
                          .copyWith(color: ColorCode.neutral600),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: CustomText(
                      subscriptionPrice,
                      textStyle: TextStyles.button12
                          .copyWith(color: ColorCode.neutral600),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      decoration: BoxDecoration(
                        color: subscriptionStatus == "active"
                            ? ColorCode.success600
                            : ColorCode.danger600,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      child: Center(
                          child: CustomText(
                        subscriptionStatus == "active"
                            ? AppStrings.active
                            : AppStrings.expired,
                        textStyle: TextStyles.title24Bold
                            .copyWith(color: ColorCode.white, fontSize: 8.sp),
                      )),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        GetBuilder<BillingHistoryController>(builder: (controller) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton2<int>(
                  underline: Container(),
                  customButton: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                    decoration: BoxDecoration(
                      color: ColorCode.tableBg.withOpacity(.1),
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    child: Row(
                      children: [
                        AppSVGAssets.getWidget(AppSVGAssets.down,
                            color: ColorCode.primary600),
                        Gaps.hGap4,
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: CustomText("${controller.rowsPerPage}",
                              textStyle: TextStyles.body14Regular.copyWith(
                                  fontSize: 12.sp,
                                  color: ColorCode.primary600)),
                        ),
                      ],
                    ),
                  ),
                  menuItemStyleData: MenuItemStyleData(
                      height: 30.h,
                      padding: const EdgeInsetsDirectional.symmetric(
                          horizontal: 10)),
                  dropdownStyleData: DropdownStyleData(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                  ),
                  value: controller.rowsPerPage,
                  items: [10, 20, 30]
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: CustomText("$e",
                                textStyle: TextStyles.body14Regular.copyWith(
                                    fontSize: 12.sp,
                                    color: ColorCode.primary600)),
                          ))
                      .toList(),
                  onChanged: (value) {
                    controller.rowsPerPage = value!;
                    controller.currentPage = 1;
                    controller.update();
                  },
                ),
                Gaps.hGap10,
                IconButton(
                  onPressed: controller.currentPage > 1
                      ? () {
                          controller.currentPage = 1;
                          controller.update();
                        }
                      : null,
                  icon: Icon(
                    AuthService.to.language == "ar"
                        ? Icons.first_page
                        : Icons.last_page,
                    color: ColorCode.primary600,
                  ),
                ),
                IconButton(
                  onPressed: controller.currentPage > 1
                      ? () {
                          controller.currentPage--;
                          controller.update();
                        }
                      : null,
                  icon: Icon(
                    AuthService.to.language == "ar"
                        ? Icons.chevron_left
                        : Icons.chevron_right,
                    color: ColorCode.primary600,
                  ),
                ),
                IconButton(
                  onPressed: controller.currentPage <
                          (billingHistory.length /
                                  controller.rowsPerPage)
                              .ceil()
                      ? () {
                          controller.currentPage++;
                          controller.update();
                        }
                      : null,
                  icon: Icon(
                    AuthService.to.language == "ar"
                        ? Icons.chevron_right
                        : Icons.chevron_left,
                    color: ColorCode.primary600,
                  ),
                ),
                IconButton(
                  onPressed: controller.currentPage <
                          (billingHistory.length /
                                  controller.rowsPerPage)
                              .ceil()
                      ? () {
                          controller.currentPage =
                              (billingHistory.length /
                                      controller.rowsPerPage)
                                  .ceil();
                          controller.update();
                        }
                      : null,
                  icon: Icon(
                    AuthService.to.language == "ar"
                        ? Icons.last_page
                        : Icons.first_page,
                    color: ColorCode.primary600,
                  ),
                ),
                Gaps.hGap16,
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: paginatedBillingHistory.isEmpty
                      ? CustomText(
                          "0", // Or just show "0"
                          textStyle: TextStyles.body14Regular
                              .copyWith(color: ColorCode.primary600),
                        )
                      : CustomText(
                          '${(controller.currentPage - 1) * controller.rowsPerPage + 1}-'
                          '${(controller.currentPage * controller.rowsPerPage).clamp(1, billingHistory.length)} '
                          '${AppStrings.from} ${billingHistory.length}',
                          textStyle: TextStyles.body14Regular
                              .copyWith(color: ColorCode.primary600),
                        ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}
