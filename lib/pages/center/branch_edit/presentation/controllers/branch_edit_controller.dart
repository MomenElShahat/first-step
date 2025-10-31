import 'package:first_step/pages/center/branch_details/data/branch_details_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../../../../../resources/strings_generated.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

import '../../../../../consts/colors.dart';
import '../../../../../services/auth_service.dart';
import '../../../../../widgets/custom_snackbar.dart';
import '../../../auth/signup/models/cities_model.dart';
import '../../../auth/signup/models/signup_request_model.dart';
import '../../../control_panel/models/branch_model.dart';
import '../../data/branch_edit_repository.dart';

class BranchEditScreenController extends SuperController<dynamic> {
  BranchEditScreenController({required this.branchEditRepository});

  final IBranchEditRepository branchEditRepository;

  TextEditingController arabic = TextEditingController();
  TextEditingController mobileNumber = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController neighborhood = TextEditingController();
  TextEditingController street = TextEditingController();
  TextEditingController fromHour = TextEditingController();
  TextEditingController untilHour = TextEditingController();
  RxString phone = "".obs;

  RxBool isHidden = true.obs;
  RxBool isHiddenConfirm = true.obs;
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  List<Map<String, dynamic>> services = [
    {"key": "Nursing", "type": AppStrings.nursing, "isChecked": false.obs},
    {"key": "Educational", "type": AppStrings.educational, "isChecked": false.obs},
    {"key": "kindergarten", "type": AppStrings.kindergarten, "isChecked": false.obs},
    {"key": "After school", "type": AppStrings.afterSchool, "isChecked": false.obs},
    {"key": "Special needs", "type": AppStrings.specialNeeds, "isChecked": false.obs},
    {"key": "Physical therapy", "type": AppStrings.physicalTherapy, "isChecked": false.obs},
    {"key": "Speech therapy", "type": AppStrings.speechTherapy, "isChecked": false.obs},
    {"key": "Occupational therapy", "type": AppStrings.occupationalTherapy, "isChecked": false.obs},
  ];

  RxString selectedStartDay = AppStrings.sunday.obs;
  RxString selectedEndDay = AppStrings.sunday.obs;

  RxBool isStartDayError = false.obs;
  RxBool isEndDayError = false.obs;

  TimeOfDay? startTime;
  TimeOfDay? endTime;

  BranchModel? branch;

  List<String> daysList = [
    AppStrings.selectADay,
    AppStrings.saturday,
    AppStrings.sunday,
    AppStrings.monday,
    AppStrings.tuesday,
    AppStrings.wednesday,
    AppStrings.thursday,
    AppStrings.friday,
  ];

  String? mapApiDayToDropdown(String? apiDay) {
    for (var day in daysList) {
      if (day.toLowerCase().trim() == apiDay?.toLowerCase().trim()) {
        return day;
      }
    }
    return AppStrings.selectADay;
  }

  final Map<String, String> dayNameMap = {
    AppStrings.saturday: AppStrings.saturday,
    AppStrings.sunday: AppStrings.sunday,
    AppStrings.monday: AppStrings.monday,
    AppStrings.tuesday: AppStrings.tuesday,
    AppStrings.wednesday: AppStrings.wednesday,
    AppStrings.thursday: AppStrings.thursday,
    AppStrings.friday: AppStrings.friday,
  };

  void updateServiceChecksFromApi(List<String> selectedServicesFromApi) {
    print("API selected services: $selectedServicesFromApi");
    for (var service in services) {
      print("Checking service key: ${service["key"]}");
      print("Match found: ${selectedServicesFromApi.contains(service["key"])}");
      service["isChecked"].value = selectedServicesFromApi.contains(service["key"]);
    }
  }

  void updateTypesChecksFromApi(List<String> selectedTypesFromApi) {
    print("API selected services: $selectedTypesFromApi");
    for (var type in centerTypes) {
      print("Checking service key: ${type["key"]}");
      print("Match found: ${selectedTypesFromApi.contains(type["key"])}");
      type["isChecked"].value = selectedTypesFromApi.contains(type["key"]);
    }
  }

  void updateAgesChecksFromApi(List<String> selectedAgesFromApi) {
    print("API selected services: $selectedAgesFromApi");
    for (var age in ages) {
      print("Checking service key: ${age["key"]}");
      print("Match found: ${selectedAgesFromApi.contains(age["key"])}");
      age["isChecked"].value = selectedAgesFromApi.contains(age["key"]);
    }
  }

  void updateCommChecksFromApi(List<String> selectedCommFromApi) {
    print("API selected services: $selectedCommFromApi");
    for (var comm in commWays) {
      print("Checking service key: ${comm["key"]}");
      print("Match found: ${selectedCommFromApi.contains(comm["key"])}");
      comm["isChecked"].value = selectedCommFromApi.contains(comm["key"]);
    }
  }

  List<String> getSelectedServices(List<Map<String, dynamic>> services) {
    return services.where((element) => (element['isChecked'] as RxBool).value).map((element) => element['key'].toString()).toList();
  }

