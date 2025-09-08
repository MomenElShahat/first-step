import 'package:get/get.dart';

import '../data/edit_child_details_api_provider.dart';
import '../data/edit_child_details_repository.dart';
import '../presentation/controllers/edit_child_details_controller.dart';

class EditChildDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<IEditChildDetailsProvider>(EditChildDetailsProvider());
    Get.put<IEditChildDetailsRepository>(EditChildDetailsRepository(provider: Get.find()));
    Get.put(EditChildDetailsScreenController(editChildDetailsRepository: Get.find()));
  }
}
