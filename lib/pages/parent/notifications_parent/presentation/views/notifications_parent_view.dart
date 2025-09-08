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
import '../../../home_parent/presentation/widgets/center_card.dart';
import '../controllers/notifications_parent_controller.dart';

class NotificationsParentScreen
    extends GetView<NotificationsParentScreenController> {
  const NotificationsParentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorCode.white,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: controller.obx(
              (state) => RefreshIndicator(
                    onRefresh: controller.onRefresh,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Gaps.vGap16,
                          Stack(
                            alignment: AlignmentDirectional.centerEnd,
                            children: [
                              Center(
                                child: CustomText(
                                  AppStrings.notifications,
                                  textStyle: TextStyles.body16Medium.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: ColorCode.primary600),
                                ),
                              ),
                              InkWell(
                                onTap: () async{
                                  await controller.readAllParentNotifications();
                                },
                                child: CustomText(AppStrings.readAll,textStyle: TextStyles.body16Medium,),
                              )
                            ],
                          ),
                          Gaps.vGap16,
                          ...List.generate(
                            controller.parentNotificationsModel.length,
                            (index) {
                              final notification =
                                  controller.parentNotificationsModel[index];
                              return InkWell(
                                onTap: () async{
                                  await controller.readParentNotifications(notification.id ?? "");
                                },
                                child: Stack(
                                  alignment: AlignmentDirectional.topEnd,
                                  clipBehavior: Clip.none,
                                  children: [
                                    Card(
                                      elevation: 1,
                                      shadowColor: ColorCode.black3,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.r)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                AppSVGAssets.getWidget(
                                                    AppSVGAssets.iconBase),
                                                Gaps.hGap4,
                                                CustomText(
                                                  notification.reportId != null
                                                      ? AppStrings
                                                          .yourChildHasANewDailyReport
                                                      : notification
                                                              .description ??
                                                          "",
                                                  textStyle: TextStyles.button12
                                                      .copyWith(
                                                          color: ColorCode
                                                              .primary600),
                                                ),
                                              ],
                                            ),
                                            CustomText(
                                              formatTimeAgo(
                                                  notification.createdAt ??
                                                      "${DateTime.now()}"),
                                              textStyle: TextStyles.button12
                                                  .copyWith(
                                                      color: ColorCode.success600,
                                                      fontSize: 8.sp),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    if (notification.readAt == null)
                                      const CircleAvatar(
                                        backgroundColor: ColorCode.primary600,
                                        radius: 4,
                                      ),
                                  ],
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ),
              onLoading: const Center(
                child: SpinKitCircle(
                  color: ColorCode.primary600,
                ),
              )),
        ),
      ),
    );
  }
}
