import 'package:first_step/pages/parent/parent_payment/data/parent_payment_api_provider.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import '../../../../base/base_repositroy.dart';
import '../model/payment_url_model.dart';

abstract class IParentPaymentRepository {
  Future<Response<PaymentUrlModel>> getPaymentUrl(String enrollmentId);
}

class ParentPaymentRepository extends BaseRepository implements IParentPaymentRepository {
  ParentPaymentRepository({required this.provider});

  final IParentPaymentProvider provider;


  @override
  Future<Response<PaymentUrlModel>> getPaymentUrl(String enrollmentId)async {
    final apiResponse =
    await provider.getPaymentUrl(enrollmentId);
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
