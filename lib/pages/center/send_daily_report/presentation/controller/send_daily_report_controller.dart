import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../consts/colors.dart';
import '../../../../../widgets/custom_snackbar.dart';
import '../../data/send_daily_report_repository.dart';
import '../../model/send_report_request_model.dart';

class SendDailyReportController extends SuperController<bool> {
  SendDailyReportController({required this.sendDailyReportRepository});

  final ISendDailyReportRepository sendDailyReportRepository;

  TextEditingController dailyActivities = TextEditingController();
  TextEditingController behavior = TextEditingController();
  TextEditingController meals = TextEditingController();
  TextEditingController dailyNap = TextEditingController();
  TextEditingController notes = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  List<int>? childIds;

  RxBool isSending = false.obs;
  onSendReportClicked() async {
    isSending.value = true;
    // change(false, status: RxStatus.loading());
    SendReportRequestModel sendReportRequestModel = SendReportRequestModel(
      childIds: childIds ?? [],
      activities: dailyActivities.text,
      behavior: behavior.text,
      meals: meals.text,
      napTime: dailyNap.text,
      notes: notes.text,
    );
    sendDailyReportRepository.sendReport(sendReportRequestModel).then(
      (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          customSnackBar(value.body?.message ?? "", ColorCode.success600);
          Get.back();
        } else {
          customSnackBar(value.body?.message ?? "", ColorCode.danger600);
        }
        // change(true, status: RxStatus.success());
        isSending.value = false;
      },
    ).onError((error, stackTrace) {
      print("Signup error: $error");
      print("StackTrace: $stackTrace");
      customSnackBar(error.toString(), ColorCode.danger600);
      // change(true, status: RxStatus.success());
      isSending.value = false;
    });
  }

  @override
  void onInit() {
    var args = Get.arguments;
    childIds = args;
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
