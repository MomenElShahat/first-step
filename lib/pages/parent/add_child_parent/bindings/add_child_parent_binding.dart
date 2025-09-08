import 'package:get/get.dart';

import '../data/add_child_parent_api_provider.dart';
import '../data/add_child_parent_repository.dart';
import '../presentation/controller/add_child_parent_controller.dart';

class AddChildParentBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<IAddChildParentProvider>(AddChildParentProvider());
    Get.put<IAddChildParentRepository>(AddChildParentRepository(provider: Get.find()));
    Get.put(AddChildParentController(addChildParentRepository: Get.find()));
  }
}
