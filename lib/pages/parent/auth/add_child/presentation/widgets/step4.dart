// import 'package:first_step/resources/assets_svg_generated.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:get/get.dart';
//
// import '../../../../../../consts/colors.dart';
// import '../../../../../../consts/text_styles.dart';
// import '../../../../../../resources/strings_generated.dart';
// import '../../../../../../routes/app_pages.dart';
// import '../../../../../../widgets/custom_button.dart';
// import '../../../../../../widgets/custom_text.dart';
// import '../../../../../../widgets/custom_text_form_field.dart';
// import '../../../../../../widgets/gaps.dart';
// import '../controllers/add_child_controller.dart';
// import 'authorized_section.dart';
//
// class Step4 extends GetView<AddChildController> {
//   const Step4({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       return Visibility(
//         visible: controller.index.value == 4,
//         replacement: const SizedBox(),
//         child: Form(
//           key: controller.formKey5,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Obx(() => Column(
//                     children: List.generate(controller.authorizedPersons.length,
//                         (index) {
//                       return AuthorizedSection(
//                         index: index,
//                         authorizedPerson: controller.authorizedPersons[index],
//                         onRemove: () =>
//                             controller.removeAuthorizedPersons(index),
//                       );
//                     }),
//                   )),
//               Gaps.vGap8,
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 child: RichText(
//                   text: TextSpan(
//                     children: [
//                       TextSpan(
//                           text: AppStrings.doYouHaveAnyCommentsOrRemarks,
//                           style: TextStyles.body14Medium
//                               .copyWith(color: ColorCode.neutral500)),
//                     ],
//                   ),
//                 ),
//               ),
//               Gaps.vGap8,
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 child: CustomTextFormField(
//                     hint: AppStrings.writeHere,
//                     onSave: (String? val) {
//                       controller.doYouHaveAnyCommentsOrRemarks.text = val!;
//                     },
//                     onChange: (String? val) {
//                       controller.doYouHaveAnyCommentsOrRemarks.text = val!;
//                       // final englishText = convertArabicToEnglish(val ??"");
//                       // controller.floorNumber.value  =controller.floorNumber.value.copyWith(
//                       //   text: englishText,
//                       //   selection: TextSelection.collapsed(offset: englishText.length),
//                       // );
//                     },
//                     controller: controller.doYouHaveAnyCommentsOrRemarks,
//                     // validator: (val) {
//                     //   return (controller.doYouHaveAnyCommentsOrRemarks.text.isNotEmpty)
//                     //       ? null
//                     //       : AppStrings.emptyField;
//                     // },
//                     inputType: TextInputType.text,
//                     label: ""),
//               ),
//               Gaps.vGap16,
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 50),
//                 child: Center(
//                   child: InkWell(
//                     onTap: controller.addAuthorizedPersons,
//                     child: Container(
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(8),
//                           border: Border.all(color: ColorCode.primary600)),
//                       padding: const EdgeInsets.symmetric(vertical: 12),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           AppSVGAssets.getWidget(AppSVGAssets.plusBold),
//                           Gaps.hGap16,
//                           CustomText(
//                             AppStrings.addAnAuthorizedPerson,
//                             textStyle: TextStyles.body16Medium.copyWith(
//                                 fontWeight: FontWeight.w700,
//                                 color: ColorCode.primary600),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Gaps.vGap24,
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 child: Row(
//                   children: [
//                     controller.obx(
//                         (state) => Expanded(
//                               child: CustomButton(
//                                   child: CustomText(
//                                     AppStrings.createAnAccount,
//                                     textStyle: TextStyles.body16Medium.copyWith(
//                                         fontWeight: FontWeight.w700,
//                                         color: ColorCode.white),
//                                   ),
//                                   onPressed: () {
//                                     if (controller.formKey5.currentState
//                                             ?.validate() ??
//                                         false) {
//                                       controller
//                                           .onRegisterParentClicked(context);
//                                       for (int i = 0;
//                                           i <
//                                               controller
//                                                   .authorizedPersons.length;
//                                           i++) {
//                                         debugPrint(
//                                             "authorizedPersons name ${controller.authorizedPersons[i].name}");
//                                         debugPrint(
//                                             "authorizedPersons cin ${controller.authorizedPersons[i].cin}");
//                                       }
//                                     }
//                                   }),
//                             ),
//                         onLoading: const SpinKitCircle(
//                           color: ColorCode.primary600,
//                         )),
//                     Gaps.hGap(48),
//                     Expanded(
//                       child: InkWell(
//                         onTap: () {
//                           controller.index.value = 3;
//                         },
//                         child: Container(
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(8),
//                               border: Border.all(color: ColorCode.neutral400)),
//                           padding: const EdgeInsets.symmetric(vertical: 14.5),
//                           child: CustomText(
//                             AppStrings.previous,
//                             textStyle: TextStyles.body16Medium.copyWith(
//                                 fontWeight: FontWeight.w700,
//                                 color: ColorCode.neutral500),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               // Gaps.vGap16,
//               // Center(
//               //   child: CustomText(
//               //     AppStrings.wantToAddTheRestOfYourChildren,
//               //     textStyle: TextStyles.body16Medium
//               //         .copyWith(color: ColorCode.primary600),
//               //   ),
//               // ),
//               // Gaps.vGap16,
//               // Padding(
//               //   padding: const EdgeInsets.symmetric(horizontal: 76),
//               //   child: Center(
//               //     child: InkWell(
//               //       onTap: () {
//               //         controller.index.value = 1;
//               //       },
//               //       child: Container(
//               //         decoration: BoxDecoration(
//               //             borderRadius: BorderRadius.circular(36),
//               //             border: Border.all(color: ColorCode.primary600)),
//               //         padding: const EdgeInsets.symmetric(vertical: 12),
//               //         child: Row(
//               //           mainAxisAlignment: MainAxisAlignment.center,
//               //           children: [
//               //             AppSVGAssets.getWidget(AppSVGAssets.plusBold),
//               //             Gaps.hGap16,
//               //             CustomText(
//               //               AppStrings.addAnotherChild,
//               //               textStyle: TextStyles.body16Medium.copyWith(
//               //                   fontWeight: FontWeight.w700,
//               //                   color: ColorCode.primary600),
//               //             ),
//               //           ],
//               //         ),
//               //       ),
//               //     ),
//               //   ),
//               // ),
//               Gaps.vGap24,
//               Center(
//                 child: RichText(
//                   text: TextSpan(
//                     children: [
//                       TextSpan(
//                         text: "${AppStrings.haveAnAccount} ",
//                         style: TextStyles.body16Medium
//                             .copyWith(color: ColorCode.neutral500),
//                       ),
//                       TextSpan(
//                         text: AppStrings.login,
//                         recognizer: TapGestureRecognizer()
//                           ..onTap = () => Get.toNamed(Routes.LOGIN),
//                         style: TextStyles.body16Medium
//                             .copyWith(color: ColorCode.info600),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Gaps.vGap24,
//             ],
//           ),
//         ),
//       );
//     });
//   }
// }
