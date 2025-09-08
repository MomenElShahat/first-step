import 'package:get/get.dart';
import 'package:first_step/pages/daily_report_details/data/daily_report_details_api_provider.dart';
import 'package:first_step/pages/daily_report_details/data/daily_report_details_repository.dart';
import 'package:first_step/pages/daily_report_details/presentation/controller/daily_report_details_controller.dart';

class DailyReportDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<IDailyReportDetailsProvider>(DailyReportDetailsProvider());
    Get.put<IDailyReportDetailsRepository>(DailyReportDetailsRepository(provider: Get.find()));
    Get.put(DailyReportDetailsController(dailyReportDetailsRepository: Get.find()));
  }
}
