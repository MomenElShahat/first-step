import 'package:get/get.dart';
import 'package:first_step/pages/faq/data/faq_api_provider.dart';
import 'package:first_step/pages/faq/data/faq_repository.dart';
import 'package:first_step/pages/faq/presentation/controller/faq_controller.dart';

class FaqBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<IFaqProvider>(FaqProvider());
    Get.put<IFaqRepository>(FaqRepository(provider: Get.find()));
    Get.put(FaqController(faqRepository: Get.find()));
  }
}