  TimeOfDay? parseTimeOfDay(String timeString) {
    try {
      final parts = timeString.split(':');
      if (parts.length >= 2) {
        final hour = int.parse(parts[0]);
        final minute = int.parse(parts[1]);
        return TimeOfDay(hour: hour, minute: minute);
      }
    } catch (_) {}
    return null;
  }

  bool isPlaceholderPassword = true;
  // RxString selectedCity = "".obs;
  getBranchDetails(String branchId) async {
    change(false, status: RxStatus.loading());
    branchEditRepository.getBranchDetails(branchId).then(
      (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          branch = null;
          branch = value.body;
          arabic.text = branch?.name ?? "";
          mobileNumber.text = branch?.phone?.replaceAll("966", "") ?? "";
          email.text = branch?.emailAdminBranch ?? "";
          password.text = "********";
          confirmPassword.text = "********";
          selectedCity = branch?.city;
          selectedValue.value = branch?.emergencyContact == true ? AppStrings.yes : AppStrings.no;
          selectedValue2.value = branch?.providesFood == true ? AppStrings.yes : AppStrings.no;
          neighborhood.text = branch?.neighborhood ?? "";
          fromHour.text = branch?.workHoursFrom ?? "";
          untilHour.text = branch?.workHoursTo ?? "";
          locationLink.text = branch?.location ?? "";
          service.text = branch?.additionalService ?? "";
          selectedStartDay.value = dayNameMap[branch?.workDaysFrom] ?? AppStrings.selectADay;
          selectedEndDay.value = dayNameMap[branch?.workDaysTo] ?? AppStrings.selectADay;
          updateServiceChecksFromApi(branch?.services ?? []);
          updateTypesChecksFromApi(branch?.nurseryType ?? []);
          updateAgesChecksFromApi(branch?.acceptedAges ?? []);
          updateCommChecksFromApi(branch?.communicationMethods ?? []);
          startTime = parseTimeOfDay(branch?.workHoursFrom ?? "${DateTime.now()}");
          endTime = parseTimeOfDay(branch?.workHoursTo ?? "${DateTime.now()}");
          practiceLicence.text = branch?.licensePath?.split("/").last ?? "";
          commercialRegister.text = branch?.commercialRecordPath?.split("/").last ?? "";
          startTimeFirstPeriodController.text = branch?.timeOfFirstPeriod ?? "";
          startTimeSecondPeriodController.text = branch?.timeOfSecondPeriod ?? "";
          firstPeriodMeals.value = branch?.firstMeals ?? [];
          secondPeriodMeals.value = branch?.secondMeals ?? [];
          isPlaceholderPassword = true;
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

  void onPasswordChanged(String val) {
    // Once user starts typing, we know it’s real input
    if (isPlaceholderPassword) {
      password.clear();
      isPlaceholderPassword = false;
      update();
    }
    password.text = val;
    update();
  }

  void onConfirmPasswordChanged(String val) {
    if (isPlaceholderPassword) {
      confirmPassword.clear();
      isPlaceholderPassword = false;
      update();
    }
    confirmPassword.text = val;
    update();
  }

  TextEditingController locationLink = TextEditingController();
  TextEditingController service = TextEditingController();
  TextEditingController added = TextEditingController();
  TextEditingController startTimeFirstPeriodController = TextEditingController();
  TextEditingController startTimeSecondPeriodController = TextEditingController();
  TextEditingController firstMealName = TextEditingController();
  TextEditingController firstMealComponents = TextEditingController();
  TextEditingController firstMealDrinks = TextEditingController();
  TextEditingController secondMealName = TextEditingController();
  TextEditingController secondMealComponents = TextEditingController();
  TextEditingController secondMealDrinks = TextEditingController();
  TextEditingController practiceLicence = TextEditingController();
  TextEditingController commercialRegister = TextEditingController();
  TextEditingController finalAdd = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<FormState> formKey2 = GlobalKey<FormState>();
  GlobalKey<FormState> formKey3 = GlobalKey<FormState>();
  GlobalKey<FormState> formKey4 = GlobalKey<FormState>();

  City? selectedCity;

  RxBool isCityError = false.obs;

  List<Map<String, dynamic>> centerTypes = [
    {"key": "nursing", "type": AppStrings.nursing, "isChecked": false.obs},
    {"key": "educational", "type": AppStrings.educational, "isChecked": false.obs},
    {"key": "support and rehabilitation", "type": AppStrings.supportAndRehabilitation, "isChecked": false.obs},
  ];

  List<Map<String, dynamic>> commWays = [
    {"key": "phone", "type": AppStrings.voiceCommunication, "isChecked": false.obs},
    {"key": "sms", "type": AppStrings.textCommunication, "isChecked": false.obs},
    {"key": "video", "type": AppStrings.visualCommunication, "isChecked": false.obs},
  ];

  List<Map<String, dynamic>> ages = [
    {"key": "0-3", "type": AppStrings.from0To3Years, "isChecked": false.obs},
    {"key": "3-6", "type": AppStrings.from3To6Years, "isChecked": false.obs},
    {"key": "disabled", "type": AppStrings.childrenWithSpecialNeeds, "isChecked": false.obs},
  ];

  List<String> getSelectedAges(List<Map<String, dynamic>> ages) {
    return ages
        .where((element) => (element['isChecked'] as RxBool).value)
        .map((element) => element['type'].toString() == AppStrings.from0To3Years
            ? "0-3"
            : element['type'].toString() == AppStrings.from3To6Years
                ? "3-6"
                : "disabled")
        .toList();
  }

  List<String> getSelectedTypes(List<Map<String, dynamic>> centerTypes) {
    return centerTypes
        .where((element) => (element['isChecked'] as RxBool).value)
        .map((element) => element['type'].toString() == AppStrings.nursing
            ? "nursing"
            : element['type'].toString() == AppStrings.educational
                ? "educational"
                : "support and rehabilitation")
        .toList();
  }

  List<String> getSelectedCommWays(List<Map<String, dynamic>> commWays) {
    return commWays
        .where((element) => (element['isChecked'] as RxBool).value)
        .map((element) => element['type'].toString() == AppStrings.voiceCommunication
            ? "phone"
            : element['type'].toString() == AppStrings.textCommunication
                ? "sms"
                : "video")
        .toList();
  }

  String formatTime(TimeOfDay time) {
    // final now = DateTime.now();
    // final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}:00'; // OR 'hh:mm a' for AM/PM
  }

  // List<Map<String,dynamic>> isCheckedCenterType = List.generate(3, (index) => false.obs);
  // List<RxBool> isCheckedComuncationWays =
  //     List.generate(2, (index) => false.obs);

  // List<RxBool> isCheckedAvailableServices =
  //     List.generate(6, (index) => false.obs);
  // List<RxBool> isCheckedAges = List.generate(3, (index) => false.obs);
  RxString selectedValue = ''.obs;
  RxString selectedValue2 = ''.obs;
  File? practiceLicenceFile;
  File? commercialRegisterFile;
  File? logo;
  TimeOfDay? startTimeFirstPeriod;
  TimeOfDay? startTimeSecondPeriod;

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    final XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      logo = File(pickedImage.path);
      update();
    }
  }

  Future<File?> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      return File(result.files.single.path!);
    }
    return null; // User canceled the picker
  }

  Future<TimeOfDay?> pickTime(BuildContext context) async {
    return await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
  }

  RxList<FirstMeals> firstPeriodMeals = <FirstMeals>[FirstMeals(mealName: "", components: "", juice: "")].obs;

  RxList<FirstMeals> secondPeriodMeals = <FirstMeals>[FirstMeals(mealName: "", components: "", juice: "")].obs;
  RxBool isSaving = false.obs;

  onSaveEditsClicked({required BuildContext context}) async {
    isSaving.value = true;
    SignupRequestModel signupRequestModel = SignupRequestModel(
      timeOfFirstPeriod: formatTime(startTimeFirstPeriod ?? TimeOfDay.now()),
      timeOfSecondPeriod: formatTime(startTimeSecondPeriod ?? TimeOfDay.now()),
      email: email.text == branch?.emailAdminBranch ? null : email.text,
      password: password.text.contains("*") ? null : password.text,
      nurseryName: arabic.text,
      name: arabic.text,
      phone: mobileNumber.text,
      cityID: (selectedCity?.id ?? 0).toString(),
      location: locationLink.text,
      nurseryType: getSelectedTypes(centerTypes),
      services: getSelectedServices(services),
      firstMeals: selectedValue2.value == AppStrings.no ? null : firstPeriodMeals,
      secondMeals: selectedValue2.value == AppStrings.no ? null : secondPeriodMeals,
      neighborhood: neighborhood.text,
      workDaysFrom: selectedStartDay.value,
      workDaysTo: selectedEndDay.value,
      workHoursFrom: formatTime(startTime!),
      workHoursTo: formatTime(endTime!),
      additionalService: service.text,
      providesFood: selectedValue2.value == AppStrings.yes ? true : false,
      specialNeeds: selectedValue.value == AppStrings.yes ? true : false,
      communicationMethods: getSelectedCommWays(commWays),
      acceptedAges: getSelectedAges(ages),
      emergencyContact: false,
    );
    branchEditRepository
        .editBranch(
            branchModel: signupRequestModel,
            branchId: branchId ?? "",
            logo: logo,
            licenseFile: practiceLicenceFile,
            commercialRecordFile: commercialRegisterFile)
        .then(
      (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          customSnackBar(AppStrings.dataSavedSuccessfully, ColorCode.success600);
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

  List<City> cities = [];

  getCities() async {
    change(false, status: RxStatus.loading());
    branchEditRepository.getCities().then(
      (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          cities = value.body?.data ?? [];
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

  String? branchId;

  @override
  void onInit() async {
    change(true, status: RxStatus.success());
    var args = Get.arguments;
    branchId = args;
    await getCities();
    await getBranchDetails(branchId!);
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
