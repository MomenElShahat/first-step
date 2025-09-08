import 'package:get/get.dart';

import '../data/center_details_parent_api_provider.dart';
import '../data/center_details_parent_repository.dart';
import '../presentation/controllers/center_details_parent_controller.dart';


class CenterDetailsParentBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ICenterDetailsParentProvider>(CenterDetailsParentProvider());
    Get.put<ICenterDetailsParentRepository>(CenterDetailsParentRepository(provider: Get.find()));
    Get.put(CenterDetailsParentController(centerDetailsParentRepository: Get.find()));


  }
}
