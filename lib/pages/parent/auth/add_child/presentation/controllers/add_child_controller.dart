import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:first_step/resources/assets_generated.dart';
import 'package:first_step/routes/app_pages.dart';
import 'package:first_step/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../../consts/colors.dart';
import '../../../../../../consts/text_styles.dart';
import '../../../../../../resources/assets_svg_generated.dart';
import '../../../../../../resources/strings_generated.dart';
import '../../../../../../widgets/custom_snackbar.dart';
import '../../../../../../widgets/custom_text.dart';
import '../../../../../../widgets/gaps.dart';
import '../../../../../auth/login/models/login_request.dart';
import '../../../../../center/control_panel/models/child_model.dart' as child;
import '../../../../home_parent/models/centers_model.dart';
import '../../data/add_child_repository.dart';
import '../../model/child_request_model.dart';
import '../../model/child_response_model.dart';
import '../../model/existing_enrollment_request_model.dart';
import '../../model/existing_enrollment_response_model.dart';
import '../widgets/request_success_dialog.dart';
import '../widgets/sub_dialog_add_child.dart';

class AddChildController extends SuperController<dynamic> {
  AddChildController({required this.addChildRepository});

  final IAddChildRepository addChildRepository;

  // controllers for a single child input (you can use repeated inputs or dynamic lists in UI)
  TextEditingController childName = TextEditingController();
  TextEditingController dateOfBirth = TextEditingController();
  TextEditingController kinship = TextEditingController();
  TextEditingController fatherName = TextEditingController();
  TextEditingController motherName = TextEditingController();
  TextEditingController nationalId = TextEditingController();
  TextEditingController childImageController = TextEditingController();

  RxString selectedGender = AppStrings.boy.obs;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  RxInt index = 1.obs;

  // Maintain lists for multiple children
  final RxList<ChildRequestModel> childrenList = <ChildRequestModel>[].obs;

  // final RxList<File?> childrenImages = <File?>[].obs;

  RxBool isLoading = false.obs;

