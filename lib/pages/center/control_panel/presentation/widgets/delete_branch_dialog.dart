import 'package:first_step/consts/colors.dart';
import 'package:first_step/resources/strings_generated.dart';
import 'package:first_step/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../../../../consts/text_styles.dart';
import '../../../../../widgets/custom_text.dart';
import '../../../../../widgets/gaps.dart';

Future<void> showDeleteConfirmDialogBranch({
  required BuildContext context,
  required VoidCallback onConfirm,
  required RxBool isDeletingBranch,
}) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: Colors.white,
        title: Row(
          children: [
            const Icon(Icons.warning_amber_rounded, color: ColorCode.danger600),
            Gaps.hGap8,
            CustomText(AppStrings.deleteBranch, textStyle: TextStyles.body16Medium),
          ],
        ),
        content: CustomText(AppStrings.deleteBranchWarning, textStyle: TextStyles.body16Medium),
        actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        actions: <Widget>[
          CustomButton(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: ColorCode.neutral400),
              ),
              onPressed: () {
                Get.back();
              },
              backGroundColor: ColorCode.white,
              child: CustomText(AppStrings.cancel)),
          Gaps.vGap8,
          Obx(() {
            return isDeletingBranch.value
                ? const Center(
                    child: SpinKitCircle(
                      color: ColorCode.primary600,
                    ),
                  )
                : CustomButton(
                    onPressed: onConfirm,
                    child: CustomText(
                      AppStrings.delete,
                      textStyle: TextStyles.body16Medium.copyWith(color: ColorCode.white),
                    ));
          }),
        ],
      );
    },
  );
}
