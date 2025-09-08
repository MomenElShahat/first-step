import 'package:get/get.dart';

import '../data/home_parent_api_provider.dart';
import '../data/home_parent_repository.dart';
import '../presentation/controllers/home_parent_controller.dart';


class HomeParentBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<IHomeParentProvider>(HomeParentProvider());
    Get.put<IHomeParentRepository>(HomeParentRepository(provider: Get.find()));
    Get.put(HomeParentController(homeParentRepository: Get.find()));


  }
}
