import 'package:get/get.dart';
import 'package:first_step/pages/terms/data/terms_api_provider.dart';
import 'package:first_step/pages/terms/data/terms_repository.dart';
import 'package:first_step/pages/terms/presentation/controller/terms_controller.dart';

class TermsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ITermsProvider>(TermsProvider());
    Get.put<ITermsRepository>(TermsRepository(provider: Get.find()));
    Get.put(TermsController(termsRepository: Get.find()));
  }
}
