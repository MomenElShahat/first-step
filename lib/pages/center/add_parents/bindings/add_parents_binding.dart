import 'package:get/get.dart';

import '../data/add_parents_api_provider.dart';
import '../data/add_parents_repository.dart';
import '../presentation/controller/add_parents_controller.dart';

class AddParentsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<IAddParentsProvider>(AddParentsProvider());
    Get.put<IAddParentsRepository>(AddParentsRepository(provider: Get.find()));
    Get.put(AddParentsController(addParentsRepository: Get.find()));
  }
}
