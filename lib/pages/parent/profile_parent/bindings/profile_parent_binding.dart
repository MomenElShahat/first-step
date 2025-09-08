import 'package:get/get.dart';

import '../data/profile_parent_api_provider.dart';
import '../data/profile_parent_repository.dart';
import '../presentation/controllers/profile_parent_controller.dart';

class ProfileParentBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<IProfileParentProvider>(ProfileParentProvider());
    Get.put<IProfileParentRepository>(ProfileParentRepository(provider: Get.find()));
    Get.put(ProfileParentController(profileParentRepository: Get.find()));


  }
}
