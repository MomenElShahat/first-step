import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:first_step/pages/daily_report_details/data/daily_report_details_repository.dart';
import 'package:first_step/resources/strings_generated.dart';
import '../../../../consts/colors.dart';
import '../../../../widgets/custom_snackbar.dart';
import '../../../parent/control_panel_parent/models/daily_reports_model.dart';
import '../../model/daily_reports_model.dart';

class DailyReportDetailsController extends SuperController<bool> {
  DailyReportDetailsController({required this.dailyReportDetailsRepository});

  final IDailyReportDetailsRepository dailyReportDetailsRepository;

  TextEditingController dailyActivities = TextEditingController();
  TextEditingController behavior = TextEditingController();
  TextEditingController meals = TextEditingController();
  TextEditingController dailyNap = TextEditingController();
  TextEditingController notes = TextEditingController();

  DailyReportsDetailsModel? report;
  String? reportId;

  getReport() async {
    change(false, status: RxStatus.loading());
    dailyReportDetailsRepository.getReport(reportId ?? "").then(
      (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          dailyActivities.text =
              report?.data?.activities ?? AppStrings.notFound;
          behavior.text = report?.data?.behavior ?? AppStrings.notFound;
          meals.text = report?.data?.meals ?? AppStrings.notFound;
          dailyNap.text = report?.data?.napTime ?? AppStrings.notFound;
          notes.text = report?.data?.notes ?? AppStrings.notFound;
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
    var args = Get.arguments;
    reportId = args;
    await getReport();
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
