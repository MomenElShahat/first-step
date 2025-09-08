import 'package:get/get.dart';

import '../data/add_child_api_provider.dart';
import '../data/add_child_repository.dart';
import '../presentation/controllers/add_child_controller.dart';

class AddChildBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<IAddChildProvider>(AddChildProvider());
    Get.put<IAddChildRepository>(AddChildRepository(provider: Get.find()));
    Get.put(AddChildController(addChildRepository: Get.find()));


  }
}
