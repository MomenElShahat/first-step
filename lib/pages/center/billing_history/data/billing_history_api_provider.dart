import 'package:first_step/base/base_auth_provider.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import '../../../../base/api_end_points.dart';
import '../../home/model/plans_model.dart';
import '../model/billing_history_model.dart';

abstract class IBillingHistoryProvider {
  Future<Response<BillingHistoryModel>> getHistoryPayment();
}

class BillingHistoryProvider extends BaseAuthProvider implements IBillingHistoryProvider {

  @override
  Future<Response<BillingHistoryModel>> getHistoryPayment() {
    return get<BillingHistoryModel>(
      EndPoints.getHistoryPayment,
      decoder: BillingHistoryModel.fromJson,
    );
  }
}
