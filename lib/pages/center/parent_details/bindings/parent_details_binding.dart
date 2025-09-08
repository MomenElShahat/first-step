import 'package:get/get.dart';

import '../data/parent_details_api_provider.dart';
import '../data/parent_details_repository.dart';
import '../presentation/controllers/parent_details_controller.dart';

class ParentDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<IParentDetailsProvider>(ParentDetailsProvider());
    Get.put<IParentDetailsRepository>(ParentDetailsRepository(provider: Get.find()));
    Get.put(ParentDetailsScreenController(parentDetailsRepository: Get.find()));
  }
}
