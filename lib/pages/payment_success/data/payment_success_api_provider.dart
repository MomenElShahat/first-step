import 'package:first_step/base/base_auth_provider.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import '../../../base/api_end_points.dart';
import '../../center/home/model/plans_model.dart';

abstract class IPaymentSuccessProvider {
  Future<Response<PlansModel>> getPlans();
}

class PaymentSuccessProvider extends BaseAuthProvider implements IPaymentSuccessProvider {
  @override
  Future<Response<PlansModel>> getPlans() {
    return get<PlansModel>(
        EndPoints.plans,
        decoder: PlansModel.fromJson
    );
  }
}
