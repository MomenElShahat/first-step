import 'package:get/get.dart';

import '../data/edit_profile_api_provider.dart';
import '../data/edit_profile_repository.dart';
import '../presentation/controller/edit_profile_controller.dart';

class EditProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<IEditProfileProvider>(EditProfileProvider());
    Get.put<IEditProfileRepository>(EditProfileRepository(provider: Get.find()));
    Get.put(EditProfileController(editProfileRepository: Get.find()));
  }
}
