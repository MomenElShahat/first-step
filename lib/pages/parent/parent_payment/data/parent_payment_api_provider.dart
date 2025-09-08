import 'package:first_step/base/base_auth_provider.dart';
import 'package:first_step/services/auth_service.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import '../../../../base/api_end_points.dart';
import '../model/payment_url_model.dart';

abstract class IParentPaymentProvider {
  Future<Response<PaymentUrlModel>> getPaymentUrl(String enrollmentId);
}

class ParentPaymentProvider extends BaseAuthProvider
    implements IParentPaymentProvider {
  @override
  Future<Response<PaymentUrlModel>> getPaymentUrl(String enrollmentId) {
    return post<PaymentUrlModel>(
        AuthService.to.userInfo?.user?.role == "parent"
            ? EndPoints.paymentPayOrder
            : EndPoints.paymentSubscribe,
        AuthService.to.userInfo?.user?.role == "parent"
            ? {"enrollment_id": enrollmentId}
            : {"plan_id": enrollmentId},
        decoder: PaymentUrlModel.fromJson);
  }
}
