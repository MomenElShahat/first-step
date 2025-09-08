import 'package:get/get.dart';

import '../data/center_free_trail_api_provider.dart';
import '../data/center_free_trail_repository.dart';
import '../presentation/controller/center_free_trail_controller.dart';

class CenterFreeTrailBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ICenterFreeTrailProvider>(CenterFreeTrailProvider());
    Get.put<ICenterFreeTrailRepository>(CenterFreeTrailRepository(provider: Get.find()));
    Get.put(CenterFreeTrailController(centerFreeTrailRepository: Get.find()));
  }
}
