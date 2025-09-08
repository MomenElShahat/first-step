import 'package:get/get.dart';

import '../data/signup_parent_api_provider.dart';
import '../data/signup_parent_repository.dart';
import '../presentation/controllers/signup_parent_controller.dart';

class SignupParentBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ISignupParentProvider>(SignupParentProvider());
    Get.put<ISignupParentRepository>(SignupParentRepository(provider: Get.find()));
    Get.put(SignupParentController(signupParentRepository: Get.find()));


  }
}
