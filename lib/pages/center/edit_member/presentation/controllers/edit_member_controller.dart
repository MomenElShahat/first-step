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
import '../../data/edit_member_repository.dart';
import '../../models/branch_team_member_model.dart';

class EditMemberScreenController extends SuperController<dynamic> {
  EditMemberScreenController({required this.editMemberRepository});

  final IEditMemberRepository editMemberRepository;

  TextEditingController memberName = TextEditingController();
  // TextEditingController profession = TextEditingController();
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

  BranchTeamMemberModel? branchTeamMemberModel;
  BranchTeamMemberModel? editBranchTeamMemberModel;

  getBranchTeamDetails(String memberId) async {
    change(false, status: RxStatus.loading());
    editMemberRepository.getBranchTeamDetails(memberId).then(
      (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          branchTeamMemberModel = null;
          branchTeamMemberModel = value.body;
          memberName.text = branchTeamMemberModel?.data?.name ?? "";
          memberProfession.text = branchTeamMemberModel?.data?.profession ?? "";
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

  RxBool isSaving = false.obs;
  editBranchTeamDetails() async {
    isSaving.value = true;
    editMemberRepository
        .editBranchTeamDetails(profession: memberProfession.text, memberId: memberId ?? "", name: memberName.text, image: pickedImage)
        .then(
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

  String? memberId;
  @override
  void onInit() async {
    change(true, status: RxStatus.success());
    var args = Get.arguments;
    memberId = args;
    await getBranchTeamDetails(memberId!);
    super.onInit();
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
