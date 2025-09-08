import 'package:first_step/pages/payment_success/data/payment_success_api_provider.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import '../../../base/base_repositroy.dart';
import '../../center/home/model/plans_model.dart';

abstract class IPaymentSuccessRepository {
  Future<Response<PlansModel>> getPlans();
}

class PaymentSuccessRepository extends BaseRepository implements IPaymentSuccessRepository {
  PaymentSuccessRepository({required this.provider});

  final IPaymentSuccessProvider provider;

  @override
  Future<Response<PlansModel>> getPlans()async {
    final apiResponse =
    await provider.getPlans();
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
