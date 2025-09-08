import 'package:first_step/base/base_auth_provider.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import '../../../base/api_end_points.dart';
import '../model/daily_reports_model.dart';

abstract class IDailyReportDetailsProvider {
  Future<Response<DailyReportsDetailsModel>> getReport(String reportId);
}

class DailyReportDetailsProvider extends BaseAuthProvider implements IDailyReportDetailsProvider {
  @override
  Future<Response<DailyReportsDetailsModel>> getReport(String reportId) {
    return get<DailyReportsDetailsModel>(
        "${EndPoints.getDailyReport}/$reportId",
        decoder: DailyReportsDetailsModel.fromJson
    );
  }
}