  Future<File?> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) return File(result.files.single.path!);
    return null;
  }

  Future<String?> pickDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000), // Set a minimum date
      lastDate: DateTime.now(),
    ); // Set a maximum date
    if (selectedDate != null) {
      return DateFormat('yyyy-MM-dd').format(selectedDate);
    }
    return null;
  }

  File? childImage;

  // Example: add the current form as a child entry
  void addChildEntry({File? image}) {
    final child = ChildRequestModel(
        childName: childName.text.isNotEmpty ? childName.text : null,
        birthdayDate: dateOfBirth.text.isNotEmpty ? dateOfBirth.text : null,
        parentName: fatherName.text.isNotEmpty ? fatherName.text : null,
        motherName: motherName.text.isNotEmpty ? motherName.text : null,
        kinship: kinship.text.isNotEmpty ? kinship.text : null,
        nationalNumber: nationalId.text.isNotEmpty ? nationalId.text : null,
        gender: selectedGender.value == AppStrings.boy ? "boy" : "girl",
        childImage: childImage);

    childrenList.add(child);
    // childrenImages.add(image); // allow null
    // optional: clear form fields after adding
    clearForm();
  }

  void removeChild(int index) {
    childrenList.removeAt(index);
  }

  void clearForm() {
    childName.clear();
    fatherName.clear();
    motherName.clear();
    kinship.clear();
    nationalId.clear();
    dateOfBirth.clear();
    childImageController.clear();
    childImage = null;
    selectedGender.value = AppStrings.boy;
  }

  ChildResponseModel? childResponseModel;

  // Send all children at once
  Future<void> submitChildren() async {
    if (childrenList.isEmpty) {
      customSnackBar(AppStrings.pleaseAddAChildAtLeast, ColorCode.danger600);
      return;
    }
    isLoading.value = true;
    try {
      final response = await addChildRepository.addChildren(
        childrenList.toList(),
        // childrenImages.toList(),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        // success
        childResponseModel = null;
        childResponseModel = response.body;
        Get.dialog(
          barrierDismissible: false,
          SubDialogAddChild(),
        );
        // Get.offAllNamed(Routes.BOTTOM_NAVIGATION);
      } else {
        // use response.body?.message or generic error
      }
    } catch (e) {
      print('Add children error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  CentersModel? centersModel;

  List<NurseryModel> centers = [];

  RxBool isCentersLoading = false.obs;

  Future<void> getCentersWithFilter({required String filter}) async {
    // change(false, status: RxStatus.loading());
    isCentersLoading.value = true;
    addChildRepository
        .getCentersWithFilter(filter: filter, selectedCityIds: []).then(
      (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          centersModel = null;
          centersModel = value.body;
          if (filter == AppStrings.all) {
            centers.clear();
            centers.addAll(centersModel?.data ?? []);
            filteredNurseries.addAll(centersModel?.data ?? []);
          }
          update();
        }
        // change(true, status: RxStatus.success());
        isCentersLoading.value = false;
      },
    ).onError((error, stackTrace) {
      print("Signup error: $error");
      print("StackTrace: $stackTrace");
      customSnackBar(error.toString(), ColorCode.danger600);
      // change(true, status: RxStatus.success());
      isCentersLoading.value = false;
    });
  }

  List<child.ChildModel>? children;

  List<int> selectedChildIds = [];

  void toggleChildFilter(int childId) {
    if (selectedChildIds.contains(childId)) {
      selectedChildIds.remove(childId);
    } else {
      selectedChildIds.add(childId);
    }
    update();
  }

  bool isChildSelected(int childId) => selectedChildIds.contains(childId);

  RxBool isChildrenLoading = false.obs;

  Future<void> getChildren() async {
    isChildrenLoading.value = true;
    // change(false, status: RxStatus.loading());
    addChildRepository.getChildren().then(
      (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          children = null;
          children = value.body;
          update();
        }
        isChildrenLoading.value = false;
        // change(true, status: RxStatus.success());
      },
    ).onError((error, stackTrace) {
      print("Signup error: $error");
      print("StackTrace: $stackTrace");
      customSnackBar(error.toString(), ColorCode.danger600);
      // change(true, status: RxStatus.success());
      isChildrenLoading.value = false;
    });
  }

  TextEditingController search = TextEditingController();

  RxList<NurseryModel> filteredNurseries = <NurseryModel>[].obs;

  NurseryModel? selectedCenter;

  void filterNurseries() {
    final query = search.text.toLowerCase();

    filteredNurseries.value = centers.where((nursery) {
      final matchesName =
          (nursery.nurseryName ?? '').toLowerCase().contains(query);
      return matchesName;
    }).toList();
    update();
  }

  RxBool isSubed = false.obs;

  RxBool isCenterSelected = false.obs;

  Branches? selectedBranch;

  RxBool isBranchError = false.obs;

  Pricing? selectedBranchPricing;

  RxBool isSending = false.obs;
  RxBool isSharing = false.obs;
  ExistingEnrollmentResponseModel? existingEnrollmentResponseModel;

  Future<void> sendRequest() async {
    ExistingEnrollmentRequestModel existingEnrollmentRequestModel =
        ExistingEnrollmentRequestModel(
      branchPriceId: selectedBranchPricing?.id ?? 0,
      centerBranchId: selectedBranch?.id ?? 0,
      children: selectedChildIds,
    );
    isSending.value = true;
    // change(false, status: RxStatus.loading());
    addChildRepository.sendRequest(existingEnrollmentRequestModel).then(
      (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          existingEnrollmentResponseModel = null;
          existingEnrollmentResponseModel = value.body;
          update();
          Get.back();
          Get.dialog(RequestSuccessDialog());
        }
        isSending.value = false;
        // change(true, status: RxStatus.success());
      },
    ).onError((error, stackTrace) {
      print("Signup error: $error");
      print("StackTrace: $stackTrace");
      customSnackBar(error.toString(), ColorCode.danger600);
      // change(true, status: RxStatus.success());
      isSending.value = false;
    });
  }

  @override
  void onInit() {
    super.onInit();
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
