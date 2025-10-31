import 'package:first_step/pages/parent/edit_profile_parent/model/show_parent_data_model.dart';
import 'package:first_step/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../consts/colors.dart';
import '../../../../../widgets/custom_snackbar.dart';
import '../../data/edit_profile_parent_repository.dart';
import '../../model/edit_profile_parent_request_model.dart';
import '../../model/edit_profile_parent_response_model.dart';

class EditProfileParentController extends SuperController<bool> {
  EditProfileParentController({required this.editProfileParentRepository});

  final IEditProfileParentRepository editProfileParentRepository;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<FormState> passwordFormKey = GlobalKey<FormState>();
  TextEditingController arabic = TextEditingController();
  TextEditingController mobileNumber = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController nationalNumber = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  RxString phone = "".obs;

  final arabicFocus = FocusNode();
  final mobileFocus = FocusNode();
  final emailFocus = FocusNode();
  final nationalNumberFocus = FocusNode();

  RxBool isHidden = true.obs;
  RxBool isHiddenConfirm = true.obs;

  EditProfileParentResponseModel? editProfileParentResponseModel;
  // RxBool isSaving = false.obs;


  ShowParentDataModel? showParentDataModel;
  getParentData() async {
    change(false, status: RxStatus.loading());
    editProfileParentRepository.getParentData().then(
          (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          showParentDataModel = null;
          showParentDataModel = value.body;
          getData(showParentDataModel!);
          update();
        }
        change(true, status: RxStatus.success());
      },
    ).onError((error, stackTrace) {
      print("Signup error: $error");
      print("StackTrace: $stackTrace");
      customSnackBar(error.toString(), ColorCode.danger600);
      change(true, status: RxStatus.success());
    });
  }

  RxBool isVerifying = false.obs;
  verifyPassword(String password) async {
    // change(false, status: RxStatus.loading());
    isVerifying.value = true;
    editProfileParentRepository.verifyPassword(password).then(
          (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          if(value.body == "Password matched"){
            await editProfile();
          }
          update();
        }
        // change(true, status: RxStatus.success());
        isVerifying.value = false;
      },
    ).onError((error, stackTrace) {
      print("Signup error: $error");
      print("StackTrace: $stackTrace");
      customSnackBar(error.toString(), ColorCode.danger600);
      // change(true, status: RxStatus.success());
      isVerifying.value = false;
    });
  }

  editProfile() async {
    // change(false, status: RxStatus.loading());
    // isSaving.value = true;
    final EditProfileParentRequestModel editProfileParentRequestModel =
        EditProfileParentRequestModel(
      email: email.text == showParentDataModel?.data?.email ? null : email.text,
      phone: mobileNumber.text == showParentDataModel?.data?.phone ? null : "+966${mobileNumber.text}",
      name: arabic.text == showParentDataModel?.data?.name ? null : arabic.text,
      nationalNumber:
          nationalNumber.text == showParentDataModel?.data?.nationalNumber ? null : nationalNumber.text,
    );
    editProfileParentRepository.editProfile(editProfileParentRequestModel).then(
      (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          editProfileParentResponseModel = value.body;
          customSnackBar(editProfileParentResponseModel?.message ?? "",
              ColorCode.success600);
          update();
        }
        // change(true, status: RxStatus.success());
        // isSaving.value = false;
        Get.back();
        confirmPassword.clear();
        await getParentData();
      },
    ).onError((error, stackTrace) {
      print("Signup error: $error");
      print("StackTrace: $stackTrace");
      customSnackBar(error.toString(), ColorCode.danger600);
      // change(true, status: RxStatus.success());
      // isSaving.value = false;
    });
  }

  getData(ShowParentDataModel showParentDataModel) {
    arabic.text = showParentDataModel.data?.name ?? "";
    mobileNumber.text = showParentDataModel.data?.phone?.replaceAll("+966", "") ?? "";
    phone.value = showParentDataModel.data?.phone?.replaceAll("+966", "") ?? "";
    email.text = showParentDataModel.data?.email ?? "";
    nationalNumber.text = showParentDataModel.data?.nationalNumber ?? "";
    update();
  }

  RxString editableField = "".obs; // field name currently editable
  RxBool isAnyFieldChanged = false.obs;

  void enableEdit(String fieldName) {
    editableField.value = fieldName;
  }

  final changedFields = <String, bool>{}.obs;

  // void onFieldChanged(String fieldName, String value) {
  //   if (value != getOriginalValue(fieldName)) {
  //     isAnyFieldChanged.value = true;
  //   } else {
  //     // Check if all fields match original values
  //     isAnyFieldChanged.value = hasAnyChanged();
  //   }
  // }

  void onFieldChanged(String fieldKey, String newValue) {
    // Compare with original values here if you have them
    bool hasChanged =
        newValue.trim().isNotEmpty; // Or compare with original data
    changedFields[fieldKey] = hasChanged;

    // This will still keep your global flag
    isAnyFieldChanged.value = changedFields.containsValue(true);
  }

  String getOriginalValue(String fieldName) {
    switch (fieldName) {
      case "arabic":
        return AuthService.to.userInfo?.user?.name ?? "";
      case "mobileNumber":
        return AuthService.to.userInfo?.user?.phone ?? "";
      case "email":
        return AuthService.to.userInfo?.user?.email ?? "";
      case "nationalNumber":
        return AuthService.to.userInfo?.user?.nationalNumber ?? "";
      default:
        return "";
    }
  }

  bool hasAnyChanged() {
    return arabic.text != getOriginalValue("arabic") ||
        mobileNumber.text != getOriginalValue("mobileNumber") ||
        email.text != getOriginalValue("email") ||
        nationalNumber.text != getOriginalValue("nationalNumber");
  }

  @override
  void onInit() async {
    change(true, status: RxStatus.success());
    await getParentData();
    super.onInit();
  }

  @override
  void onClose() {
    arabicFocus.dispose();
    mobileFocus.dispose();
    emailFocus.dispose();
    nationalNumberFocus.dispose();
    super.onClose();
  }

  @override
  void onDetached() {
    // TODO: implement onDetached
  }

  @override
  void onHidden() {
    // TODO: implement onHidden
  }

  @override
  void onInactive() {
    // TODO: implement onInactive
  }

  @override
  void onPaused() {
    // TODO: implement onPaused
  }

  @override
  void onResumed() {
    // TODO: implement onResumed
  }
}
