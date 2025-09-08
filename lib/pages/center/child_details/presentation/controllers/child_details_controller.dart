import 'package:first_step/pages/parent/auth/signup_parent/models/signup_parent_request_model.dart' as chronic;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../../resources/strings_generated.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

import '../../../../../consts/colors.dart';
import '../../../../../widgets/custom_snackbar.dart';
import '../../../control_panel/models/child_model.dart';
import '../../data/child_details_repository.dart';

class ChildDetailsScreenController extends SuperController<dynamic> {
  ChildDetailsScreenController({required this.childDetailsRepository});

  final IChildDetailsRepository childDetailsRepository;

  TextEditingController childName = TextEditingController();
  TextEditingController dateOfBirth = TextEditingController();
  TextEditingController fatherName = TextEditingController();
  TextEditingController motherName = TextEditingController();
  TextEditingController diseaseName = TextEditingController();
  TextEditingController treatmentName = TextEditingController();
  TextEditingController allergicReaction = TextEditingController();
  TextEditingController typeOfAllergy = TextEditingController();
  TextEditingController whatAreTheAllergensOrFoods = TextEditingController();
  TextEditingController whatShouldBeDoneInCaseOfAnAllergicReactionAllergy = TextEditingController();
  TextEditingController describeYourChildIn3Words = TextEditingController();
  TextEditingController thingsYourChildLikes = TextEditingController();
  TextEditingController doYouHaveAnyRecommendationsForYourChild = TextEditingController();
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

  GlobalKey<FormState> formKey2 = GlobalKey<FormState>();
  GlobalKey<FormState> formKey3 = GlobalKey<FormState>();
  GlobalKey<FormState> formKey5 = GlobalKey<FormState>();

  ChildModel? childModel;

  getChildDetails(String childId) async {
    change(false, status: RxStatus.loading());
    childDetailsRepository.getChildDetails(childId).then(
      (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          childModel = null;
          childModel = value.body;
          childName.text = childModel?.childName ?? AppStrings.notFound;
          dateOfBirth.text = childModel?.birthdayDate ?? AppStrings.notFound;
          fatherName.text = childModel?.parentName ?? AppStrings.notFound;
          motherName.text = childModel?.motherName ?? AppStrings.notFound;
          // diseaseName.text = childModel?.diseaseName ?? AppStrings.notFound;
          // treatmentName.text = childModel?.medicamentDisease ?? AppStrings.notFound;
          // allergicReaction.text = AppStrings.notFound;
          chronicDiseases.value = childModel?.diseaseDetails ?? [];
          allergySections.value = childModel?.allergies ?? [];
          authorizedPersons.value = childModel?.authorizedPeople ?? [];
          // whatAreTheAllergensOrFoods.text = AppStrings.notFound;
          // typeOfAllergy.text = AppStrings.notFound;
          // nameOfAuthorizedPerson.text = AppStrings.notFound;
          // authorizedPersonIdNumber.text = AppStrings.notFound;
          // doYouHaveAnyCommentsOrRemarks.text = AppStrings.notFound;
          // whatShouldBeDoneInCaseOfAnAllergicReactionAllergy.text = AppStrings.notFound;
          describeYourChildIn3Words.text = childModel?.description3Words ?? AppStrings.notFound;
          thingsYourChildLikes.text = childModel?.thingsChildLikes ?? AppStrings.notFound;
          doYouHaveAnyRecommendationsForYourChild.text = childModel?.recommendations ?? AppStrings.notFound;
          // whatAreTheAllergensOrFoods.text = childModel?.allergies?.first.allergyCauses?.first ?? AppStrings.notFound;
          // typeOfAllergy.text = childModel?.allergies?.first.name ?? AppStrings.notFound;
          // nameOfAuthorizedPerson.text = childModel?.authorizedPeople?.first.name ?? AppStrings.notFound;
          // authorizedPersonIdNumber.text = childModel?.authorizedPeople?.first.cin ?? AppStrings.notFound;
          doYouHaveAnyCommentsOrRemarks.text = childModel?.notes ?? AppStrings.notFound;
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

  String? childId;
  @override
  void onInit() async {
    var args = Get.arguments;
    childId = args;
    await getChildDetails(childId!);
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
    //       Get.offNamed(Routes.ChildDetails);
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
