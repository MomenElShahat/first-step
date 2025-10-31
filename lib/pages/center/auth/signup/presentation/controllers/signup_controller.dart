import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../../../../../consts/colors.dart';
import '../../../../../../resources/strings_generated.dart';
import '../../../../../../routes/app_pages.dart';
import '../../../../../../services/auth_service.dart';
import '../../../../../../widgets/custom_snackbar.dart';
import '../../../../../auth/login/models/login_request.dart';
import '../../../../control_panel/models/branch_model.dart';
import '../../data/signup_repository.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import '../../models/cities_model.dart';
import '../../models/signup_request_model.dart';
import '../../models/signup_response_model.dart';

class SignupController extends SuperController<dynamic> {
  SignupController({required this.signupRepository});

  final ISignupRepository signupRepository;
  RxString phone = "".obs;

  RxInt index = 1.obs;
  TextEditingController name = TextEditingController();
  TextEditingController nurseryName = TextEditingController();
  // TextEditingController english = TextEditingController();
  TextEditingController mobileNumber = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController neighborhood = TextEditingController();
  // TextEditingController street = TextEditingController();
  TextEditingController locationLink = TextEditingController();
  // TextEditingController branchNames = TextEditingController();
  // TextEditingController service = TextEditingController();
  // TextEditingController added = TextEditingController();
  // TextEditingController fromHour = TextEditingController();
  // TextEditingController untilHour = TextEditingController();
  // TextEditingController startTimeFirstPeriodController =
  //     TextEditingController();
  // TextEditingController startTimeSecondPeriodController =
  //     TextEditingController();
  // TextEditingController firstMealName = TextEditingController();
  // TextEditingController firstMealComponents = TextEditingController();
  // TextEditingController firstMealDrinks = TextEditingController();
  // TextEditingController secondMealName = TextEditingController();
  // TextEditingController secondMealComponents = TextEditingController();
  // TextEditingController secondMealDrinks = TextEditingController();
  TextEditingController practiceLicence = TextEditingController();
  TextEditingController commercialRegister = TextEditingController();
  TextEditingController notes = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  RxBool isHidden = true.obs;
  RxBool isHiddenConfirm = true.obs;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<FormState> formKey2 = GlobalKey<FormState>();
  GlobalKey<FormState> formKey3 = GlobalKey<FormState>();
  GlobalKey<FormState> formKey4 = GlobalKey<FormState>();

  // List<String> daysList = [
  //   AppStrings.selectADay,
  //   AppStrings.saturday,
  //   AppStrings.sunday,
  //   AppStrings.monday,
  //   AppStrings.tuesday,
  //   AppStrings.wednesday,
  //   AppStrings.thursday,
  //   AppStrings.friday,
  // ];
  //
  // RxString selectedStartDay = AppStrings.selectADay.obs;
  // RxString selectedEndDay = AppStrings.selectADay.obs;

  City? selectedCity;
  //
  // RxBool isStartDayError = false.obs;
  // RxBool isEndDayError = false.obs;
  RxBool isCityError = false.obs;

  List<Map<String, dynamic>> centerTypes = [
    {"type": AppStrings.nursing, "isChecked": false.obs},
    {"type": AppStrings.educational, "isChecked": false.obs},
    {"type": AppStrings.supportAndRehabilitation, "isChecked": false.obs},
  ];

  // List<Map<String, dynamic>> services = [
  //   {"type": AppStrings.nursing, "isChecked": false.obs},
  //   {"type": AppStrings.educational, "isChecked": false.obs},
  //   {"type": AppStrings.kindergarten, "isChecked": false.obs},
  //   {"type": AppStrings.afterSchool, "isChecked": false.obs},
  //   {"type": AppStrings.specialNeeds, "isChecked": false.obs},
  //   {"type": AppStrings.physicalTherapy, "isChecked": false.obs},
  //   {"type": AppStrings.speechTherapy, "isChecked": false.obs},
  //   {"type": AppStrings.occupationalTherapy, "isChecked": false.obs},
  // ];
  //
  // List<Map<String, dynamic>> commWays = [
  //   {"type": AppStrings.voiceCommunication, "isChecked": false.obs},
  //   {"type": AppStrings.textCommunication, "isChecked": false.obs},
  //   {"type": AppStrings.visualCommunication, "isChecked": false.obs},
  // ];
  //
  // List<Map<String, dynamic>> ages = [
  //   {"type": AppStrings.from0To3Years, "isChecked": false.obs},
  //   {"type": AppStrings.from3To6Years, "isChecked": false.obs},
  //   {"type": AppStrings.childrenWithSpecialNeeds, "isChecked": false.obs},
  // ];

