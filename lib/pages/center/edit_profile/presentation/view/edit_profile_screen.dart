import 'package:first_step/consts/text_styles.dart';
import 'package:first_step/resources/strings_generated.dart';
import 'package:first_step/services/auth_service.dart';
import 'package:first_step/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../../../../../consts/colors.dart';
import '../../../../../resources/assets_svg_generated.dart';
import '../../../../../utils/utils.dart';
import '../../../../../widgets/custom_button.dart';
import '../../../../../widgets/custom_button_container.dart';
import '../../../../../widgets/custom_text_form_field.dart';
import '../../../../../widgets/gaps.dart';
import '../../../auth/signup/models/cities_model.dart';
import '../../../auth/signup/presentation/widgets/cities_dropdown.dart';
import '../controller/edit_profile_controller.dart';

class EditProfileScreen extends GetView<EditProfileController> {
  const EditProfileScreen({super.key});

  Widget buildEditableField({
    required String fieldKey,
    required TextEditingController controllerField,
    required FocusNode focusNode, // NEW
    required String hint,
    required String? Function(String?) validator,
    TextInputType inputType = TextInputType.text,
    TextInputAction inputAction = TextInputAction.next,
    int? maxLength,
    String? isMobile,
  }) {
    return Obx(() {
      bool isEditable = controller.editableField.value == fieldKey;
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: CustomTextFormField(
          hint: hint,
          focusNode: focusNode,
          controller: controllerField,
          readOnly: !isEditable,
          maxLength: maxLength,
          onSave: (val) => controllerField.text = val ?? "",
          onChange: (val) {
            if(isMobile != null){
              controller.onFieldChanged(fieldKey, val ?? "");
              controller.phone.value = val!;
            }else {
              controller.onFieldChanged(fieldKey, val ?? "");
            }
          },
          suffixIcon: controller.changedFields[fieldKey] == true || isEditable
              ? const SizedBox()
              : InkWell(
                  onTap: () {
                    controller.enableEdit(fieldKey);
                    Future.delayed(const Duration(milliseconds: 100), () {
                      focusNode.requestFocus();
                    });
                  },
                  child: AppSVGAssets.getWidget(AppSVGAssets.editOutline),
                ),
          borderColor: controller.changedFields[fieldKey] == true || isEditable
              ? ColorCode.info600
              : ColorCode.neutral400,

          label: "",
          validator: validator,
          textInputAction: inputAction,
          inputType: inputType,
          // decoration: InputDecoration(
          //   counter: const SizedBox(),
          //   suffixIcon: InkWell(
          //     onTap: () {
          //       controller.enableEdit(fieldKey);
          //     },
          //     child: AppSVGAssets.getWidget(AppSVGAssets.editOutline),
          //   ),
          //   hintText: hint,
          //   hintStyle: TextStyles.body16Medium.copyWith(color: ColorCode.neutral500),
          //   // border: OutlineInputBorder(
          //   //   borderSide: BorderSide(
          //   //     color: isEditable ? ColorCode.info600 : ColorCode.neutral400,
          //   //   ),
          //   //   borderRadius: BorderRadius.circular(8),
          //   // ),
          // ),
          labelTextStyle: TextStyles.body16Medium.copyWith(
            color: isEditable ? ColorCode.info600 : ColorCode.neutral400,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorCode.white,
      extendBodyBehindAppBar: true,
      body: AnnotatedRegion(
        value: const SystemUiOverlayStyle(),
        child: controller.obx(
          (state) => SafeArea(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(),
                  child: SafeArea(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 16.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () => Get.back(),
                            child: const Icon(Icons.arrow_forward_ios_outlined),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Gaps.vGap16,
                        AppSVGAssets.getWidget(AppSVGAssets.signupLogo,
                            fit: BoxFit.fill),
                        CustomText(
                          AppStrings.editAccountInformation,
                          textStyle: TextStyles.title24Bold
                              .copyWith(color: ColorCode.primary600),
                        ),
                        Gaps.vGap16,
                        Form(
                          key: controller.formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Arabic name
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                      text: AppStrings.centerName,
                                      style: TextStyles.body14Medium.copyWith(
                                          color: ColorCode.neutral500),
                                    ),
                                    // TextSpan(
                                    //     text: "*",
                                    //     style: TextStyles.body14Medium.copyWith(
                                    //         color: ColorCode.danger700)),
                                  ]),
                                ),
                              ),
                              Gaps.vGap8,
                              buildEditableField(
                                fieldKey: "arabic",
                                controllerField: controller.arabic,
                                hint: AppStrings.egWowNursery,
                                validator: (val) =>
                                    controller.arabic.text.isNotEmpty
                                        ? null
                                        : AppStrings.emptyField,
                                focusNode: controller.arabicFocus,
                              ),

                              // Mobile
                              Gaps.vGap8,
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                      text: AppStrings.mobileNumber,
                                      style: TextStyles.body14Medium.copyWith(
                                          color: ColorCode.neutral500),
                                    ),
                                    // TextSpan(
                                    //     text: "*",
                                    //     style: TextStyles.body14Medium.copyWith(
                                    //         color: ColorCode.danger700)),
                                  ]),
                                ),
                              ),
                              Gaps.vGap8,
                              Directionality(
                                textDirection: TextDirection.ltr,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                                            decoration: BoxDecoration(
                                              border: Border.all(color: Colors.grey),
                                              borderRadius: BorderRadius.circular(8),
                                              color: Colors.grey.shade100,
                                            ),
                                            child: const Text(
                                              '+966 🇸🇦', // Saudi code with flag
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ),
                                          // Gaps.hGap8,
                                          Expanded(
                                            child: buildEditableField(
                                                fieldKey: "mobile",
                                                focusNode: controller.mobileFocus,
                                                controllerField: controller
                                                    .mobileNumber,
                                                hint: AppStrings.egMobileNumber,
                                                validator: (val) => null,
                                                inputType: TextInputType.phone,
                                                maxLength: 9,
                                                isMobile: "mobile"
                                            ),
                                          ),
                                        ],
                                      ),
                                      // ✅ Custom error text below (keeps field position stable)
                                      Obx(() {
                                        final isValid = isValidSaudiNumber(controller.phone.value);
                                        return isValid
                                            ? const SizedBox.shrink()
                                            : Padding(
                                          padding: const EdgeInsets.only(left: 72, top: 4),
                                          child: CustomText(
                                            AppStrings.phoneValidation,
                                            textAlign: TextAlign.start,
                                            textStyle: TextStyles.button12.copyWith(
                                                color: ColorCode.danger700,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        );
                                      }),
                                    ],
                                  ),
                                ),
                              ),

                              // Email
                              Gaps.vGap8,
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                      text: AppStrings.email,
                                      style: TextStyles.body14Medium.copyWith(
                                          color: ColorCode.neutral500),
                                    ),
                                    // TextSpan(
                                    //     text: "*",
                                    //     style: TextStyles.body14Medium.copyWith(
                                    //         color: ColorCode.danger700)),
                                  ]),
                                ),
                              ),
                              Gaps.vGap8,
                              buildEditableField(
                                fieldKey: "email",
                                focusNode: controller.emailFocus,
                                controllerField: controller.email,
                                hint: AppStrings.egEmail,
                                validator: (val) =>
                                    isValidEmail(controller.email.text)
                                        ? null
                                        : AppStrings.validateMail,
                              ),

                              // City (dropdown stays special)
                              Gaps.vGap8,
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                      text: AppStrings.theCity,
                                      style: TextStyles.body14Medium.copyWith(
                                          color: ColorCode.neutral500),
                                    ),
                                    // TextSpan(
                                    //     text: "*",
                                    //     style: TextStyles.body14Medium.copyWith(
                                    //         color: ColorCode.danger700)),
                                  ]),
                                ),
                              ),
                              Gaps.vGap8,

                              GetBuilder<EditProfileController>(
                                builder: (controller) {
                                  bool isCityEditable =
                                      controller.selectedCity !=
                                          controller.originalCity;

                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: CitiesDropdown(
                                      citiesList: controller.cities,
                                      selectedValue: controller.selectedCity,
                                      isError: controller.isCityError.value,
                                      isEditable: isCityEditable,
                                      // NEW
                                      onChange: (val) {
                                        controller.selectedCity = val ?? City();
                                        if (val != null) {
                                          controller.isCityError.value = false;
                                        }
                                        controller.isAnyFieldChanged.value =
                                            controller.selectedCity !=
                                                    controller.originalCity ||
                                                controller.hasAnyChanged();
                                        controller.update();
                                      },
                                    ),
                                  );
                                },
                              ),

                              // Neighborhood
                              Gaps.vGap8,
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                      text: AppStrings.theNeighborhood,
                                      style: TextStyles.body14Medium.copyWith(
                                          color: ColorCode.neutral500),
                                    ),
                                    // TextSpan(
                                    //     text: "*",
                                    //     style: TextStyles.body14Medium.copyWith(
                                    //         color: ColorCode.danger700)),
                                  ]),
                                ),
                              ),
                              Gaps.vGap8,
                              buildEditableField(
                                fieldKey: "neighborhood",
                                focusNode: controller.neighborhoodFocus,
                                controllerField: controller.neighborhood,
                                hint: "........",
                                validator: (val) =>
                                    controller.neighborhood.text.isNotEmpty
                                        ? null
                                        : AppStrings.emptyField,
                              ),

                              // Street
                              Gaps.vGap8,
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                      text: AppStrings.theStreet,
                                      style: TextStyles.body14Medium.copyWith(
                                          color: ColorCode.neutral500),
                                    ),
                                    // TextSpan(
                                    //     text: "*",
                                    //     style: TextStyles.body14Medium.copyWith(
                                    //         color: ColorCode.danger700)),
                                  ]),
                                ),
                              ),
                              Gaps.vGap8,
                              buildEditableField(
                                fieldKey: "street",
                                focusNode: controller.streetFocus,
                                controllerField: controller.street,
                                hint: "........",
                                validator: (val) =>
                                    controller.street.text.isNotEmpty
                                        ? null
                                        : AppStrings.emptyField,
                              ),

                              // Location Link
                              Gaps.vGap8,
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                      text: AppStrings.locationLink,
                                      style: TextStyles.body14Medium.copyWith(
                                          color: ColorCode.neutral500),
                                    ),
                                    // TextSpan(
                                    //     text: "*",
                                    //     style: TextStyles.body14Medium.copyWith(
                                    //         color: ColorCode.danger700)),
                                  ]),
                                ),
                              ),
                              Gaps.vGap8,
                              buildEditableField(
                                fieldKey: "locationLink",
                                focusNode: controller.locationLinkFocus,
                                controllerField: controller.locationLink,
                                hint: AppStrings.egGoogleMapsLink,
                                validator: (val) =>
                                    controller.locationLink.text.isNotEmpty
                                        ? null
                                        : AppStrings.emptyField,
                              ),

                              // Save / Cancel buttons
                              Gaps.vGap24,
                              Obx(() {
                                if (!controller.isAnyFieldChanged.value) {
                                  return const SizedBox.shrink();
                                }
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: CustomButton(
                                          child: CustomText(
                                            AppStrings.saveEdit,
                                            textStyle: TextStyles.body16Medium
                                                .copyWith(
                                              fontWeight: FontWeight.w700,
                                              color: ColorCode.white,
                                            ),
                                          ),
                                          onPressed: () async {
                                            if (controller.formKey.currentState
                                                    ?.validate() ??
                                                false) {
                                              Get.dialog(Dialog(
                                                backgroundColor:
                                                    ColorCode.white,
                                                insetPadding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8),
                                                child: Form(
                                                  key: controller
                                                      .passwordFormKey,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            16),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Center(
                                                          child: AppSVGAssets
                                                              .getWidget(
                                                                  AppSVGAssets
                                                                      .signupLogo),
                                                        ),
                                                        Gaps.vGap8,
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      0),
                                                          child: RichText(
                                                            text: TextSpan(
                                                              children: [
                                                                TextSpan(
                                                                    text: AppStrings
                                                                        .confirmPassword,
                                                                    style: TextStyles
                                                                        .body14Medium
                                                                        .copyWith(
                                                                            color:
                                                                                ColorCode.neutral500)),
                                                                // TextSpan(
                                                                //     text: "*",
                                                                //     style: TextStyles
                                                                //         .body14Medium
                                                                //         .copyWith(
                                                                //             color:
                                                                //                 ColorCode.danger700)),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        Gaps.vGap8,
                                                        Obx(() {
                                                          return Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        0),
                                                            child:
                                                                CustomTextFormField(
                                                                    controller:
                                                                        controller
                                                                            .confirmPassword,
                                                                    hint: AppStrings
                                                                        .confirmPassword,
                                                                    onSave: (String?
                                                                        val) {
                                                                      // controller.neighborhood.text = val!;
                                                                    },
                                                                    isHiddenPassword: controller
                                                                        .isHiddenConfirm
                                                                        .value,
                                                                    onTapShowHidePassword:
                                                                        () {
                                                                      controller
                                                                              .isHiddenConfirm
                                                                              .value =
                                                                          !controller
                                                                              .isHiddenConfirm
                                                                              .value;
                                                                    },
                                                                    obscureText:
                                                                        true,
                                                                    onChange:
                                                                        (String?
                                                                            val) {
                                                                      controller
                                                                          .confirmPassword
                                                                          .text = val!;
                                                                      // controller.neighborhood.text = val!;
                                                                      // final englishText = convertArabicToEnglish(val ??"");
                                                                      // controller.floorNumber.value  =controller.floorNumber.value.copyWith(
                                                                      //   text: englishText,
                                                                      //   selection: TextSelection.collapsed(offset: englishText.length),
                                                                      // );
                                                                    },
                                                                    // controller: controller.neighborhood,
                                                                    validator:
                                                                        (val) {
                                                                      return (controller.confirmPassword.text.isNotEmpty)
                                                                          ? null
                                                                          : AppStrings.emptyField;
                                                                    },
                                                                    inputType:
                                                                        TextInputType
                                                                            .text,
                                                                    label: ""),
                                                          );
                                                        }),
                                                        Gaps.vGap16,
                                                        Obx(() {
                                                          return Visibility(
                                                            visible:
                                                            // controller
                                                            //         .isSaving
                                                            //         .value ==
                                                            //     false ||
                                                                controller
                                                                .isVerifying
                                                                .value ==
                                                                false,
                                                            replacement:
                                                                const Center(
                                                                    child:
                                                                        SpinKitCircle(
                                                              color: ColorCode
                                                                  .primary600,
                                                            )),
                                                            child: Center(
                                                              child:
                                                                  CustomButton(
                                                                width: 106.w,
                                                                child:
                                                                    CustomText(
                                                                  AppStrings
                                                                      .confirm,
                                                                  textStyle: TextStyles
                                                                      .body16Medium
                                                                      .copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    color: ColorCode
                                                                        .white,
                                                                  ),
                                                                ),
                                                                onPressed:
                                                                    () async {
                                                                  if (controller
                                                                          .passwordFormKey
                                                                          .currentState
                                                                          ?.validate() ??
                                                                      false) {
                                                                    await controller
                                                                        .verifyPassword(controller
                                                                        .confirmPassword
                                                                        .text);
                                                                  }
                                                                },
                                                              ),
                                                            ),
                                                          );
                                                        })
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ));
                                            }
                                          },
                                        ),
                                      ),
                                      Gaps.hGap(48),
                                      Expanded(
                                        child: CustomButtonContainer(
                                          CustomButton(
                                            backGroundColor: ColorCode.white,
                                            child: CustomText(
                                              AppStrings.cancel,
                                              textStyle: TextStyles.body16Medium
                                                  .copyWith(
                                                fontWeight: FontWeight.w700,
                                                color: ColorCode.neutral500,
                                              ),
                                            ),
                                            onPressed: () {
                                              controller.getData(controller
                                                  .showCenterDataModel!);
                                              controller.isAnyFieldChanged
                                                  .value = false;
                                              controller.editableField.value =
                                                  "";
                                            },
                                          ),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: ColorCode.neutral400),
                                            borderRadius:
                                                BorderRadius.circular(8.r),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                              Gaps.vGap24,
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          onLoading: const Center(
            child: SpinKitCircle(color: ColorCode.primary600),
          ),
        ),
      ),
    );
  }
}
