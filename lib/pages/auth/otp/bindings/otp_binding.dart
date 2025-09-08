import 'package:get/get.dart';

import '../data/otp_api_provider.dart';
import '../data/otp_repository.dart';
import '../presentation/controllers/otp_controller.dart';

class OtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<IOtpProvider>(OtpProvider());
    Get.put<IOtpRepository>(OtpRepository(provider: Get.find()));
    Get.put(OtpController(otpRepository: Get.find()));


  }
}
