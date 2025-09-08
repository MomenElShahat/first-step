import 'package:get/get.dart';

import '../data/profile_api_provider.dart';
import '../data/profile_repository.dart';
import '../presentation/controllers/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<IProfileProvider>(ProfileProvider());
    Get.put<IProfileRepository>(ProfileRepository(provider: Get.find()));
    Get.put(ProfileController(profileRepository: Get.find()));


  }
}
