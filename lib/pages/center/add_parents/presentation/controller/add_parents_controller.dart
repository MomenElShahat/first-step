import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:first_step/resources/strings_generated.dart';
import 'package:intl/intl.dart';
import '../../../../../consts/colors.dart';
import '../../../../../utils/utils.dart';
import '../../../../../widgets/custom_snackbar.dart';
import '../../data/add_parents_repository.dart';
import '../../model/add_parents_request_model.dart';
import '../../model/add_parents_response_model.dart';

class AddParentsController extends SuperController<bool> {
  AddParentsController({required this.addParentsRepository});

  final IAddParentsRepository addParentsRepository;

  // Global parent form controllers (used by the visible parent form)
  TextEditingController name = TextEditingController();
  TextEditingController mobileNumber = TextEditingController();
  TextEditingController email = TextEditingController();
  RxString phone = "".obs;

  // Global child form controllers (used by the visible child form)
  TextEditingController childName = TextEditingController();
  TextEditingController dateOfBirth = TextEditingController();
  TextEditingController kinship = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyChild = GlobalKey<FormState>();

  RxString selectedGender = AppStrings.boy.obs;

  // List of all parents with their children
  var parents = <ParentForm>[].obs;

  // Current parent index being edited
  var currentParentIndex = 0.obs;

  // Validation states
  var parentNameValid = false.obs;
  var parentEmailValid = false.obs;
  var parentMobileValid = false.obs;
  var childNameValid = false.obs;
  var childDateValid = false.obs;
  var childKinshipValid = false.obs;

