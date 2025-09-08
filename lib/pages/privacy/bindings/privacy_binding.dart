import 'package:get/get.dart';
import '../data/privacy_api_provider.dart';
import '../data/privacy_repository.dart';
import '../presentation/controller/privacy_controller.dart';

class PrivacyBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<IPrivacyProvider>(PrivacyProvider());
    Get.put<IPrivacyRepository>(PrivacyRepository(provider: Get.find()));
    Get.put(PrivacyController(privacyRepository: Get.find()));
  }
}
