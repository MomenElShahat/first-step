import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../../consts/colors.dart';
import '../../../../../../resources/strings_generated.dart';
import '../../../../../../routes/app_pages.dart';
import '../../../../../../widgets/custom_snackbar.dart';
import '../../../signup_parent/models/signup_parent_request_model.dart'
    as parent;
import '../../../signup_parent/models/signup_parent_request_model.dart';
import '../../data/add_child_repository.dart';

class AddChildController extends SuperController<dynamic> {
  AddChildController({required this.addChildRepository});

  final IAddChildRepository addChildRepository;

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

  var allergySections = <parent.AllergyModel>[
    parent.AllergyModel(),
  ].obs; // List of allergy sections

  void addAllergySection() {
    allergySections.add(parent.AllergyModel()); // Add new section
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

  onRegisterParentClicked(BuildContext context) async {
    change(false, status: RxStatus.loading());
    parent.SignupParentRequestModel signupParentRequestModel =
        parent.SignupParentRequestModel(
            name: name ?? "",
            email: email ?? "",
            password: password ?? "",
            address: "jnjk",
            nationalNumber: nationalNumber ?? "",
            phone: "966${mobileNumber ?? ""}",
            children: [
          parent.ChildModel(
            kinship: kinship ?? "",
            childName: childName.text,
            birthdayDate: dateOfBirth.text,
            gender: selectedGender.value == AppStrings.boy ? "boy" : "girl",
            disease: selectedValue.value == AppStrings.yes ? true : false,
            description3Words: describeYourChildIn3Words.text.isEmpty
                ? null
                : describeYourChildIn3Words.text,
            thingsChildLikes: thingsYourChildLikes.text.isEmpty
                ? null
                : thingsYourChildLikes.text,
            notes: doYouHaveAnyCommentsOrRemarks.text.isEmpty
                ? null
                : doYouHaveAnyCommentsOrRemarks.text,
            allergy: selectedValue2.value == AppStrings.yes ? true : false,
            parentName: fatherName.text,
            motherName: motherName.text,
            recommendations:
                doYouHaveAnyRecommendationsForYourChild.text.isEmpty
                    ? null
                    : doYouHaveAnyRecommendationsForYourChild.text,
            authorizedPersons: authorizedPersons
                .map(
                  (model) => AuthorizedPersonModel(
                    name: model.name,
                    cin: model.cin,
                  ),
                )
                .toList(),
            allergies: selectedValue2.value == AppStrings.yes
                ? allergySections
                    .map(
                      (model) => parent.AllergyModel(
                        name: model.name,
                        allergyCauses: model.allergyCauses,
                        allergyEmergency: model.allergyEmergency,
                      ),
                    )
                    .toList()
                : null,
            diseaseDetails: selectedValue.value == AppStrings.yes
                ? chronicDiseases
                    .map(
                      (model) => parent.DiseaseDetailModel(
                        diseaseName: model.diseaseName,
                        emergency: model.emergency,
                        medicament: model.medicament,
                      ),
                    )
                    .toList()
                : null,
          ),
        ]);
    addChildRepository.signup(signupParentRequestModel).then(
      (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          customSnackBar(value.body?.message ?? "", ColorCode.success600);
          Get.offNamed(Routes.LOGIN);
        } else {
          customSnackBar(value.body?.message ?? "", ColorCode.danger600);
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

  String? name;
  String? kinship;
  String? mobileNumber;
  String? email;
  String? password;
  String? nationalNumber;

  @override
  void onInit() async {
    change(true, status: RxStatus.success());
    var arguments = Get.arguments;
    name = arguments["name"];
    kinship = arguments["kinship"];
    mobileNumber = arguments["mobileNumber"];
    email = arguments["email"];
    password = arguments["password"];
    nationalNumber = arguments["national_number"];
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
    //       Get.offNamed(Routes.HOME);
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

  // void disposeAllergySections() {
  //   for (var allergy in allergySections) {
  //     allergy.typeOfAllergy.dispose();
  //     allergy.allergensOrFoods.dispose();
  //     allergy.allergicReactionSteps.dispose();
  //   }
  // }
  @override
  void dispose() {
    // disposeAllergySections();
    super.dispose();
  }
}
