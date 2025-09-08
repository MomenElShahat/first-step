import 'package:first_step/base/base_auth_provider.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import '../../../../base/api_end_points.dart';
import '../model/send_report_request_model.dart';
import '../model/send_report_response_model.dart';

abstract class ISendDailyReportProvider {
  Future<Response<SendReportResponseModel>> sendReport(SendReportRequestModel sendReportRequestModel);
}

class SendDailyReportProvider extends BaseAuthProvider implements ISendDailyReportProvider {
  @override
  Future<Response<SendReportResponseModel>> sendReport(SendReportRequestModel sendReportRequestModel) {
    print(sendReportRequestModel.toJson());
    return post<SendReportResponseModel>(
        EndPoints.childrenDailyReports,
        sendReportRequestModel.toJson(),
        decoder: SendReportResponseModel.fromJson
    );
  }
}
