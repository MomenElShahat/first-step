// import 'package:first_step/pages/center/auth/signup/presentation/controllers/signup_controller.dart';
// import 'package:first_step/pages/center/auth/signup/presentation/widgets/step1.dart';
// import 'package:first_step/resources/assets_svg_generated.dart';
// import 'package:first_step/widgets/custom_text.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../../../../consts/colors.dart';
// import '../../../../../../consts/text_styles.dart';
// import '../../../../../../resources/strings_generated.dart';
// import '../../../../../../routes/app_pages.dart';
// import '../../../../../../widgets/custom_button.dart';
// import '../../../../../../widgets/custom_snackbar.dart';
// import '../../../../../../widgets/custom_text_form_field.dart';
// import '../../../../../../widgets/gaps.dart';
// import 'check_box.dart';
// import 'days_dropdown.dart';
//
// class Step2 extends GetView<SignupController> {
//   const Step2({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       return Visibility(
//           visible: controller.index.value == 2,
//           replacement: const SizedBox(),
//           child: Form(
//             key: controller.formKey2,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Center(
//                   child: CustomText(
//                     AppStrings.acceptableAges,
//                     textStyle: TextStyles.body16Medium.copyWith(color: ColorCode.primary600),
//                   ),
//                 ),
//                 Gaps.vGap8,
//                 ...buildCheckBoxGrid(controller.ages),
//                 Gaps.vGap8,
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                   child: RichText(
//                     text: TextSpan(
//                       children: [
//                         TextSpan(
//                             text: AppStrings.isThereAnythingYouWouldLikeToAdd, style: TextStyles.body14Medium.copyWith(color: ColorCode.neutral500)),
//                         // TextSpan(
//                         //     text: "*",
//                         //     style: TextStyles.body14Medium
//                         //         .copyWith(color: ColorCode.danger700)),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Gaps.vGap8,
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                   child: CustomTextFormField(
//                       hint: AppStrings.writeHere,
//                       onSave: (String? val) {
//                         controller.added.text = val!;
//                       },
//                       onChange: (String? val) {
//                         controller.added.text = val!;
//                         // final englishText = convertArabicToEnglish(val ??"");
//                         // controller.floorNumber.value  =controller.floorNumber.value.copyWith(
//                         //   text: englishText,
//                         //   selection: TextSelection.collapsed(offset: englishText.length),
//                         // );
//                       },
//                       controller: controller.added,
//                       validator: (val) {
//                         return null;
//                       },
//                       inputType: TextInputType.text,
//                       label: ""),
//                 ),
//                 Gaps.vGap8,
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                   child: RichText(
//                     text: TextSpan(
//                       children: [
//                         TextSpan(text: AppStrings.workStartsFromTheDay, style: TextStyles.body14Medium.copyWith(color: ColorCode.neutral500)),
//                         TextSpan(text: "*", style: TextStyles.body14Medium.copyWith(color: ColorCode.danger700)),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Gaps.vGap8,
//                 Obx(() => Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16),
//                       child: DaysDropdown(
//                         daysList: controller.daysList,
//                         selectedValue: controller.selectedStartDay.value,
//                         isError: controller.isStartDayError.value,
//                         onChange: (val) {
//                           controller.selectedStartDay.value = val ?? "";
//                           controller.update();
//                           if (val != null) {
//                             controller.isStartDayError.value = false;
//                             controller.update();
//                           }
//                         },
//                       ),
//                     )),
//                 Gaps.vGap8,
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                   child: RichText(
//                     text: TextSpan(
//                       children: [
//                         TextSpan(text: AppStrings.fromTheHour, style: TextStyles.body14Medium.copyWith(color: ColorCode.neutral500)),
//                         TextSpan(text: "*", style: TextStyles.body14Medium.copyWith(color: ColorCode.danger700)),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Gaps.vGap8,
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                   child: InkWell(
//                     onTap: () async {
//                       controller.startTime = await controller.pickTime(context);
//                       controller.fromHour.text = controller.startTime?.format(context) ?? "";
//                       // "${controller.startTime?.hour ?? 0} : ${controller.startTime?.minute ?? 0}";
//                     },
//                     child: CustomTextFormField(
//                         hint: "16:55",
//                         suffixIcon: AppSVGAssets.getWidget(AppSVGAssets.timeLine, width: 10, height: 10),
//                         onSave: (String? val) {
//                           controller.fromHour.text = val!;
//                         },
//                         readOnly: true,
//                         enable: false,
//                         onChange: (String? val) {
//                           controller.fromHour.text = val!;
//                           // final englishText = convertArabicToEnglish(val ??"");
//                           // controller.floorNumber.value  =controller.floorNumber.value.copyWith(
//                           //   text: englishText,
//                           //   selection: TextSelection.collapsed(offset: englishText.length),
//                           // );
//                         },
//                         controller: controller.fromHour,
//                         validator: (val) {
//                           return (controller.fromHour.text.isNotEmpty) ? null : AppStrings.emptyField;
//                         },
//                         inputType: TextInputType.text,
//                         label: ""),
//                   ),
//                 ),
//                 Gaps.vGap8,
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                   child: RichText(
//                     text: TextSpan(
//                       children: [
//                         TextSpan(text: AppStrings.workEndsAtTheDay, style: TextStyles.body14Medium.copyWith(color: ColorCode.neutral500)),
//                         TextSpan(text: "*", style: TextStyles.body14Medium.copyWith(color: ColorCode.danger700)),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Gaps.vGap8,
//                 Obx(() => Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16),
//                       child: DaysDropdown(
//                         daysList: controller.daysList,
//                         selectedValue: controller.selectedEndDay.value,
//                         isError: controller.isEndDayError.value,
//                         onChange: (val) {
//                           controller.selectedEndDay.value = val ?? "";
//                           controller.update();
//                           if (val != null) {
//                             controller.isEndDayError.value = false;
//                             controller.update();
//                           }
//                         },
//                       ),
//                     )),
//                 Gaps.vGap8,
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                   child: RichText(
//                     text: TextSpan(
//                       children: [
//                         TextSpan(text: AppStrings.untilTheHour, style: TextStyles.body14Medium.copyWith(color: ColorCode.neutral500)),
//                         TextSpan(text: "*", style: TextStyles.body14Medium.copyWith(color: ColorCode.danger700)),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Gaps.vGap8,
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                   child: InkWell(
//                     onTap: () async {
//                       controller.endTime = await controller.pickTime(context);
//                       controller.untilHour.text = controller.endTime?.format(context) ?? "";
//                       // "${controller.endTime?.hour ?? 0} : ${controller.endTime?.minute ?? 0}";
//                     },
//                     child: CustomTextFormField(
//                         hint: "16:55",
//                         suffixIcon: AppSVGAssets.getWidget(AppSVGAssets.timeLine, width: 10, height: 10),
//                         onSave: (String? val) {
//                           controller.untilHour.text = val!;
//                         },
//                         readOnly: true,
//                         enable: false,
//                         onChange: (String? val) {
//                           controller.untilHour.text = val!;
//                           // final englishText = convertArabicToEnglish(val ??"");
//                           // controller.floorNumber.value  =controller.floorNumber.value.copyWith(
//                           //   text: englishText,
//                           //   selection: TextSelection.collapsed(offset: englishText.length),
//                           // );
//                         },
//                         controller: controller.untilHour,
//                         validator: (val) {
//                           return (controller.untilHour.text.isNotEmpty) ? null : AppStrings.emptyField;
//                         },
//                         inputType: TextInputType.text,
//                         label: ""),
//                   ),
//                 ),
//                 Gaps.vGap24,
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: CustomButton(
//                             child: CustomText(
//                               AppStrings.next,
//                               textStyle: TextStyles.body16Medium.copyWith(fontWeight: FontWeight.w700, color: ColorCode.white),
//                             ),
//                             onPressed: () {
//                               if (controller.formKey2.currentState?.validate() ?? false) {
//                                 if (!(controller.ages.any(
//                                   (element) => element["isChecked"].value == true,
//                                 ))) {
//                                   customSnackBar(AppStrings.pleaseSelectAnAcceptedAge, ColorCode.danger700);
//                                 } else if (controller.selectedStartDay.value == AppStrings.selectADay) {
//                                   customSnackBar(AppStrings.pleaseSelectAStartDay, ColorCode.danger700);
//                                 } else if (controller.selectedEndDay.value == AppStrings.selectADay) {
//                                   customSnackBar(AppStrings.pleaseSelectAEndDay, ColorCode.danger700);
//                                 } else if (controller.startTime == null) {
//                                   customSnackBar(AppStrings.pleaseSelectAStartTime, ColorCode.danger700);
//                                 } else if (controller.endTime == null) {
//                                   customSnackBar(AppStrings.pleaseSelectAEndTime, ColorCode.danger700);
//                                 } else {
//                                   controller.index.value = 3;
//                                   print("ages ${controller.getSelectedAges(controller.ages)}");
//                                   print("selectedStartDay ${controller.selectedStartDay.value}");
//                                   print("selectedEndDay ${controller.selectedEndDay.value}");
//                                   print("startTime ${controller.startTime!.format(context)}");
//                                   print("endTime ${controller.endTime!.format(context)}");
//                                 }
//                               }
//                             }),
//                       ),
//                       Gaps.hGap(48),
//                       Expanded(
//                         child: InkWell(
//                           onTap: () {
//                             controller.index.value = 1;
//                           },
//                           child: Container(
//                             decoration: BoxDecoration(borderRadius: BorderRadius.circular(36), border: Border.all(color: ColorCode.neutral400)),
//                             padding: const EdgeInsets.symmetric(vertical: 14.5),
//                             child: CustomText(
//                               AppStrings.previous,
//                               textStyle: TextStyles.body16Medium.copyWith(fontWeight: FontWeight.w700, color: ColorCode.neutral500),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Gaps.vGap24,
//                 Center(
//                   child: RichText(
//                     text: TextSpan(
//                       children: [
//                         TextSpan(
//                           text: "${AppStrings.haveAnAccount} ",
//                           style: TextStyles.body16Medium.copyWith(color: ColorCode.neutral500),
//                         ),
//                         TextSpan(
//                           text: AppStrings.login,
//                           recognizer: TapGestureRecognizer()..onTap = () => Get.toNamed(Routes.LOGIN),
//                           style: TextStyles.body16Medium.copyWith(color: ColorCode.info600),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Gaps.vGap24,
//               ],
//             ),
//           ));
//     });
//   }
// }
//
// Widget _buildCheckBoxRow(int index1, int index2, int index3, List<RxBool> isChecked) {
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: [
//       CheckBox(
//         isChecked[0],
//         label: AppStrings.from0To3Years,
//         index: index1,
//       ),
//       Gaps.hGap4,
//       CheckBox(isChecked[1], label: AppStrings.from3To6Years, index: index2),
//       Gaps.hGap4,
//       CheckBox(isChecked[2], label: AppStrings.childrenWithSpecialNeeds, index: index3),
//     ],
//   );
// }
