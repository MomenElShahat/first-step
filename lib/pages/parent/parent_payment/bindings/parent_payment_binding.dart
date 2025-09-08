import 'package:get/get.dart';

import '../data/parent_payment_api_provider.dart';
import '../data/parent_payment_repository.dart';
import '../presentation/controller/parent_payment_controller.dart';

class ParentPaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<IParentPaymentProvider>(ParentPaymentProvider());
    Get.put<IParentPaymentRepository>(ParentPaymentRepository(provider: Get.find()));
    Get.put(ParentPaymentController(parentPaymentRepository: Get.find()));
  }
}
