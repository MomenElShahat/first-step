import 'package:get/get.dart';

import '../data/reset_password_api_provider.dart';
import '../data/reset_password_repository.dart';
import '../presentation/controllers/reset_password_controller.dart';

class ResetPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<IResetPasswordProvider>(ResetPasswordProvider());
    Get.put<IResetPasswordRepository>(ResetPasswordRepository(provider: Get.find()));
    Get.put(ResetPasswordController(resetPasswordRepository: Get.find()));
  }
}
