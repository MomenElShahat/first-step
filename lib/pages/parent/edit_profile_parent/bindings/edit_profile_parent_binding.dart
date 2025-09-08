import 'package:get/get.dart';

import '../data/edit_profile_parent_api_provider.dart';
import '../data/edit_profile_parent_repository.dart';
import '../presentation/controller/edit_profile_parent_controller.dart';

class EditProfileParentBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<IEditProfileParentProvider>(EditProfileParentProvider());
    Get.put<IEditProfileParentRepository>(EditProfileParentRepository(provider: Get.find()));
    Get.put(EditProfileParentController(editProfileParentRepository: Get.find()));
  }
}
