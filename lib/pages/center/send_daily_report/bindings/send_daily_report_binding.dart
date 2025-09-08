import 'package:get/get.dart';
import '../data/send_daily_report_api_provider.dart';
import '../data/send_daily_report_repository.dart';
import '../presentation/controller/send_daily_report_controller.dart';

class SendDailyReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ISendDailyReportProvider>(SendDailyReportProvider());
    Get.put<ISendDailyReportRepository>(SendDailyReportRepository(provider: Get.find()));
    Get.put(SendDailyReportController(sendDailyReportRepository: Get.find()));
  }
}
