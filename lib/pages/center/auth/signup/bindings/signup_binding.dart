import 'package:get/get.dart';

import '../data/signup_api_provider.dart';
import '../data/signup_repository.dart';
import '../presentation/controllers/signup_controller.dart';

class SignupBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ISignupProvider>(SignupProvider());
    Get.put<ISignupRepository>(SignupRepository(provider: Get.find()));
    Get.put(SignupController(signupRepository: Get.find()));


  }
}
