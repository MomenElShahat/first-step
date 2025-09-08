import 'package:get/get.dart';
import 'package:first_step/pages/payment_success/data/payment_success_api_provider.dart';
import 'package:first_step/pages/payment_success/data/payment_success_repository.dart';
import 'package:first_step/pages/payment_success/presentation/controller/payment_success_controller.dart';

class PaymentSuccessBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<IPaymentSuccessProvider>(PaymentSuccessProvider());
    Get.put<IPaymentSuccessRepository>(PaymentSuccessRepository(provider: Get.find()));
    Get.put(PaymentSuccessController(paymentSuccessRepository: Get.find()));
  }
}
