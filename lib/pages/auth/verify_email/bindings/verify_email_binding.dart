import 'package:get/get.dart';

import '../data/verify_email_api_provider.dart';
import '../data/verify_email_repository.dart';
import '../presentation/controllers/verify_email_controller.dart';

class VerifyEmailBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<IVerifyEmailProvider>(VerifyEmailProvider());
    Get.put<IVerifyEmailRepository>(VerifyEmailRepository(provider: Get.find()));
    Get.put(VerifyEmailController(verifyEmailRepository: Get.find()));


  }
}
