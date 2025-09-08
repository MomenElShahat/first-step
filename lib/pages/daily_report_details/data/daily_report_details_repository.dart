import 'package:first_step/pages/daily_report_details/data/daily_report_details_api_provider.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import '../../../base/base_repositroy.dart';
import '../model/daily_reports_model.dart';

abstract class IDailyReportDetailsRepository {
  Future<Response<DailyReportsDetailsModel>> getReport(String reportId);
}

class DailyReportDetailsRepository extends BaseRepository implements IDailyReportDetailsRepository {
  DailyReportDetailsRepository({required this.provider});

  final IDailyReportDetailsProvider provider;

  @override
  Future<Response<DailyReportsDetailsModel>> getReport(String reportId) async {
    final apiResponse =
    await provider.getReport(reportId);
    print(apiResponse.bodyString);
    if (apiResponse.isOk && apiResponse.body != null&& (apiResponse.statusCode==200) || apiResponse.statusCode==201) {
      return apiResponse;
    } else {
      print(apiResponse.bodyString);
      print(apiResponse.statusCode);
      throw (getErrorMessage(apiResponse.bodyString!));
    }
  }

}
