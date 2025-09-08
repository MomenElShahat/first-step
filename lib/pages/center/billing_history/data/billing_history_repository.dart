
import 'package:get/get_connect/http/src/response/response.dart';

import '../../../../base/base_repositroy.dart';
import '../../home/model/plans_model.dart';
import '../model/billing_history_model.dart';
import 'billing_history_api_provider.dart';

abstract class IBillingHistoryRepository {
  Future<Response<BillingHistoryModel>> getHistoryPayment();
}

class BillingHistoryRepository extends BaseRepository implements IBillingHistoryRepository {
  BillingHistoryRepository({required this.provider});

  final IBillingHistoryProvider provider;


  @override
  Future<Response<BillingHistoryModel>> getHistoryPayment() async {
    final apiResponse = await provider.getHistoryPayment();
    print(apiResponse.bodyString);
    if (apiResponse.isOk && apiResponse.body != null && (apiResponse.statusCode == 200) || apiResponse.statusCode == 201) {
      return apiResponse;
    } else {
      print(apiResponse.bodyString);
      print(apiResponse.statusCode);
      throw (getErrorMessage(apiResponse.bodyString!));
    }
  }
}