  // List<String> getSelectedAges(List<Map<String, dynamic>> ages) {
  //   return ages
  //       .where((element) => (element['isChecked'] as RxBool).value)
  //       .map((element) => element['type'].toString() == AppStrings.from0To3Years
  //           ? "0-3"
  //           : element['type'].toString() == AppStrings.from3To6Years
  //               ? "3-6"
  //               : "disabled")
  //       .toList();
  // }

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

  // List<String> getSelectedCommWays(List<Map<String, dynamic>> commWays) {
  //   return commWays
  //       .where((element) => (element['isChecked'] as RxBool).value)
  //       .map((element) =>
  //           element['type'].toString() == AppStrings.voiceCommunication
  //               ? "phone"
  //               : element['type'].toString() == AppStrings.textCommunication
  //                   ? "sms"
  //                   : "video")
  //       .toList();
  // }
  //
  // List<String> getSelectedServices(List<Map<String, dynamic>> services) {
  //   return services
  //       .where((element) => (element['isChecked'] as RxBool).value)
  //       .map((element) => element['type'].toString())
  //       .toList();
  // }

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
  // RxString selectedValue = ''.obs;
  // RxString selectedValue2 = ''.obs;
  File? practiceLicenceFile;
  File? commercialRegisterFile;
  File? logo;
  // TimeOfDay? startTime;
  // TimeOfDay? endTime;
  // TimeOfDay? startTimeFirstPeriod;
  // TimeOfDay? startTimeSecondPeriod;

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

  // RxList<FirstMeals> firstPeriodMeals =
  //     <FirstMeals>[FirstMeals(mealName: "", components: "", juice: "")].obs;
  //
  // RxList<FirstMeals> secondPeriodMeals =
  //     <FirstMeals>[FirstMeals(mealName: "", components: "", juice: "")].obs;

  SignupResponseModel? signupResponseModel;
  RxBool isRegistering = false.obs;
  onRegisterClicked(BuildContext context) async {
    // change(false, status: RxStatus.loading());
    isRegistering.value = true;
    SignupRequestModel signupRequestModel = SignupRequestModel(
      notes: notes.text,
      // timeOfFirstPeriod: formatTime(startTimeFirstPeriod ?? TimeOfDay.now()),
      // timeOfSecondPeriod: formatTime(startTimeSecondPeriod ?? TimeOfDay.now()),
      password: password.text,
      email: email.text,
      // address: "${street.text} - ${neighborhood.text}",
      nurseryName: name.text,
      name: name.text,
      phone: mobileNumber.text,
      cityID: (selectedCity?.id ?? 0).toString(),
      location: locationLink.text,
      nurseryType: getSelectedTypes(centerTypes),
      // services: getSelectedServices(services),
      // firstMeals:
      //     selectedValue2.value == AppStrings.no ? null : firstPeriodMeals,
      // secondMeals:
      //     selectedValue2.value == AppStrings.no ? null : secondPeriodMeals,
      neighborhood: neighborhood.text,
      // workDaysFrom: selectedStartDay.value,
      // workDaysTo: selectedEndDay.value,
      // workHoursFrom: formatTime(startTime!),
      // workHoursTo: formatTime(endTime!),
      // additionalService: service.text,
      // providesFood: selectedValue2.value == AppStrings.yes ? true : false,
      // specialNeeds: selectedValue.value == AppStrings.yes ? true : false,
      // communicationMethods: getSelectedCommWays(commWays),
      // acceptedAges: getSelectedAges(ages),
      // emergencyContact: false,
    );
    signupRepository.signup(signupRequestModel, practiceLicenceFile, commercialRegisterFile, logo).then(
      (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          signupResponseModel = null;
          signupResponseModel = value.body;
          await onLoginClicked();
        }
        isRegistering.value = false;
      },
    ).onError((error, stackTrace) {
      print("Signup error: $error");
      print("StackTrace: $stackTrace");
      customSnackBar(error.toString(), ColorCode.danger600);
      // change(true, status: RxStatus.success());
      isRegistering.value = false;
    });
  }

  Future<void> onLoginClicked() async {
    change(false, status: RxStatus.loading());

    try {
      final value = await signupRepository.login(LoginRequest(
        email: email.text.trim(),
        password: password.text,
      ));

      AuthService.to.isGuest = false;
      update();

      if (value.body!.user!.role == "branch_admin") {
        Get.offAllNamed(Routes.CONTROL_PANEL_SCREEN);
      } else {
        Get.offAllNamed(Routes.BOTTOM_NAVIGATION);
      }
    } catch (error) {
      customSnackBar(error.toString(), ColorCode.danger600);
    } finally {
      change(false, status: RxStatus.success());
    }
  }

  List<City> cities = [];

  Future<void> getCities() async {
    change(false, status: RxStatus.loading());
    signupRepository.getCities().then(
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

  @override
  void onInit() async {
    change(true, status: RxStatus.success());
    await getCities();
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
}
