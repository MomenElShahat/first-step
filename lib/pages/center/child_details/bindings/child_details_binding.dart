import 'package:get/get.dart';

import '../data/child_details_api_provider.dart';
import '../data/child_details_repository.dart';
import '../presentation/controllers/child_details_controller.dart';

class ChildDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<IChildDetailsProvider>(ChildDetailsProvider());
    Get.put<IChildDetailsRepository>(ChildDetailsRepository(provider: Get.find()));
    Get.put(ChildDetailsScreenController(childDetailsRepository: Get.find()));
  }
}
