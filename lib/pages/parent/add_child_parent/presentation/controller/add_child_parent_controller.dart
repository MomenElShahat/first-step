import 'package:first_step/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../consts/colors.dart';
import '../../../../../resources/strings_generated.dart';
import '../../../../../widgets/custom_snackbar.dart';
import '../../../auth/add_child/model/allergy_section.dart' as parent;
import '../../../auth/signup_parent/models/signup_parent_request_model.dart';
import '../../data/add_child_parent_repository.dart';
import '../../model/add_child_request_model.dart';

class AddChildParentController extends SuperController<bool> {
  AddChildParentController({required this.addChildParentRepository});

  final IAddChildParentRepository addChildParentRepository;

  RxInt index = 1.obs;
  TextEditingController childName = TextEditingController();
  TextEditingController dateOfBirth = TextEditingController();
  TextEditingController fatherName = TextEditingController();
  TextEditingController motherName = TextEditingController();
  TextEditingController chronicDiseaseName = TextEditingController();
  TextEditingController nameOfTreatment = TextEditingController();
  TextEditingController whatShouldBeDoneInCaseOfAnAllergicReaction =
      TextEditingController();
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

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<FormState> formKey2 = GlobalKey<FormState>();
  GlobalKey<FormState> formKey3 = GlobalKey<FormState>();
  GlobalKey<FormState> formKey4 = GlobalKey<FormState>();
  GlobalKey<FormState> formKey5 = GlobalKey<FormState>();

  RxString selectedGender = AppStrings.boy.obs;

  List<RxBool> isCheckedCenterType = List.generate(3, (index) => false.obs);

  List<RxBool> isCheckedComuncationWays =
      List.generate(2, (index) => false.obs);
  List<RxBool> isCheckedAvailableServices =
      List.generate(6, (index) => false.obs);
  List<RxBool> isCheckedAges = List.generate(3, (index) => false.obs);
  RxString selectedValue = ''.obs;
  RxString selectedValue2 = ''.obs;

  var chronicDiseases = <DiseaseDetailModel>[
    DiseaseDetailModel(),
  ].obs;

  void addChronicDisease() {
    chronicDiseases.add(DiseaseDetailModel()); // Add new empty entry
  }

  void removeChronicDisease(int index) {
    chronicDiseases.removeAt(index); // Remove entry at index
  }

  var allergySections = <AllergyModel>[
    AllergyModel(),
  ].obs;

  void addAllergySection() {
    allergySections.add(AllergyModel());
  }

  void removeAllergySection(int index) {
    allergySections.removeAt(index); // Remove specific section
  }

  var authorizedPersons = <AuthorizedPersonModel>[
    AuthorizedPersonModel(),
  ].obs; // List of allergy sections

  void addAuthorizedPersons() {
    authorizedPersons.add(AuthorizedPersonModel()); // Add new section
  }

  void removeAuthorizedPersons(int index) {
    authorizedPersons.removeAt(index); // Remove specific section
  }

  Future<String?> pickDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000), // Set a minimum date
      lastDate: DateTime.now(), // Set a maximum date
    );

    if (selectedDate != null) {
      return DateFormat('yyyy-MM-dd').format(selectedDate);
    }
    return null; // If no date is selected
  }

  onAddChildClicked(BuildContext context) async {
    change(false, status: RxStatus.loading());
    AddChildRequestModel addChildRequestModel = AddChildRequestModel(
      childName: childName.text,
      birthdayDate: dateOfBirth.text,
      gender: selectedGender.value == AppStrings.boy ? "boy" : "girl",
      disease: selectedValue.value == AppStrings.yes ? true : false,
      description3Words: describeYourChildIn3Words.text,
      thingsChildLikes: thingsYourChildLikes.text,
      notes: doYouHaveAnyCommentsOrRemarks.text,
      allergy: selectedValue2.value == AppStrings.yes ? true : false,
      parentName: fatherName.text,
      motherName: motherName.text,
      recommendations: doYouHaveAnyRecommendationsForYourChild.text,
      authorizedPeople: authorizedPersons
          .map(
            (model) => AuthorizedPersonModel(
              name: model.name,
              cin: model.cin,
            ),
          )
          .toList(),
      allergies: allergySections
          .map(
            (model) => AllergyModel(
              name: model.name,
              allergyCauses: model.allergyCauses,
              allergyEmergency: model.allergyEmergency,
            ),
          )
          .toList(),
      diseaseDetails: chronicDiseases
          .map(
            (model) => DiseaseDetailModel(
              diseaseName: model.diseaseName,
              emergency: model.emergency,
              medicament: model.medicament,
            ),
          )
          .toList(),
    );
    addChildParentRepository.addChild(addChildRequestModel).then(
      (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          customSnackBar(
              AppStrings.childAddedSuccessfully, ColorCode.success600);
          Get.offAllNamed(Routes.BOTTOM_NAVIGATION);
        } else {
          customSnackBar(
              AppStrings
                  .thereWasAProblemDuringAddingTheChildPleaseTryAgainLater,
              ColorCode.danger600);
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

  @override
  void onInit() {
    change(true, status: RxStatus.success());
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
