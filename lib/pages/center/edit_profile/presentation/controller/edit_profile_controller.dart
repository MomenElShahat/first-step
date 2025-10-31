import 'package:first_step/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../consts/colors.dart';
import '../../../../../widgets/custom_snackbar.dart';
import '../../../auth/signup/models/cities_model.dart';
import '../../data/edit_profile_repository.dart';
import '../../model/edit_profile_request_model.dart';
import '../../model/edit_profile_response_model.dart' as response;
import '../../model/show_center_data_model.dart' as center;

class EditProfileController extends SuperController<bool> {
  EditProfileController({required this.editProfileRepository});

  final IEditProfileRepository editProfileRepository;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<FormState> passwordFormKey = GlobalKey<FormState>();

  TextEditingController arabic = TextEditingController();
  TextEditingController mobileNumber = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController neighborhood = TextEditingController();
  TextEditingController street = TextEditingController();
  TextEditingController locationLink = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  RxString phone = "".obs;

  final arabicFocus = FocusNode();
  final mobileFocus = FocusNode();
  final emailFocus = FocusNode();
  final neighborhoodFocus = FocusNode();
  final streetFocus = FocusNode();
  final locationLinkFocus = FocusNode();

  City? selectedCity;

  RxBool isCityError = false.obs;

  RxBool isHidden = true.obs;
  RxBool isHiddenConfirm = true.obs;

  List<City> cities = [];

  Name? cityName;
  getCities() async {
    change(false, status: RxStatus.loading());
    editProfileRepository.getCities().then(
      (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          cities = value.body?.data ?? [];
          cityName = cities.firstWhereOrNull((element) => (element.id ?? 0) == (AuthService.to.userInfo?.user?.cityId ?? 0))?.name;
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

  center.ShowCenterDataModel? showCenterDataModel;
  getCenterData() async {
    change(false, status: RxStatus.loading());
    editProfileRepository.getCenterData().then(
      (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          showCenterDataModel = null;
          showCenterDataModel = value.body;
          getData(showCenterDataModel!);
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
    editProfileRepository.verifyPassword(password).then(
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

  response.EditProfileResponseModel? editProfileResponseModel;
  // RxBool isSaving = false.obs;
  editProfile() async {
    // change(false, status: RxStatus.loading());
    // isSaving.value = true;
    final EditProfileRequestModel editProfileRequestModel = EditProfileRequestModel(
      cityId: selectedCity?.id ?? 0,
      email: email.text,
      location: locationLink.text,
      neighborhood: neighborhood.text,
      nurseryName: arabic.text,
      phone: "+966${mobileNumber.text}",
      address: street.text,
      name: arabic.text,
    );
    editProfileRepository.editProfile(editProfileRequestModel).then(
      (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          editProfileResponseModel = value.body;
          customSnackBar(editProfileResponseModel?.message ?? "", ColorCode.success600);
          update();
        }
        // change(true, status: RxStatus.success());
        // isSaving.value = false;
        Get.back();
        confirmPassword.clear();
        await getCenterData();
      },
    ).onError((error, stackTrace) {
      print("Signup error: $error");
      print("StackTrace: $stackTrace");
      customSnackBar(error.toString(), ColorCode.danger600);
      // change(true, status: RxStatus.success());
      // isSaving.value = false;
    });
  }

  getData(center.ShowCenterDataModel showCenterDataModel) {
    arabic.text = showCenterDataModel.data?.name ?? "";
    mobileNumber.text = showCenterDataModel.data?.phone?.replaceAll("+966", "") ?? "";
    phone.value = showCenterDataModel.data?.phone?.replaceAll("+966", "") ?? "";
    email.text = showCenterDataModel.data?.email ?? "";
    neighborhood.text = showCenterDataModel.data?.neighborhood ?? "";
    street.text = showCenterDataModel.data?.address ?? "";
    locationLink.text = showCenterDataModel.data?.location ?? "";
    selectedCity = City(id: showCenterDataModel.data?.cityId, name: cityName);
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
    bool hasChanged = newValue.trim().isNotEmpty; // Or compare with original data
    changedFields[fieldKey] = hasChanged;

    // This will still keep your global flag
    isAnyFieldChanged.value = changedFields.containsValue(true);
  }

  String getOriginalValue(String fieldName) {
    switch (fieldName) {
      case "arabic":
        return showCenterDataModel?.data?.name ?? "";
      case "mobileNumber":
        return showCenterDataModel?.data?.phone ?? "";
      case "email":
        return showCenterDataModel?.data?.email ?? "";
      case "neighborhood":
        return showCenterDataModel?.data?.neighborhood ?? "";
      case "street":
        return showCenterDataModel?.data?.address ?? "";
      case "locationLink":
        return showCenterDataModel?.data?.location ?? "";
      default:
        return "";
    }
  }

  late City originalCity;
  bool hasAnyChanged() {
    return arabic.text != getOriginalValue("arabic") ||
        mobileNumber.text != getOriginalValue("mobileNumber") ||
        email.text != getOriginalValue("email") ||
        neighborhood.text != getOriginalValue("neighborhood") ||
        street.text != getOriginalValue("street") ||
        locationLink.text != getOriginalValue("locationLink");
  }

  @override
  void onInit() async {
    await getCities();
    await getCenterData();
    originalCity = selectedCity ?? City();
    super.onInit();
  }

  @override
  void onClose() {
    arabicFocus.dispose();
    mobileFocus.dispose();
    emailFocus.dispose();
    neighborhoodFocus.dispose();
    streetFocus.dispose();
    locationLinkFocus.dispose();
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
