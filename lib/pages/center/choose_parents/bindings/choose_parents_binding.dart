import 'package:get/get.dart';

import '../data/choose_parents_api_provider.dart';
import '../data/choose_parents_repository.dart';
import '../presentation/controller/choose_parents_controller.dart';

class ChooseParentsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<IChooseParentsProvider>(ChooseParentsProvider());
    Get.put<IChooseParentsRepository>(ChooseParentsRepository(provider: Get.find()));
    Get.put(ChooseParentsController(chooseParentsRepository: Get.find()));
  }
}
