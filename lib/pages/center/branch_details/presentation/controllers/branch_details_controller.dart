import 'package:first_step/pages/center/branch_details/data/branch_details_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../../resources/strings_generated.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

import '../../../../../consts/colors.dart';
import '../../../../../services/auth_service.dart';
import '../../../../../widgets/custom_snackbar.dart';
import '../../../auth/signup/models/cities_model.dart';
import '../../../control_panel/models/branch_model.dart';

class BranchDetailsScreenController extends SuperController<dynamic> {
  BranchDetailsScreenController({required this.branchDetailsRepository});

  final IBranchDetailsRepository branchDetailsRepository;

  TextEditingController arabic = TextEditingController();

  // TextEditingController nationalID = TextEditingController();
  TextEditingController mobileNumber = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController neighborhood = TextEditingController();
  TextEditingController street = TextEditingController();
  TextEditingController fromHour = TextEditingController();
  TextEditingController untilHour = TextEditingController();

  List<Map<String, dynamic>> services = [
    {"key": "Nursing", "type": AppStrings.nursing, "isChecked": false.obs},
    {
      "key": "Educational",
      "type": AppStrings.educational,
      "isChecked": false.obs
    },
    {
      "key": "kindergarten",
      "type": AppStrings.kindergarten,
      "isChecked": false.obs
    },
    {
      "key": "After school",
      "type": AppStrings.afterSchool,
      "isChecked": false.obs
    },
    {
      "key": "Special needs",
      "type": AppStrings.specialNeeds,
      "isChecked": false.obs
    },
    {
      "key": "Physical therapy",
      "type": AppStrings.physicalTherapy,
      "isChecked": false.obs
    },
    {
      "key": "Speech therapy",
      "type": AppStrings.speechTherapy,
      "isChecked": false.obs
    },
    {
      "key": "Occupational therapy",
      "type": AppStrings.occupationalTherapy,
      "isChecked": false.obs
    },
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
      service["isChecked"].value =
          selectedServicesFromApi.contains(service["key"]);
    }
  }

  Rxn<City> selectedCity = Rxn<City>();
  RxBool isCityError = false.obs;

  getBranchDetails(String branchId) async {
    change(false, status: RxStatus.loading());
    branchDetailsRepository.getBranchDetails(branchId).then(
      (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          branch = null;
          branch = value.body;
          arabic.text = branch?.name ?? "";
          mobileNumber.text = branch?.phone?.replaceAll("966", "") ?? "";
          // email.text = branch?.email ?? "";
          // city.text = AuthService.to.language == "ar"
          //     ? branch?.city?.name?.ar ?? ""
          //     : branch?.city?.name?.en ?? "";
          selectedCity.value = branch?.city;
          neighborhood.text = branch?.neighborhood ?? "";
          // street.text = branch?.street ?? "";
          fromHour.text = branch?.workHoursFrom ?? "";
          untilHour.text = branch?.workHoursTo ?? "";
          selectedStartDay.value =
              dayNameMap[branch?.workDaysFrom] ?? AppStrings.selectADay;
          selectedEndDay.value =
              dayNameMap[branch?.workDaysTo] ?? AppStrings.selectADay;
          updateServiceChecksFromApi(branch?.services ?? []);
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

  Future<TimeOfDay?> pickTime(BuildContext context) async {
    return await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
  }

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

  List<City> cities = [];

  getCities() async {
    change(false, status: RxStatus.loading());
    branchDetailsRepository.getCities().then(
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
