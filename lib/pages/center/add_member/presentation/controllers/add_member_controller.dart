import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../../../../../resources/strings_generated.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

import '../../../../../consts/colors.dart';
import '../../../../../widgets/custom_snackbar.dart';
import '../../data/add_member_repository.dart';

class AddMemberScreenController extends SuperController<dynamic> {
  AddMemberScreenController({required this.addMemberRepository});

  final IAddMemberRepository addMemberRepository;

  TextEditingController memberName = TextEditingController();
  TextEditingController theBranchToWhichItBelongs = TextEditingController();
  TextEditingController memberProfession = TextEditingController();

  File? pickedImage;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      pickedImage = File(pickedFile.path);
      update();
    }
    // else do nothing; keep default image
  }

  List<Map<String, dynamic>> services = [
    {"type": AppStrings.nursing, "isChecked": false.obs},
    {"type": AppStrings.educational, "isChecked": false.obs},
    {"type": AppStrings.supportAndRehabilitation, "isChecked": false.obs},
  ];

  RxString selectedStartDay = AppStrings.sunday.obs;
  RxString selectedEndDay = AppStrings.sunday.obs;

  RxBool isStartDayError = false.obs;
  RxBool isEndDayError = false.obs;

  TimeOfDay? startTime;
  TimeOfDay? endTime;

  RxString selectedGender = AppStrings.boy.obs;

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

  RxBool isSaving = false.obs;
  addMember() async {
    isSaving.value = true;
    addMemberRepository.addMember(profession: memberProfession.text, branchId: branchId ?? "", name: memberName.text, image: pickedImage).then(
      (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          customSnackBar("Data saved successfully", ColorCode.success600);
        } else {
          customSnackBar("Data has not been saved successfully", ColorCode.danger600);
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

  String? branchId;
  @override
  void onInit() async {
    var args = Get.arguments;
    branchId = args;
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
