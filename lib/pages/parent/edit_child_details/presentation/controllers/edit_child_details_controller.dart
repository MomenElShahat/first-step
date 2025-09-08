import 'package:first_step/pages/parent/auth/signup_parent/models/signup_parent_request_model.dart'
    as chronic;
import 'package:first_step/pages/parent/edit_child_details/models/edit_child_request_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../../resources/strings_generated.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

import '../../../../../consts/colors.dart';
import '../../../../../widgets/custom_snackbar.dart';
import '../../../../center/control_panel/models/child_model.dart' as child;
import '../../../add_child_parent/model/add_child_request_model.dart';
import '../../data/edit_child_details_repository.dart';

class EditChildDetailsScreenController extends SuperController<dynamic> {
  EditChildDetailsScreenController({required this.editChildDetailsRepository});

  final IEditChildDetailsRepository editChildDetailsRepository;

  TextEditingController childName = TextEditingController();
  TextEditingController dateOfBirth = TextEditingController();
  TextEditingController fatherName = TextEditingController();
  TextEditingController motherName = TextEditingController();
  TextEditingController diseaseName = TextEditingController();
  TextEditingController treatmentName = TextEditingController();
  TextEditingController allergicReaction = TextEditingController();
  TextEditingController typeOfAllergy = TextEditingController();
  TextEditingController whatAreTheAllergensOrFoods = TextEditingController();
  TextEditingController whatShouldBeDoneInCaseOfAnAllergicReactionAllergy =
      TextEditingController();
  TextEditingController describeYourChildIn3Words = TextEditingController();
  TextEditingController thingsYourChildLikes = TextEditingController();
  TextEditingController doYouHaveAnyRecommendationsForYourChild =
      TextEditingController();
  TextEditingController nameOfAuthorizedPerson = TextEditingController();
  TextEditingController authorizedPersonIdNumber = TextEditingController();
  TextEditingController doYouHaveAnyCommentsOrRemarks = TextEditingController();

  RxString selectedGender = AppStrings.boy.obs;

