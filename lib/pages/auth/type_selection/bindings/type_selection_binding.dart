import 'package:get/get.dart';

import '../data/type_selection_api_provider.dart';
import '../data/type_selection_repository.dart';
import '../presentation/controllers/type_selection_controller.dart';

class TypeSelectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ITypeSelectionProvider>(TypeSelectionProvider());
    Get.put<ITypeSelectionRepository>(TypeSelectionRepository(provider: Get.find()));
    Get.put(TypeSelectionController(typeSelectionRepository: Get.find()));


  }
}
