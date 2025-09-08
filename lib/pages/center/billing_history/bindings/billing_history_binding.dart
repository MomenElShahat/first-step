import 'package:get/get.dart';

import '../data/billing_history_api_provider.dart';
import '../data/billing_history_repository.dart';
import '../presentation/controller/billing_history_controller.dart';

class BillingHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<IBillingHistoryProvider>(BillingHistoryProvider());
    Get.put<IBillingHistoryRepository>(BillingHistoryRepository(provider: Get.find()));
    Get.put(BillingHistoryController(billingHistoryRepository: Get.find()));
  }
}
