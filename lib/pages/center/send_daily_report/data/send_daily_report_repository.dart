import 'package:first_step/pages/center/send_daily_report/data/send_daily_report_api_provider.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import '../../../../base/base_repositroy.dart';
import '../model/send_report_request_model.dart';
import '../model/send_report_response_model.dart';

abstract class ISendDailyReportRepository {
  Future<Response<SendReportResponseModel>> sendReport(SendReportRequestModel sendReportRequestModel);
}

class SendDailyReportRepository extends BaseRepository implements ISendDailyReportRepository {
  SendDailyReportRepository({required this.provider});

  final ISendDailyReportProvider provider;

  @override
  Future<Response<SendReportResponseModel>> sendReport(SendReportRequestModel sendReportRequestModel)async {
    final apiResponse =
    await provider.sendReport(sendReportRequestModel);
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