  Future<String?> pickDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000), // Set a minimum date
      lastDate: DateTime(2100), // Set a maximum date
    );

    if (selectedDate != null) {
      return DateFormat('yyyy-MM-dd').format(selectedDate);
    }
    return null; // If no date is selected
  }

  child.ChildModel? childModel;
  GlobalKey<FormState> formKey2 = GlobalKey<FormState>();
  GlobalKey<FormState> formKey3 = GlobalKey<FormState>();
  GlobalKey<FormState> formKey5 = GlobalKey<FormState>();

  var chronicDiseases = <chronic.DiseaseDetailModel>[
    chronic.DiseaseDetailModel(),
  ].obs;

  void removeChronicDisease(int index) {
    chronicDiseases.removeAt(index); // Remove entry at index
  }

  var allergySections = <chronic.AllergyModel>[
    chronic.AllergyModel(),
  ].obs;

  void removeAllergySection(int index) {
    allergySections.removeAt(index); // Remove specific section
  }

  var authorizedPersons = <chronic.AuthorizedPersonModel>[
    chronic.AuthorizedPersonModel(),
  ].obs; // List of allergy sections

  void removeAuthorizedPersons(int index) {
    authorizedPersons.removeAt(index); // Remove specific section
  }

  getEditChildDetails(String childId) async {
    change(false, status: RxStatus.loading());
    editChildDetailsRepository.getChildDetails(childId).then(
      (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          childModel = null;
          childModel = value.body;
          childName.text = childModel?.childName ?? AppStrings.notFound;
          dateOfBirth.text = childModel?.birthdayDate ?? AppStrings.notFound;
          fatherName.text = childModel?.parentName ?? AppStrings.notFound;
          motherName.text = childModel?.motherName ?? AppStrings.notFound;
          describeYourChildIn3Words.text =
              childModel?.description3Words ?? AppStrings.notFound;
          thingsYourChildLikes.text =
              childModel?.thingsChildLikes ?? AppStrings.notFound;
          doYouHaveAnyRecommendationsForYourChild.text =
              childModel?.recommendations ?? AppStrings.notFound;
          chronicDiseases.value = childModel?.diseaseDetails ?? [];
          allergySections.value = childModel?.allergies ?? [];
          authorizedPersons.value = childModel?.authorizedPeople ?? [];
          doYouHaveAnyCommentsOrRemarks.text =
              childModel?.notes ?? AppStrings.notFound;
          selectedGender.value = childModel?.gender ?? AppStrings.notFound;
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

  void addAuthorizedPersons() {
    authorizedPersons.add(chronic.AuthorizedPersonModel()); // Add new section
  }

  void addAllergySection() {
    allergySections.add(chronic.AllergyModel());
  }

  void addChronicDisease() {
    chronicDiseases.add(chronic.DiseaseDetailModel()); // Add new empty entry
  }

  RxBool isSaving = false.obs;

  onSaveEditsClicked({required BuildContext context}) async {
    isSaving.value = true;
    AddChildRequestModel addChildRequestModel = AddChildRequestModel(
      description3Words: describeYourChildIn3Words.text,
      thingsChildLikes: thingsYourChildLikes.text,
      notes: doYouHaveAnyCommentsOrRemarks.text,
      childName: childName.text,
      birthdayDate: dateOfBirth.text,
      parentName: fatherName.text,
      motherName: motherName.text,
      authorizedPeople: authorizedPersons
          .map(
            (model) => chronic.AuthorizedPersonModel(
              name: model.name,
              cin: model.cin,
            ),
          )
          .toList(),
      allergies: allergySections
          .map(
            (model) => chronic.AllergyModel(
              name: model.name,
              allergyCauses: model.allergyCauses,
              allergyEmergency: model.allergyEmergency,
            ),
          )
          .toList(),
      diseaseDetails: chronicDiseases
          .map(
            (model) => chronic.DiseaseDetailModel(
              diseaseName: model.diseaseName,
              emergency: model.emergency,
              medicament: model.medicament,
            ),
          )
          .toList(),
      gender: selectedGender.value,
      recommendations: doYouHaveAnyRecommendationsForYourChild.text.isNotEmpty
          ? doYouHaveAnyRecommendationsForYourChild.text
          : doYouHaveAnyCommentsOrRemarks.text,
    );
    editChildDetailsRepository
        .editChild(
            addChildRequestModel: addChildRequestModel, childId: childId ?? "")
        .then(
      (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          customSnackBar(
              AppStrings.dataUpdatedSuccessfully, ColorCode.success600);
        } else {
          customSnackBar(AppStrings.dataHasNotBeenUpdatedSuccessfully,
              ColorCode.danger600);
        }
        isSaving.value = false;
      },
    ).onError((error, stackTrace) {
      print("Signup error: $error");
      print("StackTrace: $stackTrace");
      customSnackBar(error.toString(), ColorCode.danger600);
      isSaving.value = false;
    });
  }

  String? childId;

  @override
  void onInit() async {
    var args = Get.arguments;
    childId = args;
    await getEditChildDetails(childId!);
    super.onInit();
    // Future.delayed(const Duration(seconds: 3)).then((value) {
    //   final isLoggedIn = AuthService.to.isLoggedIn.value;
    //   final isSelectedLanguage = AuthService.to.isSelectedLanguage.value;
    //   AuthService.to.selectLanguage(AuthService.to.language ?? 'en');
    //
    //   if (AuthService.to.isFirstTime) {
    //     Get.offNamed(Routes.BOARD);
    //   } else {
    //     if (isLoggedIn) {
    //       Get.offNamed(Routes.EditChildDetails);
    //     } else {
    //       Get.offNamed(Routes.LOGIN);
    //     }
    //   }
    // });
  }

  @override
  void onDetached() {
    // TODO: implement onDetached
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

  @override
  void onHidden() {
    // TODO: implement onHidden
  }
}