  Future<String?> pickDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    return selectedDate != null ? DateFormat('yyyy-MM-dd').format(selectedDate) : null;
  }

  ParentForm? get currentParent {
    if (parents.isEmpty) return null;
    if (currentParentIndex.value < 0 || currentParentIndex.value >= parents.length) return null;
    return parents[currentParentIndex.value];
  }

  bool get canAddAnotherParentWithChild {
    if (parents.isEmpty) {
      return parentNameValid.value &&
          parentEmailValid.value &&
          parentMobileValid.value &&
          childNameValid.value &&
          childDateValid.value &&
          childKinshipValid.value;
    } else {
      final idx = currentParentIndex.value;
      if (idx < 0 || idx >= parents.length) return false;
      return parents[idx].children.isNotEmpty ||
          (parentNameValid.value &&
              parentEmailValid.value &&
              parentMobileValid.value &&
              childNameValid.value &&
              childDateValid.value &&
              childKinshipValid.value);
    }
  }

  // ✅ Add child safely (preserves parent data textually)
  void addChild() {
    if (!(formKeyChild.currentState?.validate() ?? false)) return;

    if (parents.isEmpty) {
      if (!(formKey.currentState?.validate() ?? false)) return;

      final firstParent = ParentForm(
        nameText: name.text,
        emailText: email.text,
        mobileText: mobileNumber.text,
        children: [],
      );
      parents.add(firstParent);
      currentParentIndex.value = 0;
    }

    final idx = currentParentIndex.value;
    if (idx < 0 || idx >= parents.length) return;

    parents[idx].children.add(ChildForm(
          childNameText: childName.text,
          dateOfBirthText: dateOfBirth.text,
          kinshipText: kinship.text,
          selectedGender: selectedGender.value,
        ));

    // Sync text data only (not controllers)
    parents[idx].nameText = name.text;
    parents[idx].emailText = email.text;
    parents[idx].mobileText = mobileNumber.text;

    // Clear child form
    childName.clear();
    dateOfBirth.clear();
    kinship.clear();
    selectedGender.value = AppStrings.boy;

    parents.refresh();
    updateParentValidation();
    updateChildValidation();
    update();
  }

  // ✅ Add new parent safely (stores text instead of controllers)
  void addNewParent() {
    if (!canAddAnotherParentWithChild) return;

    final idx = currentParentIndex.value;
    final bool childFormFilled = childName.text.isNotEmpty && dateOfBirth.text.isNotEmpty && kinship.text.isNotEmpty;

    if (parents.isEmpty && (formKey.currentState?.validate() ?? false) && childFormFilled) {
      final firstParent = ParentForm(
        nameText: name.text,
        emailText: email.text,
        mobileText: mobileNumber.text,
        children: [
          ChildForm(
            childNameText: childName.text,
            dateOfBirthText: dateOfBirth.text,
            kinshipText: kinship.text,
            selectedGender: selectedGender.value,
          )
        ],
      );
      parents.add(firstParent);
      currentParentIndex.value = 0;
    } else if (parents.isNotEmpty && childFormFilled) {
      parents[idx].children.add(ChildForm(
            childNameText: childName.text,
            dateOfBirthText: dateOfBirth.text,
            kinshipText: kinship.text,
            selectedGender: selectedGender.value,
          ));

      parents[idx].nameText = name.text;
      parents[idx].emailText = email.text;
      parents[idx].mobileText = mobileNumber.text;
    } else if (parents.isNotEmpty) {
      parents[idx].nameText = name.text;
      parents[idx].emailText = email.text;
      parents[idx].mobileText = mobileNumber.text;
    }

    // Create a new blank parent form
    parents.add(ParentForm(
      nameText: '',
      emailText: '',
      mobileText: '',
      children: [],
    ));

    currentParentIndex.value = parents.length - 1;

    // Clear visible form
    name.clear();
    email.clear();
    mobileNumber.clear();
    childName.clear();
    dateOfBirth.clear();
    kinship.clear();
    selectedGender.value = AppStrings.boy;

    parents.refresh();
    updateParentValidation();
    updateChildValidation();
    update();
  }

  void switchToParent(int parentIndex) {
    if (parentIndex >= 0 && parentIndex < parents.length) {
      currentParentIndex.value = parentIndex;
      final p = parents[parentIndex];
      name.text = p.nameText;
      email.text = p.emailText;
      mobileNumber.text = p.mobileText;
      childName.clear();
      dateOfBirth.clear();
      kinship.clear();
      selectedGender.value = AppStrings.boy;
      updateParentValidation();
      updateChildValidation();
      update();
    }
  }

  void updateParentValidation() {
    parentNameValid.value = name.text.isNotEmpty;
    parentEmailValid.value = email.text.isNotEmpty && isValidEmail(email.text);
    parentMobileValid.value = mobileNumber.text.isNotEmpty && isValidSaudiNumber(mobileNumber.text);
  }

  void updateChildValidation() {
    childNameValid.value = childName.text.isNotEmpty;
    childDateValid.value = dateOfBirth.text.isNotEmpty;
    childKinshipValid.value = kinship.text.isNotEmpty;
  }

  bool get shouldShowParentForm {
    if (parents.isEmpty) return true;
    final int index = currentParentIndex.value;
    if (index < 0 || index >= parents.length) return true;
    return parents[index].children.isEmpty;
  }

  bool isParentFormFilled() => name.text.isNotEmpty || email.text.isNotEmpty || mobileNumber.text.isNotEmpty;

  bool isChildFormFilled() => childName.text.isNotEmpty || dateOfBirth.text.isNotEmpty || kinship.text.isNotEmpty;

  AddParentsResponseModel? addParentsResponseModel;
  RxBool isSaving = false.obs;

  // ✅ Fixed addParent() - reads text fields instead of controllers
  Future<void> addParent() async {
    try {
      final parentsWithChildren = parents.where((p) => p.children.isNotEmpty).toList();

      if (parentsWithChildren.isEmpty) {
        customSnackBar("Please add at least one parent with a child.", ColorCode.danger600);
        return;
      }

      for (int i = 0; i < parentsWithChildren.length; i++) {
        final p = parentsWithChildren[i];
        final parentName = p.nameText.trim();
        final parentEmail = p.emailText.trim();
        final parentPhone = p.mobileText.trim();

        if (parentName.isEmpty || parentEmail.isEmpty || parentPhone.isEmpty) {
          customSnackBar("Please fill name, email and phone for parent ${i + 1}.", ColorCode.danger600);
          return;
        }

        if (!isValidEmail(parentEmail)) {
          customSnackBar("Please enter a valid email for parent ${i + 1}.", ColorCode.danger600);
          return;
        }
        if (!isValidSaudiNumber(parentPhone)) {
          customSnackBar("Please enter a valid phone for parent ${i + 1}.", ColorCode.danger600);
          return;
        }
      }

      final parentModels = <ParentModel>[];
      for (final parentForm in parentsWithChildren) {
        final childrenModels = parentForm.children.map((childForm) {
          return ChildModel(
            childName: childForm.childNameText.trim(),
            birthdayDate: childForm.dateOfBirthText.trim(),
            parentName: parentForm.nameText.trim(),
            kinship: childForm.kinshipText.trim(),
            gender: childForm.selectedGender == AppStrings.boy ? "boy" : "girl",
          );
        }).toList();

        parentModels.add(ParentModel(
          name: parentForm.nameText.trim(),
          email: parentForm.emailText.trim(),
          phone: "+966${parentForm.mobileText.trim()}",
          children: childrenModels,
        ));
      }

      debugPrint("---- Sending ${parentModels.length} parent(s) to API ----");
      for (var i = 0; i < parentModels.length; i++) {
        final pm = parentModels[i];
        debugPrint("parent[$i].name: ${pm.name}");
        debugPrint("parent[$i].email: ${pm.email}");
        debugPrint("parent[$i].phone: ${pm.phone}");
        debugPrint("parent[$i].childrenCount: ${pm.children?.length ?? 0}");
      }

      final addParentsRequestModel = AddParentsRequestModel(parents: parentModels);
      isSaving.value = true;
      final response = await addParentsRepository.addParent(addParentsRequestModel: addParentsRequestModel);
      isSaving.value = false;

      if (response.statusCode == 200 || response.statusCode == 201) {
        addParentsResponseModel = response.body;
        Get.back();
        customSnackBar(AppStrings.dataSavedSuccessfully, ColorCode.success600);
      } else {
        customSnackBar(AppStrings.dataHasNotBeenUpdatedSuccessfully, ColorCode.danger600);
      }
    } catch (error, stack) {
      isSaving.value = false;
      debugPrint("Add Parent Error: $error");
      debugPrint("StackTrace: $stack");
      customSnackBar(error.toString(), ColorCode.danger600);
    }
  }

  @override
  void onInit() {
    super.onInit();
    updateParentValidation();
    updateChildValidation();
  }

  @override
  void onDetached() {}
  @override
  void onHidden() {}
  @override
  void onInactive() {}
  @override
  void onPaused() {}
  @override
  void onResumed() {}
}

// ✅ Simplified data-holding classes (store text values, not controllers)
class ParentForm {
  String nameText;
  String emailText;
  String mobileText;
  List<ChildForm> children;

  ParentForm({
    required this.nameText,
    required this.emailText,
    required this.mobileText,
    required this.children,
  });
}

class ChildForm {
  String childNameText;
  String dateOfBirthText;
  String kinshipText;
  String selectedGender;

  ChildForm({
    required this.childNameText,
    required this.dateOfBirthText,
    required this.kinshipText,
    required this.selectedGender,
  });
}
